import 'package:flutter/material.dart';

class HealthMonitor extends StatefulWidget {
  const HealthMonitor({Key? key}) : super(key: key);

  @override
  _HealthMonitorState createState() => _HealthMonitorState();
}

class _HealthMonitorState extends State<HealthMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: const Text("Health_monitor")));
  }
}
