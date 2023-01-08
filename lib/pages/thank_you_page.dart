import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

import '../utils/dummy_data.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contestName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(contestName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle_outlined,
                      size: 100,
                      color: Colors.green
                    ),
                  ),
                ),
                Text(
                  "You have joined $contestName for ${contestdateObj.day} ${months[contestdateObj.month - 1]} successfully!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  routeMain,
                  (route) => false,
                );
              },
              child: const Text("Play More Games"),
            )
          ],
        ),
      ),
    );
  }
}
