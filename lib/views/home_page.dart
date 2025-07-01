import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premium_vpn/controllers/vpn_controller.dart';
import 'package:premium_vpn/constants/strings.dart';
import 'package:premium_vpn/constants/app_colors.dart';
import 'package:premium_vpn/views/server_list_page.dart';
import 'package:premium_vpn/views/premium_page.dart';
import 'package:premium_vpn/views/settings_page.dart';
import 'package:premium_vpn/widgets/vpn_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ServerListPage(),
    const PremiumPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appName)),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: Strings.home),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: Strings.servers,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: Strings.premium,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: Strings.settings,
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vpnController = Provider.of<VpnController>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          if (vpnController.selectedServer != null)
            Column(
              children: [
                Text(
                  vpnController.selectedServer!.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  vpnController.selectedServer!.country,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.hintColor,
                  ),
                ),
              ],
            )
          else
            const Text(
              Strings.selectServer,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          const Spacer(),
          VpnButton(
            isConnected: vpnController.isConnected,
            isLoading: vpnController.isLoading,
            onPressed: () {
              if (vpnController.isConnected) {
                vpnController.disconnect();
              } else {
                if (vpnController.selectedServer != null) {
                  vpnController.connect(vpnController.selectedServer!);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServerListPage(),
                    ),
                  );
                }
              }
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
