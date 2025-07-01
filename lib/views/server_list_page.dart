import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:premium_vpn/controllers/vpn_controller.dart';
import 'package:premium_vpn/models/server_model.dart';
import 'package:premium_vpn/widgets/server_tile.dart';
import 'package:premium_vpn/constants/strings.dart';

class ServerListPage extends StatelessWidget {
  const ServerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vpnController = Provider.of<VpnController>(context);

    // In a real app, you would fetch this from your backend
    final List<Server> servers = [
      Server(
        id: '1',
        name: 'USA Server',
        country: 'United States',
        flag: '🇺🇸',
        configFile: 'assets/config_files/us.ovpn',
        isPremium: false,
        load: 30,
        ping: 120,
      ),
      Server(
        id: '2',
        name: 'UK Server',
        country: 'United Kingdom',
        flag: '🇬🇧',
        configFile: 'assets/config_files/uk.ovpn',
        isPremium: true,
        load: 45,
        ping: 80,
      ),
      // Add more servers
    ];

    return Scaffold(
      appBar: AppBar(title: const Text(Strings.servers)),
      body: ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          return ServerTile(
            server: server,
            isSelected: vpnController.selectedServer?.id == server.id,
            onTap: () {
              vpnController.selectServer(server);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
