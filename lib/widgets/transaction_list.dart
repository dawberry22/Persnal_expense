import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  const TransactionList(
      {super.key, required this.transaction, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "There isn't any data",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset("assets/images/waiting.png")),
              ],
            );
          })
        : ListView(
            children: transaction
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      deleteTx: deleteTx,
                      transaction: tx,
                    ))
                .toList(),
          );
  }
}
