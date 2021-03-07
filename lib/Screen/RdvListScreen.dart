import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/Screen/doctorLoginScreen.dart';
import 'package:flutter_api_calls/doctor.dart';
import 'package:flutter_api_calls/models/Patient.dart';
import 'package:flutter_api_calls/models/Rdv.dart';
import 'package:flutter_api_calls/models/Docteur.dart';

import 'PatientBottomNavigationScreen.dart';

String _idDoctor;
String _nameDoctor;

class RdvListScreen extends StatefulWidget {
  RdvListScreen(String globalIdPatient);

  @override
  _RdvListScreenState createState() => _RdvListScreenState();
}

class _RdvListScreenState extends State<RdvListScreen> {
  bool _progressController = true;
  StreamSubscription<QuerySnapshot> subscription;
  StreamSubscription<QuerySnapshot> subscriptiondoc;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("rdv");
  List<DocumentSnapshot> snapshotDoc;
  CollectionReference collectionReferenceDoc =
      Firestore.instance.collection("docteurs");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });
    subscriptiondoc =
        collectionReferenceDoc.snapshots().listen((datasnapshotdoc) {
      setState(() {
        snapshotDoc = datasnapshotdoc.documents;
        _progressController = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des rdv"),
      ),
      body: _progressController
          ? CircularProgressIndicator()
          : Column(
              children: [
                ...(snapshot).map((data) {
                  (snapshotDoc).map((doc) {
                    _idDoctor = doc.documentID;
                    _nameDoctor = Docteur.fromSnapshot(doc).name;
                  }).toList();
                  if (Rdv.fromSnapshot(data).IdP == globalIdPatient) {
                    return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        child: Text(
                            Rdv.fromSnapshot(data).rdv + ' ' + _nameDoctor));
                  } else {
                    return Container();
                  }
                }).toList()
              ],
            ),
    );
  }
}
