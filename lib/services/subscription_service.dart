import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:premium_vpn/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  // Product IDs from your app store
  static const String _monthlySubscriptionId = 'premium_vpn_monthly';
  static const String _yearlySubscriptionId = 'premium_vpn_yearly';

  Future<bool> checkPremiumStatus(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        bool isPremium = data['isPremium'] ?? false;
        if (isPremium) {
          DateTime? expiry = (data['premiumExpiry'] as Timestamp?)?.toDate();
          if (expiry != null && expiry.isAfter(DateTime.now())) {
            return true;
          } else {
            // Subscription expired
            await _firestore.collection('users').doc(userId).update({
              'isPremium': false,
            });
            return false;
          }
        }
      }
      return false;
    } catch (e) {
      print('Error checking premium status: $e');
      return false;
    }
  }

  Future<List<ProductDetails>> getAvailableSubscriptions() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      return [];
    }

    const Set<String> kIds = {_monthlySubscriptionId, _yearlySubscriptionId};
    final ProductDetailsResponse response = await _inAppPurchase
        .queryProductDetails(kIds);

    if (response.notFoundIDs.isNotEmpty) {
      print('Subscription products not found: ${response.notFoundIDs}');
    }

    return response.productDetails;
  }

  Future<bool> purchaseSubscription(ProductDetails productDetails) async {
    try {
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

      // Listen to purchase updates to verify the purchase
      // In a real app, you would verify the purchase with your backend
      // and update the user's premium status in Firestore

      return true;
    } catch (e) {
      print('Error purchasing subscription: $e');
      return false;
    }
  }

  Future<void> updatePremiumStatus(
    String userId,
    bool isPremium,
    DateTime? expiryDate,
  ) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isPremium': isPremium,
        'premiumExpiry': expiryDate,
      });
    } catch (e) {
      print('Error updating premium status: $e');
    }
  }
}
