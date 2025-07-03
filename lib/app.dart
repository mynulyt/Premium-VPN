import 'package:flutter/material.dart';
import 'package:pree_vpn/views/home_page.dart';
import 'package:pree_vpn/views/login_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        // Add other providers here
      ],
      child: Consumer<AuthController>(
        builder: (context, auth, child) {
          return auth.isAuthenticated ? const HomePage() : const LoginPage();
        },
      ),
    );
  }
}
