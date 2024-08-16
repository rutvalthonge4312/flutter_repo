import 'package:flutter/material.dart';

class RolesDropdown extends StatefulWidget { 
  final void Function(String) onSaved;

  const RolesDropdown({Key? key, required this.onSaved}) : super(key: key);

  @override
  _RolesDropdown createState() => _RolesDropdown();
}

class _RolesDropdown extends State<RolesDropdown> {
  String _selectedRole='supervisor';
  final List<String> _roles = [
    'supervisor',
    'contractor',
    'station manager',
    'railway admin',
    'railway officer',
    'write read',
    'coach attendent',
    'EHK',
    's2 admin',
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
    return DropdownButtonFormField<String>(
      decoration: textFieldDecoration('Select Role'),
      value: _selectedRole,
      items: _roles.map((role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value!;
        });
        widget.onSaved(value!);
      },
      // validator: (value) {
      //   if (value == null) {
      //     return 'Please select a role';
      //   }
      //   return null;
      // },
    );
  }
}
