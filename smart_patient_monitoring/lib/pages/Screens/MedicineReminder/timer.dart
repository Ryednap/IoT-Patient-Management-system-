import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_patient_monitoring/pages/Screens/MedicineReminder/model/medicine_provider.dart';
import 'dart:math' as math;

import 'package:smart_patient_monitoring/service/med_reminder_api.dart';

List<dynamic> done = [];

class TimerWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final duration;
  final data;
  final model;
  const TimerWidget(
      {Key? key,
      required this.duration,
      required this.data,
      required this.model})
      : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerWidget> {
  bool valid() {
    for (int i = 0; i < done.length; ++i) {
      if (done[i] == widget.model!.id) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    const size = 80.0;
    return TweenAnimationBuilder<double>(
      duration: widget.duration,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        final percentage = (value * 100).round();
        if (percentage == 100 && valid()) {
          done.add(widget.model!.id);
          MedicineReminderAPI.createRingPostRequest(widget.data);
          Timer(const Duration(seconds: 15), () {
            MedicineReminderAPI.createRingPostRequest("fdfdf");
            Provider.of<MedicineProvider>(context, listen: false)
                .deleteModel(widget.model);
          });
        }
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
