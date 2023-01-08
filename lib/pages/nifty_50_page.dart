import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/views/games_view.dart';
import 'package:stock_fantasy_flutter_app/views/influencer_view.dart';

class Nifty50Page extends StatelessWidget {
  const Nifty50Page({super.key});

  @override
  Widget build(BuildContext context) {

    final name = ModalRoute.of(context)!.settings.arguments as String;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
          bottom: const TabBar(tabs: [
            Tab(text: "Games",),
            Tab(text: "Influencers",)
          ]),
        ),
        body:  const TabBarView(
            children: [
              GamesView(),
              InfluencerView(),
            ],
          ),
      ),
    );
  }
}