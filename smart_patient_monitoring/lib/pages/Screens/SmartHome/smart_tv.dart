import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/service/http_service.dart';

class SmartTV extends StatefulWidget {
  const SmartTV({Key? key}) : super(key: key);

  @override
  _SmartTVState createState() => _SmartTVState();
}

class _SmartTVState extends State<SmartTV> {
  String _state = "OFF";

  @override
  Widget build(BuildContext context) {
    print("Hello from smart_tv");
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
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 10.0,
              blurRadius: 8.0,
              offset: const Offset(1.0, 3.0),
            ),
          ],
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
              createPostRequest("/smart_home/smartTv", _state);
            });
          },
          splashColor: Colors.greenAccent.shade100.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AvatarGlow(
                glowColor: (_state == "ON" ? Colors.lightBlue : Colors.white),
                duration: const Duration(milliseconds: 3000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 14.0,
                  shape: const CircleBorder(),
                  shadowColor: Colors.blueAccent,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/smart_tv.png'),
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
