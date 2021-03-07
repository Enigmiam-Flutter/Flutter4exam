import 'package:flutter/material.dart';
import 'Screen/DoctorLoginScreen.dart';
import 'Screen/PatientLoginScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In this case, the app starts
    // on the FirstScreen widget.
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      '/docteur': (context) => DoctorLoginScreen(),
      '/patient': (context) => PatientLoginScreen(),
      //'/firestore': (context) => AddUser("roger ", "bob", 12),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page d'identification"),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
            child: Text('Connexion docteur'),
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/docteur');
            },
          ),
          ElevatedButton(
            child: Text('Connexion patient'),
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/patient');
            },
          ),
        ],
      )),
    );
  }
}
