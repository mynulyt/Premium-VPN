import 'package:premium_vpn/models/server_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class VpnService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _apiUrl = 'https://your-vpn-api.com';

  Future<List<Server>> getServers() async {
    // In a real app, this would fetch from your backend
    try {
      // Simulate API call
      // final response = await http.get(Uri.parse('$_apiUrl/servers'));
      // if (response.statusCode == 200) {
      //   List<dynamic> data = jsonDecode(response.body);
      //   return data.map((server) => Server.fromMap(server)).toList();
      // }

      // Mock data
      return [
        Server(
          id: '1',
          name: 'USA Server',
          country: 'United States',
          flag: 'us',
          configFile: 'assets/config_files/us.ovpn',
          isPremium: false,
          load: 30,
          ping: 45,
        ),
        Server(
          id: '2',
          name: 'UK Server',
          country: 'United Kingdom',
          flag: 'gb',
          configFile: 'assets/config_files/uk.ovpn',
          isPremium: true,
          load: 25,
          ping: 60,
        ),
      ];
    } catch (e) {
      print('Error fetching servers: $e');
      return [];
    }
  }

  Future<bool> connectToServer(Server server) async {
    try {
      // In a real app, this would use a VPN plugin to connect
      // For now, just store the connected server
      await _storage.write(key: 'connected_server', value: server.id);
      return true;
    } catch (e) {
      print('Error connecting to server: $e');
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      await _storage.delete(key: 'connected_server');
      return true;
    } catch (e) {
      print('Error disconnecting: $e');
      return false;
    }
  }

  Future<String?> getConnectedServerId() async {
    return await _storage.read(key: 'connected_server');
  }
}
