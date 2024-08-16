import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanchalak/models/index.dart';
import 'package:sanchalak/routes.dart';
import 'package:sanchalak/services/authentication_services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final authModel = Provider.of<AuthModel>(context, listen: false);
    try {
      await AuthService.logout(
        authModel.loginResponse!.refreshToken,
        authModel.loginResponse!.token,
      );
      authModel.logout();
      Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      authModel.logout();
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Home Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
