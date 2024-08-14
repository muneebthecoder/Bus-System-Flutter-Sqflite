import 'package:flutter/material.dart';
import 'package:mid_bus_project/Screens/home.dart';
import 'package:mid_bus_project/Screens/reportScreen.dart';
import 'package:mid_bus_project/Screens/vehicleScreen.dart';

import 'driverScreen.dart';

class BarScreen extends StatefulWidget {
  const BarScreen({super.key});

  @override
  State<BarScreen> createState() => _BarScreenState();
}

class _BarScreenState extends State<BarScreen> {
  int selectedIndex = 0;
  List<Widget> widgetScreen = <Widget>[
HomeMenu(),
 DriverScreen(),
 VehicleScreen(),
 ReportExpense(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(    bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.man),
              label: 'DRIVER',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bus_alert_outlined),
              label: 'VEHICLE',
            ),
                        BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_sharp),
              label: 'REPORTS',
            ),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black87,
          onTap: _onItemTapped,
        ),
      body:widgetScreen[selectedIndex]

    );
  }
}