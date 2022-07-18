import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../models/trackers.dart';

class Chart extends StatelessWidget {
  final List<Progress> data;
  final double target;
  const Chart({Key? key, required this.data, required this.target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double avg = 0;
    for (int i = 0; i < data.length; i++) {
      avg += data[i].data;
    }

    var chartData = [
      charts.Series(
          id: "Progress",
          domainFn: (Progress data, _) => data.date,
          measureFn: (Progress data, _) => data.data,
          data: data),
    ];
    //? AVERAGE H-LINE
    if (avg > 0 && data.length >= 2) {
      avg /= data.length;
      chartData.add(
        charts.Series(
          id: "Average",
          domainFn: (Progress data, _) => data.date,
          measureFn: (_, __) => avg,
          data: [
            Progress(date: data[0].date, data: avg),
            Progress(date: data[data.length - 1].date, data: avg)
          ],
        ),
      );
    }
    //? TARGET H-LINE
    if (target != 0) {
      chartData.add(
        charts.Series(
          id: "Target",
          domainFn: (Progress data, _) => data.date,
          measureFn: (_, __) => target,
          data: [
            Progress(date: data[0].date, data: target),
            Progress(date: data[data.length - 1].date, data: target)
          ],
        ),
      );
    }

    double max = 0;
    double min = 0;
    if (data.isNotEmpty) {
      max = data[0].data;
      min = data[0].data;
      for (int i = 0; i < data.length; i++) {
        if (max < data[i].data) {
          max = data[i].data;
        }
        if (min > data[i].data) {
          min = data[i].data;
        }
      }
    }

    return Card(
      elevation: 5,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: charts.TimeSeriesChart(
            chartData,
            dateTimeFactory: const charts.LocalDateTimeFactory(),
            primaryMeasureAxis: const charts.NumericAxisSpec(
              tickProviderSpec:
                  charts.BasicNumericTickProviderSpec(zeroBound: false),
            ),
            behaviors: [charts.SeriesLegend()],
          ),
        ),
      ),
    );
  }
}
