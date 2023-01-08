import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';
import 'package:stock_fantasy_flutter_app/widgets/image_button.dart';

class MyGamesView extends StatelessWidget {
  const MyGamesView({super.key});

  @override
  Widget build(BuildContext context) {
    String text =
        "Nifty 50 Mega Contest for ${contestdateObj.day} ${months[contestdateObj.month - 1]}";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: ListView(
        children: [
          ImageButton(
            imagePath: "assets/images/mega.jpg",
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Not Started yet!",
                toastLength: Toast.LENGTH_SHORT,
              );
            },
            title: Text(
              "Nifty 50 Mega Contest for 10 January",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
            description: Text(
              "Upcoming",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ImageButton(
            imagePath: "assets/images/mega.jpg",
            onPressed: () {
              Navigator.pushNamed(context, routeStatPage,
                  arguments: contestdate);
            },
            title: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
            description: Text(
              "Live",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ),
          ImageButton(
            imagePath: "assets/images/mega.jpg",
            onPressed: () {
              Navigator.pushNamed(context, routeStatPage,
                  arguments: "06-01-2023");
            },
            title: Text(
              "Nifty 50 Mega Contest for 6 January",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
            description: Text(
              "Completed",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class SubtitleButton extends StatelessWidget {
  const SubtitleButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.subtitle,
  }) : super(key: key);

  final String text, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(text),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
