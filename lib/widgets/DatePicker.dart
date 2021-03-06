import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  Function(DateTime) callback;

  DatePicker(this.callback);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  String textValue = 'Choisir une date';


  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () => _selectDate(context), 
        child: Text(textValue),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.callback(selectedDate);
        textValue = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }
}
