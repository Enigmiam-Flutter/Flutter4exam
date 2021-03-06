import 'package:flutter/material.dart';
import 'package:flutter_api_calls/models/Drawner.dart';

import 'DoctorBottomNavigationScreen.dart';

void main() => runApp(MainDoctor());

class MainDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DoctorBottomNav();

    // return Container(
    //     child: Column(
    //   children: [
    //     Container(height: 90, child: DoctorDrawer()),
    //     Container(
    //       height: 642,
    //       child: DoctorBottomNav(),
    //     )
    //   ],
    // ));
  }
}
