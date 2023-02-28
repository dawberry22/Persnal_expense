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
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      )),
                      child: Text(
                        "\$ ${transaction[index].cost.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            // fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction[index].title,
                            style: const TextStyle(fontSize: 18)),
                        Text(
                          DateFormat.yMMMd().format(transaction[index].date),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ]),
                );
              },
            ),
    );
  }
}
