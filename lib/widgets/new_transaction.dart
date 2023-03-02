import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction({super.key, required this.addtx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  var _pickedDate;

  void _showdate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  final _formKey = GlobalKey<FormState>();

  void submite() {
    if (_amountController.text.isEmpty) return;
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _pickedDate == null) return;

    widget.addtx(title, amount, _pickedDate);
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
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: "Title",
          ),
          //add transaction with submit button
          onSubmitted: (_) => submite(),
        ),
        TextField(
          controller: _amountController,
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
          child: Row(children: [
            Expanded(
              child: Text(
                _pickedDate == null
                    ? "No Date choosen"
                    : DateFormat.yMd().format(_pickedDate),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).primaryColorDark),
              ),
            ),
            TextButton(
                onPressed: _showdate,
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
              // backgroundColor: Colors.purple,
              ),
          onPressed: submite,
          child: const Text("Add transaction"),
        )
      ]),
    ));
  }
}
