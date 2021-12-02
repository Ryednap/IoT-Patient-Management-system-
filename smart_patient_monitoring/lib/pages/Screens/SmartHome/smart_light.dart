import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/service/smartHome_api.dart';

class SmartLight extends StatefulWidget {
  const SmartLight({Key? key}) : super(key: key);

  @override
  _SmartLightState createState() => _SmartLightState();
}

class _SmartLightState extends State<SmartLight> {
  String _state = "OFF";

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 24.0,
      shadowColor: Colors.blue,
      child: Ink(
        height: 160.0,
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () {
            print("You tapped");
            setState(() {
              if (_state == "ON") {
                _state = "OFF";
              } else {
                _state = "ON";
              }
              createPostRequest("/smart_home/smartLight", _state);
            });
          },
          splashColor: Colors.greenAccent.shade100.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AvatarGlow(
                glowColor: (_state == "ON" ? Colors.amberAccent : Colors.white),
                duration: const Duration(milliseconds: 3000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 14.0,
                  shape: const CircleBorder(),
                  shadowColor:
                      (_state == "ON" ? Colors.redAccent : Colors.grey),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: Image.asset('assets/images/bulbGlow.png'),
                    radius: 25.0,
                  ),
                ),
                endRadius: 60.0,
                animate: true,
                curve: Curves.fastOutSlowIn,
              ),
              Text(
                _state,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Peralta",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
