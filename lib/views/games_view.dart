import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

import '../widgets/image_button.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: ListView(
        children: [
          ImageButton(
            imagePath: "assets/images/mega.jpg",
            onPressed: () {
              Navigator.pushNamed(context, routeContestPage,
                  arguments: "Mega Contest");
            },
            title: getTitle(context, "Mega Contest"),
            description:
                getDescription(context, "Win ₹ 100000", "Entry: ₹ 10", "500/2000"),
          ),
          ImageButton(
            imagePath: "assets/images/pro.jpg",
            onPressed: () {
              Navigator.pushNamed(context, routeContestPage,
              arguments: "Pro Contest");
            },
            title: getTitle(context, "Pro Contest"),
            description:
                getDescription(context, "Win ₹ 100000", "Entry: ₹ 1000", "15/20"),
          ),
          ImageButton(
            imagePath: "assets/images/pro.jpg",
            onPressed: () {
              Navigator.pushNamed(context, routeContestPage,
              arguments: "Pro Contest");
            },
            title: getTitle(context, "Pro Contest"),
            description:
                getDescription(context, "Win ₹ 1000", "Entry: ₹ 10", "45/100"),
          ),
        ],
      ),
    );
  }
}

Padding getTitle(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: Theme.of(context).textTheme.headline5?.copyWith(
            color: Colors.white,
          ),
    ),
  );
}

Row getDescription(
  BuildContext context,
  String text1,
  String text2,
  String text3,
) {
  var subtitleStyle = Theme.of(context).textTheme.subtitle1?.copyWith(
        color: Colors.white,
      );

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        text1,
        style: subtitleStyle,
      ),
      Text(
        text2,
        style: subtitleStyle,
      ),
      Text(
        text3,
        style: subtitleStyle,
      ),
    ],
  );
}
