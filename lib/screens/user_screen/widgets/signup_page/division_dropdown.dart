import 'package:flutter/material.dart';

class DivisionDropdown extends StatefulWidget {
  final void Function(String) onSaved;  // Callback to pass updated value to parent

  const DivisionDropdown({Key? key, required this.onSaved}) : super(key: key);

  @override
  _DivisionDropdownState createState() => _DivisionDropdownState();
}

class _DivisionDropdownState extends State<DivisionDropdown> {
  String _selectedDivision = 'DNR';  
  String ? _depot;
  final List<String> _divisions = [
    'DNR',
    'TKPR',
  ];

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
    return Column( 
    children: [
    DropdownButtonFormField<String>(
      decoration: textFieldDecoration('Select Division'),
      value: _selectedDivision,
      items: _divisions.map((division) {
        return DropdownMenuItem<String>(
          value: division,
          child: Text(division),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedDivision = value;
          });
          widget.onSaved(_selectedDivision);  
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a division';
        }
        return null;
      },
    ),
    ]
    );
  }
}
