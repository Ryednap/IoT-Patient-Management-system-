import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_patient_monitoring/pages/Login/login.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicineProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          cardColor: Colors.blueAccent,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Patient Monitoring',
        home: const LoginPage(),
      ),
    );
  }
}
