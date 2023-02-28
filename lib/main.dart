import "package:flutter/material.dart";
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MaterialApp(
    title: "enpance app",
    theme: ThemeData(
      fontFamily: "Quicksand",
      textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: const TextStyle(
            fontFamily: "Quicksand",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      primarySwatch: Colors.purple,
      accentColor: Colors.red,
    ),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transction = [
    Transaction(
      id: "1",
      title: "Nike Shoe",
      cost: 99,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: "Bike",
      cost: 76,
      date: DateTime.now(),
    ),
  ];
  // _addTransaction: adds new transaction to the list item
  // @txtile: transaction title
  // @txamount: transaction amount
  // Return: None
  void _addTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        cost: txamount,
        date: DateTime.now());
    // to update the state when new list item is added
    setState(() {
      transction.add(newTx);
    });
  }

  // _startAddtx: opens bottom modal sheet
  // @ctx: context to passed to the function
  void _startAddtx(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: NewTransaction(
                addtx: _addTransaction,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expance"),
        actions: [
          IconButton(
            onPressed: () => _startAddtx(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Chart(transction),
          // end of Chart
          //

          // Transactions list
          TransactionList(
            transaction: transction,
          ),
          //
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddtx(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
