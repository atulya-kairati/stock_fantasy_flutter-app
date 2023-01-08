import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

import '../widgets/circular_image_with_border.dart';

class InfluencerView extends StatelessWidget {
  const InfluencerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 2,
        children: getInfluencerWidgetList(context),
      ),
    );
  }

  List<Widget> getInfluencerWidgetList(BuildContext context) {
    return influencers.keys
        .toList()
        .map(
          (name) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, routeInfluencerDetail,
                    arguments: name);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: name,
                    child: CircularImageWithBorder(
                      borderColor: Theme.of(context).colorScheme.inversePrimary,
                      imagePath: "assets/images/${influencerPics[name]}",
                      radius: 50,
                      borderRadius: 4,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }
}
