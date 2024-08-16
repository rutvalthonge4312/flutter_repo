import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanchalak/models/index.dart';
import 'package:sanchalak/routes.dart';
import 'package:sanchalak/screens/user_screen/widgets/index.dart';
import 'package:sanchalak/services/authentication_services/auth_service.dart';
import 'package:sanchalak/widgets/index.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _mobileNumber;
  late String _password;
  bool _isLoading = false;
  
  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      loader(context , "Logging in... Please wait.");
      final loginResponse = await AuthService.login(_mobileNumber, _password);
      final authModel = Provider.of<AuthModel>(context , listen: false);
      final userModel = Provider.of<UserModel>(context , listen: false);

      authModel.login(loginResponse!);
      userModel.updateUserDetails(
        userName: loginResponse.userName,
        mobileNumber: loginResponse.mobileNumber,
        stationCode: loginResponse.stationCode,
        stationName: loginResponse.stationName,
        token: loginResponse.token,
        userType: loginResponse.userType,
        refreshToken: loginResponse.refreshToken,
      );

      Navigator.of(context )
        ..pop()
        ..pushReplacementNamed(Routes.home);
    } catch (e) {
      Navigator.of(context ).pop();
      if (!(e is StateError && e.toString().contains('mounted'))) {
        showErrorModal(context , '$e', "Error", () {
          
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  void _forgotPass() {
    // Navigator.pushReplacementNamed(context, Routes.forgotPassword);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.9;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 5),
            const SizedBox(height: 15),
            MobileNumberField(onSaved: (value) => _mobileNumber = value),
            const SizedBox(height: 20),
            PasswordField(onSaved: (value) => _password = value),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: _forgotPass,
                child: const Text('Forgot Password'),
              ),
            ),
            const SizedBox(
              height: 16,
              width: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                fixedSize: Size(buttonWidth, 50),
              ),
              onPressed: _submitForm,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Log in',style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(height: 5),
            const Divider(
              color: Color.fromARGB(255, 191, 191, 191)
            ),
            const SizedBox(height: 25),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    renderMobileLogInButton(context),
                    const SizedBox(
                      height: 15,
                      width: 5,
                    ),
                    renderGoogleSignInButton(context),
                  ],
                ),
                const SizedBox(height: 15),
                renderSignUpButton(context),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            privacyPolicyRender(context),
          ],
        ),
      ),
    );
  }
}
