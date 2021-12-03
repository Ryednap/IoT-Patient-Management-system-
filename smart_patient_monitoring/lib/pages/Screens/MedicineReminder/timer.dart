import 'package:flutter/material.dart';
import 'dart:math' as math;

class Timer extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final duration;
  const Timer({Key? key, required this.duration}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    const size = 80.0;
    return TweenAnimationBuilder<double>(
      duration: widget.duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        final percentage = (value * 100).round();
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    startAngle: 0.0,
                    endAngle: 2 * math.pi,
                    stops: [value, value],
                    center: Alignment.center,
                    colors: [Colors.redAccent, Colors.grey.withAlpha(55)],
                  ).createShader(rect);
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/radial_scale.png'),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size - 23.0,
                  height: size - 23.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "$percentage",
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
