import 'package:flutter/material.dart';

class RePassword extends StatefulWidget { 
  final void Function(String) onSaved;

  const RePassword({Key? key, required this.onSaved}) : super(key: key);

  @override
  _RePassword createState() => _RePassword();
}

class _RePassword extends State<RePassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Re-password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const  BorderSide(
            color: Colors.grey, // Specify the border color
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey, // Specify the border color when enabled
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:const BorderSide(
            color: Colors.blue, 
            width: 2.0, 
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      onSaved: (String? value) {
        widget.onSaved(value!);
      },
    );
  }
}
