# Number Match — Monetization & In-App Purchase Setup Guide

## 1. Monetization Overview

The game employs a balanced hybrid monetization model:
1. **Ads Free (Lifetime)**: Permanent non-consumable IAP (`com.numbermatch.game.ads_free`).
2. **Interstitial Ads**: Displayed exclusively at natural game breaks (post-round results screen, returning to menu). Interstitials are subject to a minimum cooldown timer (120 seconds) and are completely suppressed for Ads Free owners.
3. **Rewarded Video Ads**: Optional, player-initiated ads that award +100 Coins for hints. Ads Free owners receive an instant free claim perk without watching ads.

---

## 2. In-App Purchase Configuration

### 2.1 Product Identifiers
- **Android (Google Play Console)**:
  - Product ID: `com.numbermatch.game.ads_free`
  - Type: In-App Product (Non-Consumable)
  - Price: \$2.99 USD
- **iOS (Apple App Store Connect)**:
  - Product ID: `com.numbermatch.game.ads_free`
  - Type: Non-Consumable
  - Price Tier: Tier 3 (\$2.99 USD)

### 2.2 Entitlement Architecture & Verification Boundary
```
[Client App]
   │
   ├─► 1. StoreKit / Google Billing (in_app_purchase)
   │      └─ Returns purchase details & verificationData
   │
   ├─► 2. PurchaseVerifier (lib/application/monetization/iap/purchase_verifier.dart)
   │      ├─ Development/Sandbox: SandboxPurchaseVerifier
   │      └─ Production Live: ProductionServerPurchaseVerifier
   │
   └─► 3. Local Offline Cache (Drift SQLite EntitlementsTable)
          └─ Stores verified state, signature, and transactionId
```

### 2.3 What Remains to Activate Live Production Billing

To switch from the sandbox/development environment to live production billing:

1. **Configure Backend Verifier**:
   - In `lib/application/providers.dart`, instantiate `ProductionServerPurchaseVerifier`:
     ```dart
     final iapServiceProvider = Provider<IapService>((ref) {
       return IapService(
         settingsRepository: ref.watch(settingsRepositoryProvider),
         analyticsService: ref.watch(analyticsServiceProvider),
         entitlementState: ref.watch(entitlementStateProvider),
         verifier: const ProductionServerPurchaseVerifier(
           backendUrl: 'https://api.yourdomain.com/v1/iap/verify',
         ),
       );
     });
     ```
2. **Server-Side Verification Contract**:
   - **Google Play**: Server invokes Google Play Developer API (`purchases.products.get`) using Service Account credentials.
   - **Apple App Store**: Server invokes App Store Server API v2 (`https://api.storekit.itunes.apple.com/inApps/v2/transactions/{transactionId}`).
3. **Register Product IDs in Store Consoles**:
   - Ensure the app package identifier matches `com.numbermatch.game`.

---

## 3. Advertising Setup

### 3.1 Google AdMob App IDs
To switch from `MockAdProvider` to live Google Mobile Ads:
1. In `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="com.google.android.gms.ads.APPLICATION_ID"
       android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
   ```
2. In `ios/Runner/Info.plist`:
   ```xml
   <key>GADApplicationIdentifier</key>
   <string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
   ```
3. Add `google_mobile_ads` adapter implementing `AdProvider`.
