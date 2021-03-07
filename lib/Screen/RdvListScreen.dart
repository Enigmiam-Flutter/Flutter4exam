import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/models/Patient.dart';
import 'package:flutter_api_calls/models/Rdv.dart';

import 'PatientBottomNavigationScreen.dart';

class RdvListScreen extends StatefulWidget {
  RdvListScreen(String globalIdPatient);

  @override
  _RdvListScreenState createState() => _RdvListScreenState();
}

class _RdvListScreenState extends State<RdvListScreen> {
  bool _progressController = true;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("rdv");

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
        title: Text("Liste des rdv"),
      ),
      body: _progressController
          ? CircularProgressIndicator()
          : Column(
              children: [
                // ignore: missing_return
                ...(snapshot).map((data) {
                  if (Rdv.fromSnapshot(data).IdP == globalIdPatient) {
                    return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        child: Text(Rdv.fromSnapshot(data).rdv +
                            ' ' +
                            Rdv.fromSnapshot(data).IdD));
                  } else {
                    return Container();
                  }
                }).toList()
              ],
            ),
    );
  }
}
