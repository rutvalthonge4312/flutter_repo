import 'package:flutter/material.dart';

class MobileNumberField extends StatelessWidget {
  final void Function(String) onSaved;

  const MobileNumberField({super.key, required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
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
          borderSide:  const BorderSide(
            color: Colors.blue, 
            width: 2.0, 
          ),
        ),
         suffixIcon: IconButton(
          icon:const Icon(
           Icons.mobile_friendly,
           color: Colors.grey,
          ),
          onPressed: () {
            
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        }
        return null;
      },
      onSaved: (String? value) {
        onSaved(value!);
      },
    );
  }
}
