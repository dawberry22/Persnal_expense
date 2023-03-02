import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double amountPct;
  ChartBar(
      {super.key,
      required this.day,
      required this.amount,
      required this.amountPct});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) => Column(
        children: [
          Container(
            height: constraint.maxHeight * 0.15,
            child: FittedBox(
              child: Text("\$${amount.toStringAsFixed(0)}"),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: constraint.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: amountPct,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text("${day.substring(0, 1)}"),
              ))
        ],
      ),
    );
  }
}
