import 'package:flutter/material.dart';
import 'DoctorBottomNavigationScreen.dart';

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
