import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(Strings.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account"),
            onTap: () {
              // Navigate to account settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Privacy"),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help & Support"),
            onTap: () {
              // Navigate to help & support
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
