import 'package:flutter/material.dart';
import 'package:pree_vpn/constants/app_color.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.primaryColor),
          if (message != null) ...[
            const SizedBox(height: 20),
            Text(message!, style: TextStyle(color: AppColors.hintColor)),
          ],
        ],
      ),
    );
  }
}
