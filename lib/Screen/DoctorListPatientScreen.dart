import 'package:flutter/material.dart';

import '../models/Docteur.dart';

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
      padding: EdgeInsets.all(16.0), itemBuilder: (BuildContext context, int index) {  },
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
            return _buildRow(_DoctorList[index].name);
          }),
      onTap: () =>
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Hello'))),
    );
  }

  Widget _buildRow(String doctor) {
    return ListTile(
      title: Text(
        '123',
      ),
    );
  }
}
