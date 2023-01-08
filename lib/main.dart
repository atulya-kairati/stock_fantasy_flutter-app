import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/pages/contest_page.dart';
import 'package:stock_fantasy_flutter_app/pages/individual_stats_page.dart';
import 'package:stock_fantasy_flutter_app/pages/influencer_detail.dart';
import 'package:stock_fantasy_flutter_app/pages/nifty_50_page.dart';
import 'package:stock_fantasy_flutter_app/pages/stat_page.dart';
import 'package:stock_fantasy_flutter_app/pages/thank_you_page.dart';
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';
import 'package:stock_fantasy_flutter_app/services/stock_api.dart' as stock_api;

import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
  stock_api.getContest().then((value) {
    log(value);
    contestdate = value;
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6935d3),
        brightness: Brightness.light,
        // useMaterial3: true,
      ),
      initialRoute: routeMain,
      routes: {
        routeMain: (context) => const MainPage(),
        routeNifty50: (context) => const Nifty50Page(),
        routeInfluencerDetail: (context) => const InfluencerDetail(),
        routeContestPage: (context) => const ContestPage(),
        routeThankYouPage: ((context) => const ThankYouPage()),
        routeStatPage: (context) => const StatPage(),
        routeIndividualStatPage: (context) => const IndividualStatsPage(),
      },
    );
  }
}
