import 'package:flutter/material.dart';

import 'package:stock_fantasy_flutter_app/views/my_games_view.dart';
import 'package:stock_fantasy_flutter_app/views/upcoming_view.dart';

const List<String> items = ["Profile", "Watchlist", "Portfolio", "Perfomance", "Exit"];

class MainPage extends StatelessWidget {
  const MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Fantasy Sport"),
          actions: [PopupMenuButton(itemBuilder: ((context) {
            return List.generate(5, (index) => PopupMenuItem(child: Text(items[index])));
          }))],
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

