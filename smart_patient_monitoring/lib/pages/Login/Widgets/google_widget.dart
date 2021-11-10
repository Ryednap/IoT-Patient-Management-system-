import 'package:flutter/material.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 5.0),
      height: 40.0,
      width: 60.0,
      //color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
            spreadRadius: 2.0,
            offset: Offset(0, 1.0),
          )
        ],
        image: DecorationImage(image: AssetImage('assets/logo/google.png')),
      ),
    );
  }
}