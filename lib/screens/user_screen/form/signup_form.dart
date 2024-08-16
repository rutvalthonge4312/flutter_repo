import 'package:flutter/material.dart';
import 'package:sanchalak/screens/user_screen/widgets/index.dart';
import 'package:sanchalak/services/authentication_services/auth_service.dart';
import 'package:sanchalak/services/train_services/train_service_signup.dart';
import 'package:sanchalak/widgets/index.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();

    getDepot();
  }
  
  late String _mobileNumber, _firstName, _middleName, _lastName, _email, _password, _rePassword;
  late String _division = 'DNR', _depot = '', _trainNumber = '', _coachNumber = '',_role='supervisor';
  late bool otpSend = false, _isEmailVerified = false, _isPhoneVerified = false;
  bool _isLoading = false;
  List<String> depots = [];
  List<String> trainList = [];
  List<String> coachList = [];

void _submitForm() async {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    loader(context, "Submitting Data. Please Wait!");
    try {
      final response=await AuthService.signup(
        _mobileNumber,
        _firstName,
        _lastName,
        _email,
        _password,
        _rePassword,
        _role,
        _division,
        _trainNumber,
        _coachNumber,
      );
      Navigator.of(context ).pop();
      showSuccessModal(context, response, "Success", (){});
    } catch (e) {
      Navigator.of(context ).pop();
      showErrorModal(context, 'Signup failed: $e', "Error", () {});
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  } else {
    // If validation fails, show validation errors
    setState(() {
      // Optionally handle UI changes for validation errors
    });
  }
}

   Future getDepot() async {
    try {
      final getData =
          await TrainServiceSignup.getDepot(_division);
      setState(() {
        depots = getData;
      });
    } catch (e) {
      showErrorModal(context, '$e', "Error", () {});
      setState(() {});
      if (e is StateError && e.toString().contains('mounted')) {
        print('Widget disposed before operation completes');
      } else {
        print('Send Otp Failed : $e');
      }
    }
  }
   Future getTrainList() async {
    try {
      final getData =
          await TrainServiceSignup.getTrainList(_depot);
      setState(() {
        trainList = getData;
      });
    } catch (e) {
      showErrorModal(context, '$e', "Error", () {});
      setState(() {});
      if (e is StateError && e.toString().contains('mounted')) {
        print('Widget disposed before operation completes');
      } else {
        print('Send Otp Failed : $e');
      }
    }
  }
  //getCoaches
  Future getCoachList() async {
    try {
      final getData =
          await TrainServiceSignup.getCoaches(_trainNumber);
      setState(() {
        coachList = getData;
      });
    } catch (e) {
      showErrorModal(context, '$e', "Error", () {});
      setState(() {});
      if (e is StateError && e.toString().contains('mounted')) {
        print('Widget disposed before operation completes');
      } else {
        print('Send Otp Failed : $e');
      }
    }
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
            FirstNameField(onSaved: (value) => _firstName = value),
            const SizedBox(height: 20),
            MiddleNameField(onSaved: (value) => _middleName = value),
            const SizedBox(height: 20),
            LastNameField(onSaved: (value) => _lastName = value),
            const SizedBox(height: 20),
            EmailField(onSavedAndVerified: (value, isVerified) {
              _email = value;
              setState(() {
                 _isEmailVerified = isVerified;
              });
             
            }),
            const SizedBox(height: 20),
            MobileFieldSignup(onSavedAndVerified: (value, isVerified) {
              _mobileNumber = value;
              setState(() {
                _isPhoneVerified = isVerified;
              });
            }),
            const SizedBox(height: 20),
            PasswordField(onSaved: (value) => _password = value),
            const SizedBox(height: 20),
            RePassword(onSaved: (value) => _rePassword = value),
            const SizedBox(height: 20),
            RolesDropdown(onSaved: (value) => _role = value),
            const SizedBox(height: 20),
            DivisionDropdown(
              onSaved: (value) {
                setState(() {
                  _division = value;
                   _depot = '';
                });
                getDepot();
              },
            ),
            const SizedBox(height: 20),
            DepotDropdown(
              depots: depots,
               onSaved: (value) {
                setState(() {
                  _depot = value;
                });
                getTrainList();
              },
            ),
            const SizedBox(height: 20),
            //getCoachList
            TrainNumberDropdown(trainList: trainList, 
            onSaved: (value) {
                setState(() {
                  _trainNumber = value;
                });
                getCoachList();
              },
            ),
            const SizedBox(height: 20),
            CoachDropdown(
              coachList: coachList,
              onSaved: (value) => _coachNumber = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                fixedSize: Size(buttonWidth, 50),
              ),
              
              onPressed: (_isEmailVerified && _isPhoneVerified) ? _submitForm : null,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Request For Sign Up'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
