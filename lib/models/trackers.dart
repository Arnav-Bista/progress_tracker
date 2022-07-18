import 'dart:convert';

class Tracker {
  String id;
  String title;
  String description;
  List<Progress> data;
  double target;
  Tracker(
      {required this.id,
      required this.title,
      required this.description,
      required this.data,
      required this.target});

  get average {
    double avg = 0;
    for (Progress element in data) {
      avg += element.data;
    }
    return avg / data.length;
  }

  factory Tracker.fromJson(Map<String, dynamic> jsonData) {
    return Tracker(
      id: jsonData["id"],
      title: jsonData["title"],
      description: jsonData["description"],
      data: Progress.decode(jsonData["data"]),
      target: jsonData["target"],
    );
  }

  static Map<String, dynamic> toMap(Tracker tracker) => {
        "id": tracker.id,
        "title": tracker.title,
        "description": tracker.description,
        "data": Progress.encode(tracker.data),
        "target": tracker.target
      };

  static String encode(List<Tracker> trackers) => json.encode(trackers
      .map<Map<String, dynamic>>((tracker) => Tracker.toMap(tracker))
      .toList());

  static List<Tracker> decode(String trackers) =>
      (json.decode(trackers) as List<dynamic>)
          .map((e) => Tracker.fromJson(e))
          .toList();
}

class Progress {
  DateTime date;
  double data;
  Progress({required this.date, required this.data});

  factory Progress.fromJson(Map<String, dynamic> jsonData) {
    return Progress(
      date: DateTime.parse(jsonData["date"]),
      data: jsonData["data"],
    );
  }

  static Map<String, dynamic> toMap(Progress progress) => {
        "date": progress.date.toString(),
        "data": progress.data,
      };

  static String encode(List<Progress> prog) => json.encode(
      prog.map<Map<String, dynamic>>((prog) => Progress.toMap(prog)).toList());

  static List<Progress> decode(String progress) =>
      (json.decode(progress) as List<dynamic>)
          .map((e) => Progress.fromJson(e))
          .toList();
}
