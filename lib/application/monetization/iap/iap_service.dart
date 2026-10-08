import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../analytics/analytics_event.dart';
import '../../analytics/analytics_service.dart';
import 'entitlement_state.dart';
import 'purchase_verifier.dart';

enum PurchaseStatusType {
  idle,
  loading,
  purchasing,
  restoring,
  success,
  error,
}

class IapService {
  final InAppPurchase _iap;
  final SettingsRepository _settingsRepository;
  final AnalyticsService _analyticsService;
  final PurchaseVerifier _verifier;
  final EntitlementState entitlementState;

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final Set<String> _processedTransactions = {};

  PurchaseStatusType _status = PurchaseStatusType.idle;
  String? _errorMessage;

  final _statusController = StreamController<PurchaseStatusType>.broadcast();

  IapService({
    InAppPurchase? iap,
    required this._settingsRepository,
    required this._analyticsService,
    PurchaseVerifier? verifier,
    required this.entitlementState,
  })  : _iap = iap ?? InAppPurchase.instance,
        _verifier = verifier ?? SandboxPurchaseVerifier();

  PurchaseStatusType get status => _status;
  String? get errorMessage => _errorMessage;
  Stream<PurchaseStatusType> get statusStream => _statusController.stream;

  Future<void> initialize() async {
    // 1. Load cached entitlement from local database
    final cachedEntitled = await _settingsRepository.isAdsFreeEntitled();
    entitlementState.setAdsFree(cachedEntitled);

    // 2. Listen to platform purchase updates stream
    _subscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => _subscription?.cancel(),
      onError: (err) {
        _setStatus(PurchaseStatusType.error, err.toString());
      },
    );
  }

  Future<bool> isStoreAvailable() async {
    return _iap.isAvailable();
  }

  Future<ProductDetails?> getProductDetails(String productId) async {
    final response = await _iap.queryProductDetails({productId});
    if (response.productDetails.isNotEmpty) {
      return response.productDetails.first;
    }
    return null;
  }

  Future<void> buyAdsFree() async {
    _setStatus(PurchaseStatusType.purchasing);
    await _analyticsService.logEvent(AnalyticsEventType.iapPurchaseStarted, {
      'product_id': AppConstants.adsFreeProductId,
    });

    try {
      final available = await _iap.isAvailable();
      if (!available) {
        _setStatus(
          PurchaseStatusType.error,
          'Store is currently unavailable. Check your connection or store login.',
        );
        return;
      }

      final response = await _iap.queryProductDetails({AppConstants.adsFreeProductId});
      if (response.productDetails.isEmpty) {
        // Fallback for mock/development environment if store product is not configured
        final mockProduct = ProductDetails(
          id: AppConstants.adsFreeProductId,
          title: 'Ads Free (Lifetime)',
          description: 'Remove all banner and interstitial advertisements forever.',
          price: '\$2.99',
          rawPrice: 2.99,
          currencyCode: 'USD',
        );
        final purchaseParam = PurchaseParam(productDetails: mockProduct);
        await _iap.buyNonConsumable(purchaseParam: purchaseParam);
        return;
      }

      final product = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: product);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _setStatus(PurchaseStatusType.error, e.toString());
      await _analyticsService.logEvent(AnalyticsEventType.iapPurchaseFailed, {
        'product_id': AppConstants.adsFreeProductId,
        'error': e.toString(),
      });
    }
  }

  Future<void> restorePurchases() async {
    _setStatus(PurchaseStatusType.restoring);
    try {
      await _iap.restorePurchases();
    } catch (e) {
      _setStatus(PurchaseStatusType.error, e.toString());
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchase in purchaseDetailsList) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _setStatus(PurchaseStatusType.purchasing);
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          await _processVerifiedPurchase(purchase);
          break;

        case PurchaseStatus.error:
          _setStatus(PurchaseStatusType.error, purchase.error?.message ?? 'Purchase error');
          await _analyticsService.logEvent(AnalyticsEventType.iapPurchaseFailed, {
            'product_id': purchase.productID,
            'error': purchase.error?.message,
          });
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.canceled:
          _setStatus(PurchaseStatusType.idle);
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          break;
      }
    }
  }

  Future<void> _processVerifiedPurchase(PurchaseDetails purchase) async {
    // Idempotency check: prevent duplicate processing of the same transaction
    final transactionId = purchase.purchaseID ?? purchase.transactionDate ?? 'tx_${purchase.productID}';
    if (_processedTransactions.contains(transactionId)) {
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
      return;
    }

    // Server or sandbox verification boundary
    final verification = await _verifier.verify(
      productId: purchase.productID,
      purchaseID: transactionId,
      verificationData: purchase.verificationData.serverVerificationData,
      source: purchase.verificationData.source,
    );

    if (verification.isValid) {
      _processedTransactions.add(transactionId);

      // Persist verified entitlement locally
      if (purchase.productID == AppConstants.adsFreeProductId) {
        await _settingsRepository.setAdsFreeEntitled(
          true,
          transactionId: transactionId,
          signature: verification.signature,
        );
        entitlementState.setAdsFree(true);

        await _analyticsService.logEvent(AnalyticsEventType.iapPurchaseVerified, {
          'product_id': purchase.productID,
          'transaction_id': transactionId,
        });
        await _analyticsService.logEvent(AnalyticsEventType.adsFreeActivated, {
          'product_id': purchase.productID,
        });
      }

      _setStatus(PurchaseStatusType.success);
    } else {
      _setStatus(PurchaseStatusType.error, verification.errorMessage ?? 'Verification failed');
      await _analyticsService.logEvent(AnalyticsEventType.iapPurchaseFailed, {
        'product_id': purchase.productID,
        'reason': 'verification_failed',
      });
    }

    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  void _setStatus(PurchaseStatusType status, [String? error]) {
    _status = status;
    _errorMessage = error;
    _statusController.add(status);
  }

  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }
}
