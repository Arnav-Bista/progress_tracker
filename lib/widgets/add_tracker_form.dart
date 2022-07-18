import 'package:flutter/material.dart';

class AddTrackerForm extends StatefulWidget {
  final Function addTracker;
  const AddTrackerForm({Key? key, required this.addTracker}) : super(key: key);

  @override
  State<AddTrackerForm> createState() => _AddTrackerFormState();
}

class _AddTrackerFormState extends State<AddTrackerForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _done() {
    final String titleInput = titleController.text;
    var descirptionInput = descriptionController.text;
    if (titleInput.isEmpty) {
      return;
    }
    if (descirptionInput.isEmpty) {
      descirptionInput = " ";
    }
    widget.addTracker(titleInput, descirptionInput);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Title")),
              controller: titleController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Description")),
              controller: descriptionController,
              textInputAction: TextInputAction.done,
              onEditingComplete: _done,
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
    );
  }
}
