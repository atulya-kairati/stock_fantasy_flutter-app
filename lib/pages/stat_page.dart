import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/services/stock_api.dart' as stock_api;
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';
import 'package:stock_fantasy_flutter_app/views/leaderboard_view.dart';
import 'package:stock_fantasy_flutter_app/views/stock_stat_view.dart';

class StatPage extends StatelessWidget {
  const StatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contestdate = ModalRoute.of(context)!.settings.arguments as String;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nifty 50 Mega Contest for $contestdate"),
          bottom: const TabBar(tabs: [
            Tab(
              text: "Leader Board",
            ),
            Tab(
              text: "Stock Stats",
            )
          ]),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: stock_api.getLeaderBoard(contestdate),
              builder: (context, snapshot) {
                log(snapshot.connectionState.toString());

                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final leaderBoard = snapshot.data!;

                  return LeaderBoardView(
                    leaderBoard: leaderBoard,
                    contestdate: contestdate,
                  );
                }

                if (snapshot.hasError) {
                  log(">>> ${snapshot.error}");
                  return Text("Error: ${snapshot.error}");
                }

                return const Text("Lol something happened!!!");
              },
            ),
            FutureBuilder(
              future: stock_api.getPreContestFeed(),
              builder: ((context, snapshot) {
                log(snapshot.connectionState.toString());

                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final stocks = snapshot.data!;
                  log(stocks.toString());
                  return StockStatView(
                    currentStockPrices: stocks,
                    previousStockPrices: previousStockData,
                  );
                }

                if (snapshot.hasError) {
                  log(">>> ${snapshot.error}");
                  return Text("Error: ${snapshot.error}");
                }

                return const Text("Lol something happened!!!");
              }),
            ),
          ],
        ),
      ),
    );
  }
}
