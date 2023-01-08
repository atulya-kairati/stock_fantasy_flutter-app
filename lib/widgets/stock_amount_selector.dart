import 'dart:developer';
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';

class StockAmountSelector extends StatefulWidget {
  const StockAmountSelector({
    Key? key,
    required this.name,
    required this.price,
    required this.leftBudget,
    this.percentage = 0,
  }) : super(key: key);

  final String name;
  final double price;
  final double leftBudget;
  final int percentage;
  @override
  State<StockAmountSelector> createState() => _StockAmountSelectorState();
}

class _StockAmountSelectorState extends State<StockAmountSelector> {
  int percentage = 0;
  double leftBudget = 0.0;
  List<double> data = [];

  @override
  void initState() {
    super.initState();
    percentage = widget.percentage;
    leftBudget = widget.leftBudget;

    for (var i = 0; i < 20; i++) {
      data.add(Random().nextDouble() * 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      height: 400,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style: Theme.of(context).textTheme.headline4),
                  Text(
                    "₹ ${widget.price}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    "Budget Used: ₹ ${getBudgetUsed(per: percentage)}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ColoredRoundIconButton(
                    icon: Icons.remove,
                    onPressed: () {
                      changePercentVal(-1);
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$percentage%",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  ColoredRoundIconButton(
                    icon: Icons.add,
                    onPressed: () {
                      changePercentVal(1);
                    },
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    size: 32,
                  ),
                ],
              )
            ],
          ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Sparkline(
                data: data,
                lineWidth: 4,
                lineColor: Theme.of(context).colorScheme.primary,
                useCubicSmoothing: true,
              ),
            ),
          ),

          const Text("Trend Graph (for demo only)"),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, percentage);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void changePercentVal(int del) {
    if (percentage <= 0 && del < 0) return;
    if (percentage >= 100 && del > 0) return;

    // TODO: Fix bug

    percentage += del;
    if (leftBudget == 0.0) {
      if (del < 0) {
      } else {
        if (!(percentage <= widget.percentage)) {
          percentage -= del;
        }
      }

      setState(() {});

      return;
    }

    // log("left bud $leftBudget");
    // log(percentage.toString());

    double budgetUsed = double.parse(getBudgetUsed(per: percentage));
    if (leftBudget < budgetUsed) {
      percentage -= del;
      return;
    }

    setState(() {});
  }

  String getBudgetUsed({int per = 0}) {
    return (percentage * totalBudget / 100).toStringAsFixed(2);
  }

  void adjustLeftBudget() {
    leftBudget = (widget.percentage - percentage) * totalBudget / 100;
  }
}

class ColoredRoundIconButton extends StatelessWidget {
  const ColoredRoundIconButton(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.iconColor,
      required this.size,
      required this.icon});

  final void Function() onPressed;
  final Color backgroundColor, iconColor;
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
    );
  }
}
