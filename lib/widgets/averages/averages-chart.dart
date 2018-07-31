import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/days/state.dart';
import 'package:ddata/store/days/selectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class _DaysStoreVM {
  final List<BloodSugarDayState> days;
  final bool loading;

  _DaysStoreVM(this.days, this.loading);
}

class AveragesChartWidget extends StatelessWidget {
  final int lowThreshold = 4;
  final int highThreshold = 9;

  Widget _buildAveragesChart(
      BuildContext context, List<BloodSugarDayState> days) {
    return new Container(
        padding: new EdgeInsets.all(20.0),
        child: new charts.BarChart(
          _buildChartSeries(days..sort((a, b) => a.date.compareTo(b.date))),
          domainAxis: new charts.OrdinalAxisSpec(
              renderSpec: new charts.SmallTickRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 12, color: charts.MaterialPalette.white))),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.GridlineRendererSpec(
                  labelStyle: new charts.TextStyleSpec(
                      fontSize: 12, color: charts.MaterialPalette.white),
                  lineStyle: new charts.LineStyleSpec(
                      color: charts.MaterialPalette.gray.shade500))),
          animate: true,
        ));
  }

  _buildChartSeries(List<BloodSugarDayState> days) => [
        new charts.Series<BloodSugarDayState, String>(
            domainFn: (data, _) {
              var formatter = new DateFormat('d/MM');

              return formatter
                  .format(new DateTime.fromMillisecondsSinceEpoch(data.date));
            },
            measureFn: (data, _) => data.average,
            colorFn: (data, _) => data.average < lowThreshold
                ? new charts.Color(
                    r: Colors.red.red,
                    g: Colors.red.green,
                    b: Colors.red.blue,
                    a: Colors.red.alpha)
                : data.average < highThreshold
                    ? new charts.Color(
                        r: Colors.green.red,
                        g: Colors.green.green,
                        b: Colors.green.blue,
                        a: Colors.green.alpha)
                    : new charts.Color(
                        r: Colors.deepOrange.red,
                        g: Colors.deepOrange.green,
                        b: Colors.deepOrange.blue,
                        a: Colors.deepOrange.alpha),
            data: days,
            id: 'lows'),
      ];

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new StoreConnector<AppState, _DaysStoreVM>(
            converter: (store) => new _DaysStoreVM(getSelectedDays(store.state),
                store.state.bloodSugarDays.loading),
            builder: (context, vm) {
              return vm.loading || vm.days.length == 0
                  ? new CircularProgressIndicator()
                  : _buildAveragesChart(context, vm.days);
            }));
  }
}
