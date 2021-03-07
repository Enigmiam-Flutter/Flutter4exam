import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/models/Docteur.dart';
import 'package:flutter_api_calls/models/Patient.dart';
import 'package:flutter_api_calls/models/Rdv.dart';
import 'package:intl/intl.dart';

Rdv rdvInDb;
String docteurName;
String patientName;

class RdvDetailScreen extends StatefulWidget {
  String _idRdv;
  RdvDetailScreen(this._idRdv);

  String get idRdv => _idRdv;

  @override
  _RdvDetailScreenState createState() => _RdvDetailScreenState();
}

class _RdvDetailScreenState extends State<RdvDetailScreen> {
  bool _progressController = true;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("rdv");
  StreamSubscription<QuerySnapshot> subscriptionDoc;
  List<DocumentSnapshot> snapshotDoc;
  CollectionReference collectionReferenceDoc =
      Firestore.instance.collection("docteurs");  
  StreamSubscription<QuerySnapshot> subscriptionPatient;
  List<DocumentSnapshot> snapshotPatient;
  CollectionReference collectionReferencePatient =
      Firestore.instance.collection("patient");  


  @override
  void initState() {
    super.initState();
    
    subscription = collectionReference.snapshots().listen((dataSnapshot) {
      setState(() {
        snapshot = dataSnapshot.documents;
        snapshot.map((data) => { 
          if(data.documentID == widget.idRdv) {
            rdvInDb = Rdv.fromSnapshot(data)
          },
        }).toList();
      });
    });
    subscriptionDoc = collectionReferenceDoc.snapshots().listen(((dataSnapshot) {
      setState(() {
        snapshotDoc = dataSnapshot.documents;
        snapshotDoc.map((data) => {
          if(data.documentID == rdvInDb.IdD) docteurName = Docteur.fromSnapshot(data).prenom + ' ' + Docteur.fromSnapshot(data).name,
        }).toList();
      });
    }));
    subscriptionPatient = collectionReferencePatient.snapshots().listen(((dataSnapshot) {
      setState(() {
        snapshotPatient = dataSnapshot.documents;
        snapshotPatient.map((data) => {
          if(data.documentID == rdvInDb.IdP) patientName = Patient.fromSnapshot(data).prenom + ' ' + Patient.fromSnapshot(data).name,
        }).toList();
        _progressController = false;
      });
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du rendez-vous'),
      ),
      body: _progressController
      ? LinearProgressIndicator()
      :_build(context),
    );
  }

  Widget _build (BuildContext context){
    String formatedDate = DateFormat('dd/MM/yyyy hh:mm').format(DateTime.parse(rdvInDb.rdv));
    return Container(
      padding: EdgeInsets.all(25),
      child: Center(
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: 20, bottom: 20), child: Text('Date : ' + formatedDate)),
            Container(margin: EdgeInsets.only(top: 20, bottom: 20),child: Text('Médecin : ' + docteurName)),
            Container(margin: EdgeInsets.only(top: 20, bottom: 20),child: Text('Patient : ' + patientName)),
            Container(margin: EdgeInsets.only(top: 20, bottom: 20),child: Text('Description : ' + rdvInDb.desc)),
          ],
        ),
      ),
    );
  }
}