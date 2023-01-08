import 'package:flutter/material.dart';

import '../models/stock.dart';

class StockStatView extends StatelessWidget {
  const StockStatView(
      {super.key,
      required this.currentStockPrices,
      required this.previousStockPrices});

  final List<Stock> currentStockPrices;
  final Map<String, double> previousStockPrices;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: currentStockPrices.length,
        itemBuilder: (context, index) {
          final name = currentStockPrices[index].name;
          final price = currentStockPrices[index].price;
          final prevPrice = previousStockPrices[name]!;
          final delPercentage = (price - prevPrice) * 100 / prevPrice;

          return Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile(
              title: Text(name),
              trailing: SizedBox(
                height: 50,
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Text(
                      "${delPercentage.abs().toStringAsFixed(1)}%${upDownSymbol(delPercentage)}",
                      style: TextStyle(
                        color: getScoreColor(delPercentage),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String upDownSymbol(double per) {
    if (per == 0.0) return '';
    if (per > 0.0) return ' ↑';
    return ' ↓';
  }

  Color getScoreColor(double score) {
    if (score == 0.0) return Colors.yellow[900]!;
    if (score > 0.0) return Colors.green;
    return Colors.red;
  }
}
