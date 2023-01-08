import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stock_fantasy_flutter_app/models/stock.dart';
import 'package:stock_fantasy_flutter_app/services/stock_api.dart' as stock_api;
import 'package:stock_fantasy_flutter_app/utils/app_data.dart';
import 'package:stock_fantasy_flutter_app/utils/dummy_data.dart';
import 'package:stock_fantasy_flutter_app/utils/route_name.dart';

import '../widgets/stock_Item.dart';
import '../widgets/stock_amount_selector.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final contestName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(contestName)),
      body: FutureBuilder(
        future: stock_api.getPreContestFeed(),
        builder: ((context, snapshot) {
          log(snapshot.connectionState.toString());

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<Stock> stocks = snapshot.data!;

            return ContestView(
              stocks: stocks,
              contestName: contestName,
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
}

class ContestView extends StatefulWidget {
  const ContestView({
    super.key,
    required this.stocks,
    required this.contestName,
  });

  final List<Stock> stocks;
  final String contestName;

  @override
  State<ContestView> createState() => _ContestViewState();
}

class _ContestViewState extends State<ContestView> {
  double budget = totalBudget;
  Map<String, Map<String, double>> pickedStocks = {};
  bool posting = false;

  @override
  Widget build(BuildContext context) {
    List<Stock> stockList = [];

    for (Stock stock in widget.stocks) {
      if (pickedStocks.containsKey(stock.name)) {
        stockList.insert(0, stock);
      } else {
        stockList.add(stock);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Budget Left: ₹$budget",
                    style: const TextStyle(color: Colors.white)),
                Text("Picked: ${pickedStocks.length.toString()}",
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              itemCount: stockList.length,
              itemBuilder: (context, index) {
                final name = stockList[index].name;
                final price = stockList[index].price;
                final prevPrice = previousStockData[name]!;

                return StockItem(
                  name: name,
                  price: price,
                  changePercentage: (price - prevPrice) * 100 / prevPrice,
                  isSelected: pickedStocks.containsKey(name),
                  child: pickedStocks.containsKey(name)
                      ? Text(
                          "${pickedStocks[name]?["percentage"]?.toInt() ?? 0}%")
                      : const Icon(Icons.add),
                  onPressed: () async {
                    int? percentageSelected = await showModalBottomSheet<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return StockAmountSelector(
                          name: name,
                          price: price,
                          leftBudget: budget,
                          percentage:
                              pickedStocks[name]?["percentage"]?.toInt() ?? 0,
                        );
                      },
                    );

                    if (percentageSelected == null) return;

                    double budgetUsed = totalBudget * percentageSelected / 100;

                    if (!pickedStocks.containsKey(name) && budgetUsed != 0.0) {
                      pickedStocks[name] = {
                        "buyprice": price,
                        "quantity": budgetUsed / price,
                        "amount": budgetUsed,
                        "percentage": percentageSelected.toDouble(),
                      };

                      log(">>> pickedStocks: $pickedStocks");

                      budget -= budgetUsed;

                      setState(() {});

                      return;
                    }

                    budget += pickedStocks[name]!["amount"]!;

                    pickedStocks[name]!["quantity"] = budgetUsed / price;

                    pickedStocks[name]!["amount"] = budgetUsed;

                    pickedStocks[name]!["percentage"] =
                        percentageSelected.toDouble();

                    budget -= budgetUsed;

                    if (budgetUsed == 0.0) {
                      pickedStocks.remove(name);
                    }

                    setState(() {});
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            child: posting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Submit"),
            onPressed: () async {
              if (posting) return;
              posting = true;
              setState(() {});

              await stock_api.joinContest(getPostBody());
              posting = false;
              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                routeThankYouPage,
                arguments: widget.contestName,
                (route) => false,
              );
            },
          ),
        ),
      ],
    );
  }

  String getPostBody() {
    Map<String, Map<String, double?>> data = {};

    double total = 0.0;

    for (var key in pickedStocks.keys) {
      final buyprice = pickedStocks[key]?["buyprice"];
      final quantity = pickedStocks[key]?["quantity"];
      final amount = pickedStocks[key]?["amount"];

      total += amount ?? 0.0;

      data[key] = {
        "buyprice": buyprice,
        "quantity": quantity,
        "amount": amount,
      };
    }

    return jsonEncode({
      "contestdate": contestdate,
      "teamname": "champu${math.Random().nextInt(10000)}",
      "selection": {"totalbuyamount": total, "buyinfo": data}
    });
  }
}
