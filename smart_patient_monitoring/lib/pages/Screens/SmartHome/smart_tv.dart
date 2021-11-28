import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class SmartTV extends StatefulWidget {
  const SmartTV({Key? key}) : super(key: key);

  @override
  _SmartTVState createState() => _SmartTVState();
}

class _SmartTVState extends State<SmartTV> {
  final _state = "ON";
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
            glowColor: Colors.lightBlue,
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
    );
  }
}
