import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/models/Patient.dart';

var patient;

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  bool _progressController = true;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("docteurs");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
        _progressController = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des docteurs'),
      ),
      body: _progressController
          ? CircularProgressIndicator()
          : Column(
              children: [
                ...(snapshot).map((data) {
                  return Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      child: Text(Patient.fromSnapshot(data).prenom +
                          ' ' +
                          Patient.fromSnapshot(data).name));
                }).toList()
              ],
            ),
    );
  }
}
