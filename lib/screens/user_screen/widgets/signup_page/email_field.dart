import 'package:flutter/material.dart';
import 'package:sanchalak/screens/user_screen/widgets/index.dart';
import 'package:sanchalak/services/otp_services/sign_up_otp.dart';
import 'package:sanchalak/widgets/index.dart';

class EmailField extends StatefulWidget {
  final void Function(String email, bool isVerified) onSavedAndVerified;

  EmailField({super.key, required this.onSavedAndVerified});

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final TextEditingController _emailController = TextEditingController();
  bool _isOtpSend = false;
  bool showOtpBox = false;
  String otp = '';
  bool _isOtpVerified = false;
  bool disableTextField = false;

  void _sendOtp({required String type}) async {
    loader(context, "Sending OTP , Please Wait...");
    String value = _emailController.text.trim();
    try {
      final sendOtpResponse = await SignUpOtp.sendOtp(value, type);
      setState(() {
        _isOtpSend = true;
        showOtpBox = true;
        disableTextField = true;
      });
      Navigator.of(context).pop();
      showSuccessModal(
        context,
        sendOtpResponse,
        "Success",
        () {},
      );
    } catch (e) {
      Navigator.of(context).pop();
      showErrorModal(context, '$e', "Error", () {});
      if (e is StateError && e.toString().contains('mounted')) {
        print('Widget disposed before operation completes');
      } else {
        print('Send Otp Failed : $e');
      }
    }
  }

  void _verifyOtp(String type) async {
    loader(context, "Verifying OTP, Please Wait...");
    String value = _emailController.text.trim();
    try {
      final verifyOtpResponse = await SignUpOtp.veirfyOtp(value, otp, type);
      setState(() {
        _isOtpVerified = true;
      });
      Navigator.of(context).pop();
      showSuccessModal(
        context,
        verifyOtpResponse,
        "Success",
        () {
          // Pass email and verification status to parent
          widget.onSavedAndVerified(value, _isOtpVerified);
        },
      );
    } catch (e) {
      Navigator.of(context).pop();
      showErrorModal(context, "$e", "Error", () {});
      if (e is StateError && e.toString().contains('mounted')) {
        print('Widget disposed before operation completes');
      } else {
        print('Verification Failed : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              onPressed: () {
                _sendOtp(type: 'email');
              },
            ),
          ),
          readOnly: disableTextField,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
          onSaved: (String? value) {
            widget.onSavedAndVerified(value!, _isOtpVerified);
          },
        ),
        if (!_isOtpSend)
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF313256),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                _sendOtp(type: 'email');
              },
              child: _isOtpSend
                  ? const CircularProgressIndicator()
                  : const Text('Send OTP'),
            ),
          ),
        if (_isOtpVerified) const VirifiedTag(),
        if (showOtpBox && !_isOtpVerified)
          Column(
            children: [
              OtpBoxes(onSaved: (value) => otp = value),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF313256),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _verifyOtp('email');
                      },
                      child: _isOtpVerified
                          ? const CircularProgressIndicator()
                          : const Text('Verify OTP'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF313256),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          disableTextField = false;
                          showOtpBox = false;
                          _isOtpSend = false;
                        });
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              )
            ],
          )
      ],
    );
  }
}
