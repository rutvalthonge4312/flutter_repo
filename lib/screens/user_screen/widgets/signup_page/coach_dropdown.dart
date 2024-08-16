import 'package:flutter/material.dart';

class CoachDropdown extends StatefulWidget { 
  final void Function(String) onSaved;
  final List<String> coachList;

  const CoachDropdown({Key? key, required this.onSaved,required this.coachList}) : super(key: key);

  @override
  _CoachDropdown createState() => _CoachDropdown();
}

class _CoachDropdown extends State<CoachDropdown> {
  String ? _selectedCoachNumber;
  

  InputDecoration textFieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: textFieldDecoration('Select Coach Number'),
      value: _selectedCoachNumber,
      items: widget.coachList.map((divi) {
        return DropdownMenuItem<String>(
          value: divi,
          child: Text(divi),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCoachNumber = value!;
        });
        widget.onSaved(value!);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a coach number';
        }
        return null;
      },
    );
  }
}
