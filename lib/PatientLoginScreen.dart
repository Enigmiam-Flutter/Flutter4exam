import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'chat.dart';
import 'models/Patient.dart';

final databaseReference = FirebaseDatabase.instance.reference();

String _username;
String _pwd;
var patient;

void main() => runApp(PatientLoginScreen());

class PatientLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login patient'),
      ),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('patient').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildLogin(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildLogin(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: new InputDecoration(labelText: 'Username'),
              validator: (text) =>
                  text.isEmpty ? 'Please enter your username' : null,
              onSaved: (text) => _username = text,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Password'),
              validator: (text) =>
                  text.isEmpty ? 'Please enter your password' : null,
              onSaved: (text) => _pwd = text,
            ),
            _loginBtn(context, snapshot),
          ],
        ),
      ),
    );
  }

  Widget _loginBtn(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => login(
          snapshot,
          context,
        ),
        child: const Text('Login !', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  void login(List<DocumentSnapshot> snapshot, BuildContext context) {
    snapshot.map((data) {
      final patient = Patient.fromSnapshot(data);
      if (patient.username == _username && patient.pwd == _pwd) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FriendlyChatApp()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FriendlyChatApp()),
        );
      }
    }).toList();
  }
}
