import 'package:flutter/material.dart';
import 'package:pree_vpn/constants/app_color.dart';

class VpnButton extends StatelessWidget {
  final bool isConnected;
  final bool isLoading;
  final VoidCallback onPressed;

  const VpnButton({
    super.key,
    required this.isConnected,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, dynamic Strings) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: isLoading ? null : 1,
            valueColor: AlwaysStoppedAnimation(
              isConnected ? AppColors.primaryColor : Colors.grey,
            ),
            strokeWidth: 8,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor:
                  isConnected ? AppColors.primaryColor : Colors.grey,
            ),
            onPressed: isLoading ? null : onPressed,
            child:
                isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                      isConnected ? Strings.disconnect : Strings.connect,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
          ),
        ],
      ),
    );
  }
}
