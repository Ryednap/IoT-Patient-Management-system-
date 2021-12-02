import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/service/smartHome_api.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureMonitor extends StatefulWidget {
  const TemperatureMonitor({Key? key}) : super(key: key);

  @override
  _TemperatureMonitorState createState() => _TemperatureMonitorState();
}

class _TemperatureMonitorState extends State<TemperatureMonitor> {
  final List<Color> colorList = const <Color>[
    Color(0xFF94e9eb),
    Color(0xFFd6ecef),
    Color(0xFFe7feff),
    Colors.white,
    Color(0xFFfaf398),
    Color(0xFFfadc96),
    Color(0xFFfab496),
  ];

  List<Color> rangeMarkerGradientColorList = [];
  double value = 13;

  void _changeGradientColor() {
    List<Color> newRangeMarkerGradientColorList = [];
    newRangeMarkerGradientColorList.add(colorList.elementAt(0));
    newRangeMarkerGradientColorList.add(colorList.elementAt(1));
    if (value > 10.0) {
      newRangeMarkerGradientColorList.add(colorList.elementAt(2));
    }
    if (value >= 20.0) {
      newRangeMarkerGradientColorList.add(colorList.elementAt(3));
    }
    if (value >= 30.0) {
      newRangeMarkerGradientColorList.add(colorList.elementAt(4));
    }
    if (value >= 40.0) {
      newRangeMarkerGradientColorList.add(colorList.elementAt(5));
    }
    if (value > 45.0) newRangeMarkerGradientColorList.add(colorList.last);
    rangeMarkerGradientColorList = List.from(newRangeMarkerGradientColorList);
  }

  String _weatherImage() {
    if (value <= 20) {
      return "assets/images/snowflakes.png";
    } else if (value < 40.0) {
      return "assets/images/sunny.png";
    } else {
      return "assets/images/extreme.png";
    }
  }

  BoxShadow _weatherShadowColor() {
    if (value <= 20) {
      return BoxShadow(
        color: Colors.blueAccent.withOpacity(0.2),
        spreadRadius: 10,
        blurRadius: 10,
        offset: const Offset(0, 3), // changes position of shadow
      );
    } else if (value < 40.0) {
      return BoxShadow(
        color: Colors.amberAccent.withOpacity(0.2),
        spreadRadius: 10,
        blurRadius: 10,
        offset: const Offset(0, 3), // changes position of shadow
      );
    } else {
      return BoxShadow(
        color: Colors.orangeAccent.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 10,
        offset: const Offset(0, 3), // changes position of shadow
      );
    }
  }

  late Timer _timer;
  @override
  void initState() {
    _changeGradientColor();
    _timer =
        Timer.periodic(const Duration(milliseconds: 2000), (Timer t) async {
      value = await createGetRequest("/smart_home/temperature");
      _changeGradientColor();
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      width: 300,
      height: 300,
      child: _getRadialGauge(),
    );
  }

  Widget _getRadialGauge() {
    return Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent.shade100.withOpacity(0.1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1.0,
              blurRadius: 10.0),
        ],
      ),
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            minimum: -20,
            maximum: 100,
            axisLineStyle: const AxisLineStyle(
                thickness: 25,
                cornerStyle: CornerStyle.bothCurve,
                color: Color(0xFFebd8e6)),
            pointers: <GaugePointer>[
              RangePointer(
                value: value,
                animationType: AnimationType.elasticOut,
                width: 15,
                pointerOffset: 5,
                enableAnimation: true,
                cornerStyle: CornerStyle.bothCurve,
                gradient: SweepGradient(colors: rangeMarkerGradientColorList),
              ),
              MarkerPointer(
                value: value,
                markerType: MarkerType.circle,
                markerWidth: 20,
                markerHeight: 20,
                color: const Color(0xFFd33bd4).withOpacity(0.6),
                borderColor: Colors.purple,
                animationType: AnimationType.elasticOut,
                borderWidth: 2,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(_weatherImage()),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [_weatherShadowColor()],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text('$value°C',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),
                    ),
                  ],
                ),
                angle: 250,
                positionFactor: 0.1,
              ),
            ],
          ),
          RadialAxis(
            showLabels: false,
            showTicks: false,
            axisLineStyle: AxisLineStyle(
              color: Colors.pinkAccent.shade100.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
