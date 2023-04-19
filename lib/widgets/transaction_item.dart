import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    key,
    required this.deleteTx,
    required this.transaction,
  }) : super(key: key);
  final Function deleteTx;
  final transaction;
  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;

  @override
  void initState() {
    const colorsScheme = [
      Colors.black,
      Colors.blue,
      Colors.green,
      Colors.purple,
    ];
    print(Random().nextInt(4));
    setState(() {
      _bgColor = colorsScheme[Random().nextInt(4)];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
                child: Text(
              "\$${widget.transaction.cost}",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
        title: Text(widget.transaction.title,
            style: Theme.of(context).textTheme.bodyMedium),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => widget.deleteTx(widget.transaction.id),
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
