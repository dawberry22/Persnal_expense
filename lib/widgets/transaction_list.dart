import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  TransactionList({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  "There isn't any data",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: Image.asset("assets/images/waiting.png")),
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text("\$${transaction[index].cost}")),
                      ),
                    ),
                    title: Text(transaction[index].title,
                        style: Theme.of(context).textTheme.bodyMedium),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transaction[index].date),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
