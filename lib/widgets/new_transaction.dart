import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({Key? key, required this.addTX}) : super(key: key);

  final Function(String, double, DateTime) addTX;

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTX(
      enteredTitle,
      enteredAmount,
      _selectedDate!,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   val = titleInput;
              // },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,

              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   (val) => amountInput = val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Chose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: _submitData,
              child: const Text('Add Transaction'),
            )
          ],
        ),
      ),
    );
  }
}
