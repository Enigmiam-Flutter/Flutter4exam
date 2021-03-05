import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:time_picker_widget/time_picker_widget.dart';

class CustomTimePicker extends StatefulWidget {
  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  String selectedTime;

  List<int> _availableHours = [1, 4, 6, 8, 12];
  List<int> _availableMinutes = [0, 10, 30, 45, 50];
  
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: InkWell(
            onTap: () =>
                // DEMO --------------
                showCustomTimePicker(
                    context: context,
                    // It is a must if you provide selectableTimePredicate
                    onFailValidation: (context) =>
                        showMessage(context, 'Unavailable selection.'),
                    initialTime: TimeOfDay(
                        hour: _availableHours.first,
                        minute: _availableMinutes.first),
                    selectableTimePredicate: (time) =>
                        _availableHours.indexOf(time.hour) != -1 &&
                        _availableMinutes.indexOf(time.minute) != -1).then(
                    (time) =>
                        setState(() => selectedTime = time?.format(context))),
            // --------------

            child: Text(
              selectedTime ?? 'Select Time',
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  showMessage(BuildContext context, String message) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.warning,
                color: Colors.amber,
                size: 56,
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Color(0xFFE8ECF3)))),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(
                        color: Color(0xFF2058CA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
