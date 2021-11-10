import 'package:flutter/material.dart';

final klabelStyle = TextStyle(
  color: Colors.red.shade600,
  fontWeight: FontWeight.bold,
  fontSize: 14.0,
  fontFamily: 'OpenSans',
);

final kHintStyle =
    TextStyle(color: Colors.purple.shade400, fontFamily: 'OpenSans');

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFFFFFFFF),
  borderRadius: BorderRadius.circular(8.0),
  boxShadow: const <BoxShadow>[
    BoxShadow(
      color: Colors.grey,
      blurRadius: 6.0,
      spreadRadius: 2.0,
      offset: Offset(0, 2),
    )
  ],
);

const kErrorStyle = TextStyle(
  color: Colors.deepPurple,
  fontSize: 12.0,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w700,
);


InputDecoration kInputDecorationStyle(String hintText, dynamic icon) {
  return InputDecoration(
    errorStyle: kErrorStyle,
    border: InputBorder.none,
  //  focusedBorder: kBorderStyle,
  //  enabledBorder: kBorderStyle,
    prefixIcon: Icon(
      icon,
      color: Colors.grey,
    ),
    hintText: hintText.toString(),
    hintStyle: kHintStyle,
  );
}
