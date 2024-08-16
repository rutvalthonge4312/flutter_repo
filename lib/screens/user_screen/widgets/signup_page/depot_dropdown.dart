import 'package:flutter/material.dart';
import 'package:sanchalak/services/train_services/index.dart';
import 'package:sanchalak/widgets/index.dart';

class DepotDropdown extends StatefulWidget {
  final void Function(String) onSaved;
  final  List<String>  depots;

  const DepotDropdown(
      {Key? key, required this.onSaved, required this.depots})
      : super(key: key);

  @override
  _DepotDropdown createState() => _DepotDropdown();
}

class _DepotDropdown extends State<DepotDropdown> {
  String? _selectedDepot;
  
  

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
      decoration: textFieldDecoration('Select Depot'),
      value: _selectedDepot,
      items: widget.depots.map((divi) {
        return DropdownMenuItem<String>(
          value: divi,
          child: Text(divi),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedDepot = value!;
        });
        widget.onSaved(value!);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a depot';
        }
        return null;
      },
    );
  }
}
