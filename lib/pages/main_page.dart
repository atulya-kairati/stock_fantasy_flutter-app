import 'package:flutter/material.dart';

import 'package:stock_fantasy_flutter_app/views/my_games_view.dart';
import 'package:stock_fantasy_flutter_app/views/upcoming_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fantasy Sport"),
          bottom: const TabBar(tabs: [
            Tab(text: "Upcoming",),
            Tab(text: "My Games",)
          ]),
        ),
        body:  const TabBarView(
            children: [
              UpcomingView(),
              MyGamesView(),
            ],
          ),
      ),
    );
  }
}

