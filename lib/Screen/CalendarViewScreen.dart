import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_api_calls/Screen/PatientListDoctorScreen.dart';
import 'package:flutter_api_calls/models/Patient.dart';
import 'package:flutter_api_calls/models/Rdv.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'DoctorLoginScreen.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2020, 2, 14): ['Valentines\'s day'],
};

class CalendarViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calendrier Rendez-vous'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  bool _progressController = true;
  StreamSubscription<QuerySnapshot> subscription;
  StreamSubscription<QuerySnapshot> subscriptionPatient;

  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("rdv");
  List<DocumentSnapshot> snapshotPatient;
  CollectionReference collectionReferencePatient =
      Firestore.instance.collection("patient");

  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });

    subscriptionPatient =
        collectionReferencePatient.snapshots().listen((datasnapshotPatient) {
      setState(() {
        snapshotPatient = datasnapshotPatient.documents;
        _progressController = false;
      });
    });

    _events = {};
    _selectedEvents = _events[dateToday] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  final dateToday = DateTime.now();

  /*Méthode qui récupère en base la liste de chaque patients et viens ajouter un evenement sur le calendrier */

  String _idPatient;
  String _nomPatient;
  String _prenomPatient;
  String _idDoctorRdV;

  getRdv(BuildContext context) {
    snapshot.map((data) {
      _idDoctorRdV = Rdv.fromSnapshot(data).IdD;

      snapshotPatient.map((patient) {
        _idPatient = patient.documentID;
        _nomPatient = Patient.fromSnapshot(patient).name;
        _prenomPatient = Patient.fromSnapshot(patient).prenom;
      }).toList();

      //Récupère la chaine de caractère de la date entière
      String fullRdv = Rdv.fromSnapshot(data).rdv;
      DateTime rdvDateTime = DateTime.parse(fullRdv);
      String heureRdv = new DateFormat("jm").format(rdvDateTime);
      // Ajoute un event pour chaque patient trouvé, sous la forme {Nom} {Prenom} - {Heure}
      print(_idDoctorRdV);
      print(doctorId);
      if (_idDoctorRdV == doctorId) {
        _events[rdvDateTime] = [
          _nomPatient + '  ' + _prenomPatient + ' - ' + heureRdv
        ];
      }
    }).toList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _progressController
          ? CircularProgressIndicator()
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildTableCalendar(),
                const SizedBox(height: 8.0),
                _buildButtons(),
                const SizedBox(height: 8.0),
                Expanded(child: _buildEventList(context)),
              ],
            ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    //final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildEventList(BuildContext context) {
    getRdv(context);
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                    title: Text(event.toString()),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }),
              ))
          .toList(),
    );
  }

  String _description;

  Widget _buildPopupDialog(BuildContext context) {
    snapshot.map((data) {
      _description = Rdv.fromSnapshot(data).desc;
    }).toList();

    return new AlertDialog(
      title: const Text('Description'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_description),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}
