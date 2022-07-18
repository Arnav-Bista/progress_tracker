import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/tracker_list.dart';
import '../models/trackers.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);
  // TODO: ADD LOADING AND SAVING DATA IMPLEMENTATION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 29, 52, 97),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "PROGRESS TRACKER",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              "TRACKERS",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
      body: TrackerList(),
    );
  }
}
