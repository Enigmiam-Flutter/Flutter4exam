import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/Docteur.dart';

var _doctor;

class DoctorListPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: DoctorList(),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
    );
  }
}

class DoctorList extends StatelessWidget {
  @override
  List<Docteur> _DoctorList = [new Docteur()];
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListView.builder(
          itemCount: _DoctorList.length * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider(); /*2*/
            final index = i ~/ 2; /*3*/
            if (index >= _DoctorList.length) {}
            return getData(context);
          }),
      onTap: () => Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('TODO redirect to another view'))),
    );
  }

  Widget _buildLigne(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('patient').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return getData(context);
      },
    );
  }

  Widget _buildRow(BuildContext context, List<DocumentSnapshot> snapshot) {
    snapshot.map((data) {
      //print(_doctor);
      _doctor = Docteur.fromSnapshot(data);
    }).toList();
    return Container(
      child: ListTile(
        title: Text(
          _doctor.username,
        ),
      ),
    );
  }

  Widget getData(BuildContext context) {
    Firestore.instance
        .collection("patient")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('{${f.data.values}}'));
    });
  }
}
