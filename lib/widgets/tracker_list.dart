import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/progress_screen.dart';
import '../models/trackers.dart';
import 'add_tracker_form.dart';

class TrackerList extends StatefulWidget {
  const TrackerList({Key? key}) : super(key: key);

  @override
  State<TrackerList> createState() => _TrackerListState();
}

class _TrackerListState extends State<TrackerList> {
  List<Tracker> data = [];
  void _saveData() {
    SharedPreferences.getInstance().then((pref) {
      pref.setString("tracker-data", Tracker.encode(data));
    });
  }

  void _addTracker(String title, String description) {
    setState(() {
      data.add(Tracker(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        data: [],
        target: 0,
      ));
    });
    _saveData();
  }

  void _switchScreen(int index) {
    Navigator.push(context, _createRoute(index));
  }

  Route _createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ProgressScreen(
        tracker: data[index],
        saveData: _saveData,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _deleteTracker(String id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Card(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: const Text("Delete?"),
              onPressed: () {
                setState(() {
                  data.removeWhere((element) => element.id == id);
                });
                _saveData();
                Navigator.pop(context);
              },
            ),
          );
        });
  }

  void _showAddTracker() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddTrackerForm(
          addTracker: _addTracker,
        );
      },
    );
  }

  Future<void> _loadData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final temp = pref.getString("tracker-data");
    if (temp == null) {
      return;
    } else {
      data = Tracker.decode(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Total Trackers",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      IconButton(
                          onPressed: _showAddTracker,
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  const Divider(
                    color: Color(0xFF605F5E),
                  ),
                  data.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: const [
                            Text("No Trackers added yet..."),
                            Icon(
                              Icons.question_mark,
                              size: 60,
                            ),
                          ]),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onLongPress: () {
                                  _deleteTracker(data[index].id);
                                },
                                child: ListTile(
                                  title: Text(data[index].title),
                                  subtitle: Text(data[index].description),
                                  trailing: IconButton(
                                    onPressed: () {
                                      _switchScreen(index);
                                    },
                                    icon: const Icon(Icons.arrow_right_alt),
                                  ),
                                ),
                              );
                            }),
                            itemCount: data.length,
                          ),
                        )
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
