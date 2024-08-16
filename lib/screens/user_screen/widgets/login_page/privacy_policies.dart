import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget privacyPolicyRender(BuildContext context){
  return(
    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            try {
                              const privacyPolicyUrl =
                                  'https://suvidhaen.com/privacypolicy_wrms';
                              final url = Uri.parse(privacyPolicyUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                );
                              }
                            } catch (error) {
                              print(error);
                            }
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                  width: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Term & Condition",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            try {
                              const privacyPolicyUrl =
                                  'https://suvidhaen.com/termcondition';
                              final url = Uri.parse(privacyPolicyUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                );
                              }
                            } catch (error) {
                              print(error);
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ],
            )
  );
}