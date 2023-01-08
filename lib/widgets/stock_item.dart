import 'package:flutter/material.dart';

class StockItem extends StatelessWidget {
  const StockItem({
    Key? key,
    required this.name,
    required this.price,
    required this.onPressed,
    this.isSelected = false,
    required this.child,
    required this.changePercentage,
  }) : super(key: key);

  final String name;
  final double price;
  final double changePercentage;
  final bool isSelected;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                    style: BorderStyle.solid,
                  )
                : null,
            borderRadius: BorderRadius.circular(2)),
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                 (changePercentage < 0) ? Icons.arrow_downward: Icons.arrow_upward,
                color:  (changePercentage < 0) ? Colors.red : Colors.green,
              ),
              Text(
                "${changePercentage.abs().toStringAsFixed(1)}%",
                style: TextStyle(
                  color: (changePercentage < 0) ? Colors.red : Colors.green,
                ),
              )
            ],
          ),
          title: Text(name),
          subtitle: Text("₹ $price"),
          trailing: SizedBox(
            height: 70,
            width: 70,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
