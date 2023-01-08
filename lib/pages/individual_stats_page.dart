import 'dart:developer';
import 'package:pie_chart/pie_chart.dart';
import 'package:stock_fantasy_flutter_app/models/individual_stat.dart';
import 'package:stock_fantasy_flutter_app/services/stock_api.dart' as stock_api;

import 'package:flutter/material.dart';

class IndividualStatsPage extends StatelessWidget {
  const IndividualStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final playername = data["playername"]!;
    final contestdate = data["playername"]!;
    log(data.toString());
    return Scaffold(
      appBar: AppBar(title: Text(playername)),
      body: FutureBuilder(
        future: stock_api.getIndividualStats(playername, contestdate),
        builder: ((context, snapshot) {
          log(snapshot.connectionState.toString());

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<IndividualStockStat> individualStatList = snapshot.data!;

            Map<String, double> dataMap = {};

            for (var stock in individualStatList) {
              dataMap[stock.name] = stock.share;
            }

            return Column(
              children: [
                Expanded(flex: 2,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PieChart(dataMap: dataMap),
                ),),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: individualStatList.length,
                      itemBuilder: (context, index) {
                        var stockName = individualStatList[index].name;
                        var share = individualStatList[index].share;
                        var delta = individualStatList[index].delta;

                        return Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: ListTile(
                            title: Text(stockName),
                            trailing: SizedBox(
                              height: 50,
                              width: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${share.toStringAsFixed(1)}%',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  Text(
                                    "₹${delta.toStringAsFixed(1)}${upDownSymbol(delta)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: getDeltaColor(delta),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          if (snapshot.hasError) {
            log(">>> ${snapshot.error}");
            return Text("Error: ${snapshot.error}");
          }

          return const Text("Lol something happened!!!");
        }),
      ),
    );
  }

  String upDownSymbol(double del) {
    if (del == 0.0) return '';
    if (del > 0.0) return ' ↑';
    return ' ↓';
  }

  Color getDeltaColor(double del) {
    if (del == 0.0) return Colors.yellow[900]!;
    if (del > 0.0) return Colors.green;
    return Colors.red;
  }
}
