import 'package:flutter/material.dart';

import '../models/trackers.dart';
import './chart.dart';
import './progress_list.dart';
import './add_progress_form.dart';

class ProgressAndChart extends StatefulWidget {
  final Tracker data;
  final VoidCallback saveData;
  const ProgressAndChart({Key? key, required this.data, required this.saveData})
      : super(key: key);

  @override
  State<ProgressAndChart> createState() => _ProgressAndChartState();
}

class _ProgressAndChartState extends State<ProgressAndChart> {
  final _targetController = TextEditingController();

  void _updateTarget() {
    final inputTarget = double.parse(_targetController.text);
    if (inputTarget <= 0) {
      return;
    }
    setState(() {
      widget.data.target = inputTarget;
    });
    widget.saveData();
    Navigator.of(context).pop();
  }

  void _addData(DateTime date, double data) {
    if (widget.data.data.isEmpty) {
      setState(() {
        widget.data.data.add(Progress(date: date, data: data));
      });
      widget.saveData();
      return;
    }

    for (int i = 0; i < widget.data.data.length; i++) {
      if (widget.data.data[i].date.isBefore(date)) {
        setState(() {
          widget.data.data.insert(i, Progress(date: date, data: data));
        });
        widget.saveData();
        return;
      }
    }

    // DateTime could be duplicate, test before adding it to the end
    for (int i = 0; i < widget.data.data.length; i++) {
      if (widget.data.data[i].date.isAtSameMomentAs(date)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The same date entry already exists!")));
        return;
      }
    }

    setState(() {
      widget.data.data.add(Progress(date: date, data: data));
    });
    widget.saveData();
  }

  void _deleteData(int index) {
    setState(() {
      widget.data.data.removeAt(index);
    });
    widget.saveData();
  }

  void _showProgressAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: ((context) {
        return AddProgressForm(addData: _addData);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.data.data.isEmpty
            ? Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("No progress recorded yet..."),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/zzz.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    ],
                  ),
                ),
              )
            : Chart(data: widget.data.data, target: widget.data.target),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target: ${widget.data.target == 0 ? "No Target set" : widget.data.target}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Enter your target:"),
                            content: TextField(
                              keyboardType: TextInputType.number,
                              controller: _targetController,
                              textInputAction: TextInputAction.done,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: _updateTarget,
                                  child: const Text("Confirm")),
                            ],
                          );
                        });
                  },
                  child: const Text("Change target"))
            ],
          ),
        ),
        ProgressList(
            data: widget.data.data,
            showProgressAdd: _showProgressAdd,
            deleteData: _deleteData)
      ],
    );
  }
}
