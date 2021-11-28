import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/pages/Screens/health_monitor.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_reminder.dart';
import 'package:smart_patient_monitoring/pages/Screens/setting.dart';
import 'package:smart_patient_monitoring/pages/Screens/SmartHome/smart_home.dart';
import 'package:smart_patient_monitoring/setting/custom_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bottomNavBarItems = <Widget>[
    Icon(CustomIcons.pill_reminder, size: 30, color: Colors.black),
/*     Icon(CustomIcons.health_monitor,
        size: 40, color: Colors.redAccent.shade700), */
    Icon(CustomIcons.smart_home, size: 30, color: Colors.brown.shade800),
    Icon(Icons.settings, size: 30, color: Colors.blueGrey.shade700),
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: const [
          MedicineReminder(),
          //         HealthMonitor(),
          SmartHome(),
          Setting(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: _bottomNavBarItems,
        index: _currentIndex,
        color: Colors.white,
        height: 60,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.bounceIn,
          );
        },
      ),
    );
  }
}
