import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/medicine_card.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_model.dart';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({Key? key}) : super(key: key);

  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

// TODO: Check if the ringTime is stale else app will crash
class _MedicineReminderState extends State<MedicineReminder> {
  List<MedicineCard> medList = [
    MedicineCard(
      model: MedicineModel(
        medName: "Anti Histamine",
        medType: "Anti-Bacterial",
        description: "Loreum Ipsum dfdfdfdf dfdfdfadfadsfadfdasfasdfdasfasdfa",
        ringTime: const TimeOfDay(hour: 23, minute: 00),
      ),
    ),
    MedicineCard(
      model: MedicineModel(
        medName: "Anti Histamine",
        medType: "Anti-bacterial",
        description: "Loreum Ipsum",
        ringTime: const TimeOfDay(hour: 23, minute: 00),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bcg_page1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(width * (height / 120), height),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/curve_top_page1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  "Hello Ujjwal",
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontFamily: 'Lobster',
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: height / 5),
                height: 80.0,
                width: 80.0,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                  backgroundColor: Colors.tealAccent.shade400,
                  foregroundColor: Colors.brown.shade600,
                  splashColor: Colors.amberAccent.shade100,
                  elevation: 14.0,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: height / 2.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: medList,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
