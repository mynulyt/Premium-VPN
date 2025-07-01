import 'package:flutter/material.dart';
import 'package:pree_vpn/constants/app_color.dart';
import 'package:provider/provider.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionController = Provider.of<SubscriptionController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(Strings.premium)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.star, size: 100, color: AppColors.accentColor),
            const SizedBox(height: 20),
            const Text(
              Strings.goPremium,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              Strings.premiumFeatures,
              style: TextStyle(fontSize: 16, color: AppColors.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            if (subscriptionController.isLoading)
              const CircularProgressIndicator()
            else if (subscriptionController.subscriptionOptions.isEmpty)
              const Text("No subscription options available")
            else
              ...subscriptionController.subscriptionOptions.map((package) {
                return SubscriptionCard(
                  package: package,
                  onPressed:
                      () =>
                          subscriptionController.purchaseSubscription(package),
                );
              }).toList(),
            const SizedBox(height: 20),
            TextButton(
              onPressed: subscriptionController.restorePurchases,
              child: const Text("Restore Purchases"),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final Package package;
  final VoidCallback onPressed;

  const SubscriptionCard({
    super.key,
    required this.package,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isBestValue = package.identifier.contains('yearly');

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isBestValue)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    Strings.bestValue,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                package.storeProduct.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                package.storeProduct.description,
                style: TextStyle(color: AppColors.hintColor),
              ),
              const SizedBox(height: 16),
              Text(
                package.storeProduct.priceString,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
