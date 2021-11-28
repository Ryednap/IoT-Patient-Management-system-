import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class SmartLight extends StatefulWidget {
  const SmartLight({Key? key}) : super(key: key);

  @override
  _SmartLightState createState() => _SmartLightState();
}

class _SmartLightState extends State<SmartLight> {
  String _state = "ON";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      width: 160.0,
      margin: const EdgeInsets.all(10.0),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AvatarGlow(
            glowColor: Colors.amberAccent,
            duration: const Duration(milliseconds: 3000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: Material(
              elevation: 14.0,
              shape: const CircleBorder(),
              shadowColor: Colors.redAccent,
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
    );
  }
}
