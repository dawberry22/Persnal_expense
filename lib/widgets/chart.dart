import './chart_bar.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  // getter for the 7 days of the week
  List<Map<String, dynamic>> get recentTransactionValue {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].cost;
        }
      }
      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    }).reversed.toList();
  }

  //getter for the fractionall sized box amount percentage
  double get amtpct {
    return recentTransactionValue.fold(0.0, (previousValue, element) {
      return previousValue + element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: recentTransactionValue.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  day: data['day'],
                  amount: data["amount"],
                  amountPct:
                      amtpct == 0 ? 0.0 : (data["amount"] as double) / amtpct,
                ),
              );
            }).toList()),
      ),
    );
  }
}
