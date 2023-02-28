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
    return Column(
      children: [
        Container(
          height: 25,
          child: FittedBox(
            child: Text("\$${amount.toStringAsFixed(0)}"),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 60,
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
        Text("${day.substring(0, 1)}")
      ],
    );
  }
}
