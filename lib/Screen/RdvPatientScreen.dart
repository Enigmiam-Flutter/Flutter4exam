import 'package:flutter/material.dart';
import 'package:flutter_api_calls/widgets/DateTimePicker.dart';

class RdvPatientScreen extends StatefulWidget {
  @override
  _RdvPatientScreenState createState() => _RdvPatientScreenState();
}

class _RdvPatientScreenState extends State<RdvPatientScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prendre un rendez vous'),),
      body: _build(context),
      
    );
  }

  Widget _build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'dd/MM/YYYY'),
            onTap: () => CustomTimePicker(),
          ),
          ElevatedButton(
            onPressed: formHandler, 
          ),
        ],
      ),
    );
  }

  void formHandler() {
    print('coucou');
  }
}