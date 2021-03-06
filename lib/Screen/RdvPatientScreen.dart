import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/widgets/DatePicker.dart';
import 'package:flutter_api_calls/widgets/TimePicker.dart';

class RdvPatientScreen extends StatefulWidget {
  String idDocteur;
  String idPatient;

  RdvPatientScreen({Key key, @required this.idDocteur, @required this.idPatient}) : super(key:key);

  @override
  _RdvPatientScreenState createState() => _RdvPatientScreenState();
}

class _RdvPatientScreenState extends State<RdvPatientScreen> {
  DateTime selectedDate;
  TimeOfDay selectedHours;
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate;
  TimeOfDay selectedHours;

  callbackDatePicker(pickedDate) {
    setState(() {
      selectedDate = pickedDate;
    });
  }

  callbackTimePicker(pickedHour){
    setState((){
      selectedHours = pickedHour;
    });
  }

  callbackDatePicker(pickedDate){
    setState(() {
      selectedDate = pickedDate;
    });
  }

  callbackTimePicker(pickedHours){
    setState(() {
      selectedHours = pickedHours;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, right: 10, left: 10),
      child: Scaffold(
        appBar: AppBar(title: Text('Prendre un rendez vous'),),
        body: _build(context),
        
      ),
    );
  }

  Widget _build(BuildContext context){
    return Form(
      key: _formKey,
      child: Container(
        child: Column( 
          children: [
            Container(child: DatePicker(callbackDatePicker)),
            Container(child: CustomTimePicker(callbackTimePicker)),
            Container(
              child: ElevatedButton(
                onPressed: formHandler, 
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void formHandler() {
    Duration duration = Duration(hours: selectedHours.hour, minutes: selectedHours.minute);
    selectedDate = selectedDate.add(duration);
    var data = {
      "IdD" : 'WY41ihBOYQ2cxd8hQrc4',
      "IdP" : 'N0rjKUEAHPapS4oKJmzX',
      "rdv": selectedDate.toString(),
    };
    Firestore.instance.collection("rdv").add(data).then((value) => print(value));
  }
}