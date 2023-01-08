import 'dart:async';
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import "package:flutter/material.dart";
import 'package:image_card/image_card.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

import '../widgets/moving_chart.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({super.key});

  @override
  State<UpcomingView> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: ListView(
          children: [
            const MovingChart(height: 100),
            CardSubButton(
              onPressed: () {
                Navigator.pushNamed(context, routeNifty50,
                    arguments: "Nifty 50");
              },
              imagePath: "assets/images/stonk.jpg",
              title: Text("Nifty 50",
                  style: Theme.of(context).textTheme.headline5),
              description: Text(
                "Fantasy trade on Nifty 50 Stocks.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              tags: const [
                Tag(tag: "Contest", textColor: Colors.white),
                Tag(tag: "Earn", textColor: Colors.white),
                Tag(tag: "Win", textColor: Colors.white),
                Tag(tag: "50", textColor: Colors.white),
                Tag(tag: "#tag", textColor: Colors.white),
              ],
            ),
            CardSubButton(
              onPressed: () {
                Navigator.pushNamed(context, routeNifty50,
                    arguments: "Nifty Banks");
              },
              imagePath: "assets/images/bank.jpg",
              title: Text("Nifty Banks",
                  style: Theme.of(context).textTheme.headline5),
              description: Text(
                "Fantasy trade on Nifty Bank Stocks.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              tags: const [
                Tag(tag: "Contest", textColor: Colors.white),
                Tag(tag: "Earn", textColor: Colors.white),
                Tag(tag: "Win", textColor: Colors.white),
                Tag(tag: "#tag", textColor: Colors.white),
              ],
            ),
            CardSubButton(
              onPressed: () {
                Navigator.pushNamed(context, routeNifty50,
                    arguments: "Nifty Oil");
              },
              imagePath: "assets/images/oil.jpg",
              title: Text("Nifty Oil",
                  style: Theme.of(context).textTheme.headline5),
              description: Text(
                "Fantasy trade on Nifty Oil Stocks.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              tags: const [
                Tag(tag: "Contest", textColor: Colors.white),
                Tag(tag: "Earn", textColor: Colors.white),
                Tag(tag: "Win", textColor: Colors.white),
                Tag(tag: "Oil", textColor: Colors.white),
                Tag(tag: "#tag", textColor: Colors.white),
              ],
            ),
            CardSubButton(
              onPressed: () {
                Navigator.pushNamed(context, routeNifty50,
                    arguments: "Nifty Oil");
              },
              imagePath: "assets/images/auto.jpg",
              title: Text("Nifty Auto",
                  style: Theme.of(context).textTheme.headline5),
              description: Text(
                "Fantasy trade on Nifty Auto Stocks.",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              tags: const [
                Tag(tag: "Contest", textColor: Colors.white),
                Tag(tag: "Earn", textColor: Colors.white),
                Tag(tag: "Win", textColor: Colors.white),
                Tag(tag: "Automobile", textColor: Colors.white),
                Tag(tag: "#tag", textColor: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardSubButton extends StatelessWidget {
  const CardSubButton({
    Key? key,
    required this.tags,
    this.title,
    this.description,
    this.footer,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  final List<Widget>? tags;
  final Widget? title;
  final Widget? description;
  final Widget? footer;
  final String imagePath;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: GestureDetector(
        onTap: onPressed,
        child: FillImageCard(
          imageProvider: AssetImage(imagePath),
          width: double.infinity,
          title: title,
          description: description,
          footer: footer,
          tags: tags,
        ),
      ),
    );
  }
}

Widget _title(String title, Color color) {
  return Text(
    title,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  );
}

Widget _content(Color color) {
  return Text(
    'This a card description',
    style: TextStyle(color: color),
  );
}

class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.tag,
    this.bgColor = Colors.green,
    required this.textColor,
  });

  final String tag;
  final Color bgColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: bgColor),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        tag,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
