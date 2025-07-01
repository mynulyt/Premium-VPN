import 'package:flutter/material.dart';
import 'package:pree_vpn/constants/app_color.dart';
import 'package:pree_vpn/models/server_model.dart';

class ServerTile extends StatelessWidget {
  final Server server;
  final bool isSelected;
  final VoidCallback onTap;

  const ServerTile({
    super.key,
    required this.server,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(server.flag, style: const TextStyle(fontSize: 24)),
      title: Text(server.name),
      subtitle: Text(
        "${server.country} • Load: ${server.load}% • Ping: ${server.ping}ms",
      ),
      trailing:
          isSelected
              ? const Icon(Icons.check, color: AppColors.primaryColor)
              : server.isPremium
              ? const Icon(Icons.star, color: AppColors.accentColor)
              : null,
      onTap: onTap,
    );
  }
}
