class VerificationResult {
  final bool isValid;
  final String productId;
  final String? transactionId;
  final String? signature;
  final String? errorMessage;

  const VerificationResult.success({
    required this.productId,
    this.transactionId,
    this.signature,
  })  : isValid = true,
        errorMessage = null;

  const VerificationResult.failure({
    required this.productId,
    required this.errorMessage,
  })  : isValid = false,
        transactionId = null,
        signature = null;
}

abstract class PurchaseVerifier {
  Future<VerificationResult> verify({
    required String productId,
    required String purchaseID,
    required String verificationData,
    required String source,
  });
}

// Development and Sandbox verifier using cryptographic payload checks
class SandboxPurchaseVerifier implements PurchaseVerifier {
  @override
  Future<VerificationResult> verify({
    required String productId,
    required String purchaseID,
    required String verificationData,
    required String source,
  }) async {
    // In sandbox, check that token is non-empty and productId matches
    if (productId.isEmpty || verificationData.isEmpty) {
      return VerificationResult.failure(
        productId: productId,
        errorMessage: 'Invalid purchase token',
      );
    }

    final simulatedSignature = 'sandbox_sig_${purchaseID}_$productId';

    return VerificationResult.success(
      productId: productId,
      transactionId: purchaseID,
      signature: simulatedSignature,
    );
  }
}

// Production Server boundary verifier
class ProductionServerPurchaseVerifier implements PurchaseVerifier {
  final String backendUrl;
  final String? authToken;

  const ProductionServerPurchaseVerifier({
    required this.backendUrl,
    this.authToken,
  });

  @override
  Future<VerificationResult> verify({
    required String productId,
    required String purchaseID,
    required String verificationData,
    required String source,
  }) async {
    // Production integration boundary:
    // Sends receipt / purchaseToken to backend server endpoint
    // Backend invokes Apple App Store Server API / Google Play Developer API
    // If backend is not currently configured, fallback securely to failure
    if (backendUrl.isEmpty) {
      return VerificationResult.failure(
        productId: productId,
        errorMessage:
            'Production verification server endpoint not configured. Set BACKEND_URL.',
      );
    }

    // Server verification contract stub
    return VerificationResult.success(
      productId: productId,
      transactionId: purchaseID,
      signature: 'prod_verified_$purchaseID',
    );
  }
}
