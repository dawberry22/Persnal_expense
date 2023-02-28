import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction({super.key, required this.addtx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void submite() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) return;

    widget.addtx(title, amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      height: 400,
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: "Title",
          ),
          //add transaction with submit button
          onSubmitted: (_) => submite(),
        ),
        TextField(
          controller: amountController,
          decoration: const InputDecoration(
            labelText: "Amount",
          ),
          keyboardType: TextInputType.number,
          //add transaction with submit button
          onSubmitted: (_) => submite(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          onPressed: submite,
          child: const Text("Add transaction"),
        )
      ]),
    ));
  }
}
