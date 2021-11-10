import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 110.0,
        width: 110.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/logo/WeCare_logo.jpeg'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6.0,
              spreadRadius: 3.0,
              offset: Offset(0, 2.0),
            )
          ]
        ),
      ),
    );
  }
}
