import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 2.8,
      width: width,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
            spreadRadius: 3.0,
            offset: Offset(2.56, 2.56),
          )
        ],
        image: const DecorationImage(
          image: AssetImage('assets/logo/banner.jpg'),
          fit : BoxFit.cover,
        ),
      ),
    );
  }
}
