import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:chart_sparkline/chart_sparkline.dart';
import "package:flutter/material.dart";

class MovingChart extends StatefulWidget {
  const MovingChart({
    Key? key,
    required this.height,
    this.color,
    this.bgColor,
  }) : super(key: key);

  final double height;
  final Color? color, bgColor;

  @override
  State<MovingChart> createState() => _MovingChartState();
}

class _MovingChartState extends State<MovingChart> {
  List<double> data = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 20; i++) {
      data.add(Random().nextDouble());
    }

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // print(timer);
        mutateData();
        data = [...data];
      });
    });
  }

  mutateData() {
    data.add(Random().nextDouble());
    data.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    // print(timer);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Sparkline(
            data: data,
            lineWidth: 4,
            lineColor: Theme.of(context).colorScheme.primary,
            useCubicSmoothing: true,
          ),
        ),
      ),
    );
  }

  

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    dev.log("Chart Destroyrd");
  }
}
