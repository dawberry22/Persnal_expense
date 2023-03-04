import "package:flutter/material.dart";
// import 'package:flutter/services.dart';
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
          ),
          bodySmall: const TextStyle(
            fontFamily: "Quicksand",
            fontSize: 15,
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
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.red,
        primarySwatch: Colors.purple,
      ),
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
    // Transaction(
    //   id: "1",
    //   title: "Nike Shoe",
    //   cost: 99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: "Bike",
    //   cost: 76,
    //   date: DateTime.now(),
    // ),
  ];
  // _addTransaction: adds new transaction to the list item
  // @txtile: transaction title
  // @txamount: transaction amount
  // Return: None
  void _addTransaction(String txtitle, double txamount, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        cost: txamount,
        date: date);
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

  bool _showChart = false;
  void _deleteTransaction(String id) {
    setState(() {
      transction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: const Text("Personal Expance"),
      actions: [
        // IconButton(
        //   onPressed: () => _startAddtx(context),
        //   icon: const Icon(Icons.add),
        // ),
        if (isLandscape)
          Row(
            children: [
              const Text(
                "Show Chart",
                style: TextStyle(fontSize: 10),
              ),
              Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  }),
            ],
          ),
      ],
    );

    final heightSize = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final txList = SizedBox(
      width: double.infinity,
      height: isLandscape ? heightSize : heightSize * 0.6,
      child: TransactionList(
        transaction: transction,
        deleteTx: _deleteTransaction,
      ),
    );
    final txChart = SizedBox(
      height: isLandscape ? heightSize * 0.8 : heightSize * 0.4,
      child: Chart(transction),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isLandscape) txChart,
            if (!isLandscape) txList,
            if (isLandscape)
              _showChart
                  ? txChart
                  :
                  // end of Chart
                  //

                  // Transactions list
                  txList
            //
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddtx(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
