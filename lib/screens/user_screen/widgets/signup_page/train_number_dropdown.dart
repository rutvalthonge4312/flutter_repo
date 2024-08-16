import 'package:flutter/material.dart';

class TrainNumberDropdown extends StatefulWidget { 
  final void Function(String) onSaved;
  final  List<String>  trainList;

  const TrainNumberDropdown({Key? key, required this.onSaved,required this.trainList}) : super(key: key);

  @override
  _TrainNumberDropdown createState() => _TrainNumberDropdown();
}

class _TrainNumberDropdown extends State<TrainNumberDropdown> {
  String ? _selectedTrainNumber;
  

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
      decoration: textFieldDecoration('Select Train Number'),
      value: _selectedTrainNumber,
      items: widget.trainList.map((divi) {
        return DropdownMenuItem<String>(
          value: divi,
          child: Text(divi),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedTrainNumber = value!;
        });
        widget.onSaved(value!);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a train number';
        }
        return null;
      },
    );
  }
}
