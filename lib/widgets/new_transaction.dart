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
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "No Date choosen",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).primaryColorDark),
            ),
            TextButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, blurRadius: 3, spreadRadius: 0),
                      ]),
                  height: 40,
                  width: 100,
                  child: Center(child: Text("Pick Date")),
                ))
          ]),
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
