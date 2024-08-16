import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanchalak/models/index.dart';
import 'package:sanchalak/routes.dart';
import 'package:sanchalak/screens/user_screen/form/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authModel = Provider.of<AuthModel>(context, listen: false);
      if (authModel.isAuthenticated) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300, // Background color
      body: 
       Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              color: Colors.blue.shade300,
              child: const Center(
                child: Text(
                  'Welcome to Sanchalak',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child:const SingleChildScrollView(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginForm(),
                  // SizedBox(height: 50),
                ],
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
