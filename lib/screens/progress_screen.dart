import 'package:flutter/material.dart';

import '../models/trackers.dart';
import '../widgets/progress_and_chart.dart';

class ProgressScreen extends StatelessWidget {
  final Tracker tracker;
  final VoidCallback saveData;
  const ProgressScreen(
      {Key? key, required this.tracker, required this.saveData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              tracker.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            FittedBox(
              child: Text(
                tracker.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      body: ProgressAndChart(
        data: tracker,
        saveData: saveData,
      ),
    );
  }
}
