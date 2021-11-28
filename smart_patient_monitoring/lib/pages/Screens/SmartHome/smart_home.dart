import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_patient_monitoring/pages/Screens/SmartHome/smart_light.dart';
import 'package:smart_patient_monitoring/pages/Screens/SmartHome/smart_tv.dart';
import 'package:smart_patient_monitoring/pages/Screens/SmartHome/temperature_monitor.dart';
import 'package:smart_patient_monitoring/setting/custom_icons.dart';
import 'package:tuple/tuple.dart';

class SmartHome extends StatefulWidget {
  const SmartHome({Key? key}) : super(key: key);

  @override
  _SmartHomeState createState() => _SmartHomeState();
}

class _SmartHomeState extends State<SmartHome> {
  bool status = false;
  TimeOfDay acOnTime = const TimeOfDay(hour: 20, minute: 12);

  Tuple2 getRunningTime() {
    TimeOfDay now = TimeOfDay.now();
    return Tuple2(now.hour - acOnTime.hour, now.minute - acOnTime.hour);
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Tuple2 acTime = getRunningTime();
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bcg3_page2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 15, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Living Room",
              style: TextStyle(
                fontFamily: "Trajan Pro",
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "AC is Running last",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "${acTime.item1} hour ${acTime.item2} minute",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: FlutterSwitch(
                    width: 120.0,
                    height: 60.0,
                    toggleSize: 60.0,
                    value: status,
                    activeColor: Colors.greenAccent.shade100,
                    inactiveColor: Colors.redAccent.shade100,
                    activeToggleColor: Colors.green,
                    inactiveToggleColor: Colors.red,
                    activeSwitchBorder:
                        Border.all(color: Colors.teal, width: 2.0),
                    activeToggleBorder:
                        Border.all(color: Colors.teal.shade900, width: 1.5),
                    inactiveSwitchBorder: Border.all(
                        color: Colors.deepOrange.shade900, width: 2.0),
                    inactiveToggleBorder:
                        Border.all(color: Colors.pinkAccent, width: 1.5),
                    showOnOff: true,
                    activeTextColor: Colors.green.shade900,
                    inactiveTextColor: Colors.red.shade900,
                    valueFontSize: 20.0,
                    activeIcon: const Icon(Icons.ac_unit_rounded),
                    inactiveIcon: const Icon(Icons.do_not_disturb_off_rounded),
                    onToggle: (val) {
                      setState(() {
                        status = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Center(
              child: TemperatureMonitor(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 30.0, 5.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [SmartLight(), SmartTV()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
