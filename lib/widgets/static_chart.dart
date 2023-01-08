import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class StaticChart extends StatelessWidget {
  const StaticChart({
    Key? key,
    required this.data,
    this.height,
    this.color,
    this.bgColor,
  }) : super(key: key);

  final List<double> data;
  final double? height;
  final Color? color, bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor ?? Theme.of(context).colorScheme.primaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Sparkline(
        data: data,
        lineWidth: 4,
        lineColor: color ?? Theme.of(context).colorScheme.primary,
        useCubicSmoothing: true,
      ),
    );
  }
}
