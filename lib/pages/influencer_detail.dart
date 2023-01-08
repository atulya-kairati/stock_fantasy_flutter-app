import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/widgets/circular_image_with_border.dart';
import 'package:stock_fantasy_flutter_app/widgets/static_chart.dart';

class InfluencerDetail extends StatelessWidget {
  const InfluencerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments as String;
    dev.log(name);
    final color = Theme.of(context).colorScheme.primary;
    final text =
        "$name's picks for ${contestdateObj.day} ${months[contestdateObj.month - 1]}";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Influencer's Pick"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListItem(
              color: color,
              height: 200,
              text: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: name,
                    child: CircularImageWithBorder(
                      imagePath: 'assets/images/${influencerPics[name]}',
                      radius: 60,
                      borderRadius: 4,
                      borderColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...getStockListItem(name, context),
                ],
              ),
            ),
            Center(
              child: Text(
                "Past Performance",
                style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            StaticChart(
              data: [for (var i = 0; i < 20; i++) Random().nextDouble()],
              color: Colors.green,
              bgColor: Colors.green[100],
            )
          ],
        ),
      ),
    );
  }

  List<ListItem> getStockListItem(String name, BuildContext context) {
    return influencers[name]!
        .map(
          (e) => ListItem(
            color: Theme.of(context).colorScheme.primaryContainer,
            text: Text(
              e,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        )
        .toList();
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.color,
    required this.text,
    this.height = 64,
  }) : super(key: key);

  final Color? color;
  final Widget text;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: text,
      ),
    );
  }
}
