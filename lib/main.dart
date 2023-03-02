import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

  void _deleteTransaction(String id) {
    setState(() {
      transction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: const Text("Personal Expance"),
      actions: [
        IconButton(
          onPressed: () => _startAddtx(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    final heightSize = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: heightSize * 0.4,
            child: Chart(transction),
          ),
          // end of Chart
          //

          // Transactions list
          SizedBox(
            height: heightSize * 0.6,
            child: TransactionList(
              transaction: transction,
              deleteTx: _deleteTransaction,
            ),
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
