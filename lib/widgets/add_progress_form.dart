import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AddProgressForm extends StatefulWidget {
  final Function addData;
  const AddProgressForm({Key? key, required this.addData}) : super(key: key);

  @override
  State<AddProgressForm> createState() => _AddProgressFormState();
}

class _AddProgressFormState extends State<AddProgressForm> {
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _done() {
    final double amountInput = double.parse(amountController.text);
    if (amountInput < 0) {
      return;
    }
    widget.addData(_selectedDate, amountInput);
    Navigator.pop(context);
  }

  Future<DateTime> _selectDate() async {
    final selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime.now());
    if (selected != null && selected != _selectedDate) {
      setState(() {
        _selectedDate = selected;
      });
    }
    return _selectedDate;
  }

  Future<TimeOfDay> _selectTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (selected != null && selected != _selectedTime) {
      setState(() {
        _selectedTime = selected;
      });
    }
    return _selectedTime;
  }

  Future _selectDateTime() async {
    final date = await _selectDate();
    final time = await _selectTime();
    setState(() {
      _selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  // https://flutterguide.com/date-and-time-picker-in-flutter/
  // Took it from here!

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(label: Text("Value")),
                controller: amountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Selcted Date:  ${Jiffy(_selectedDate).format("MMMM do yyyy, h:mm a")}"),
                  TextButton(
                      onPressed: _selectDateTime,
                      child: const Text("Change Date"))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              FloatingActionButton(
                onPressed: _done,
                backgroundColor: const Color(0xFF1D3461),
                child: const Icon(Icons.check),
              )
            ],
          ),
        ),
      ),
    );
  }
}
