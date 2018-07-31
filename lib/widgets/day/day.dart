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

class _DummyData {
  DateTime date;
  int val;

  _DummyData(this.date, this.val);
}

class _DistributionSeriesData {
  String type;
  int val;

  _DistributionSeriesData(this.type, this.val);
}

class DaysWidget extends StatelessWidget {
  Widget _buildDay(BloodSugarDayState day) => new Container(
      padding: new EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 2.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildDayDate(day),
          new Container(
            height: 190.0,
            child: _buildDayMeasurementsChart(day),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                height: 150.0,
                width: 150.0,
                child: _buildDayDistributionChart(day),
              ),
              new Container(
                height: 150.0,
                width: 150.0,
                margin: new EdgeInsets.only(top: 10.0),
                child: _buildDayStats(day),
              )
            ],
          )
        ],
      ));

  Widget _buildDayDate(BloodSugarDayState day) {
    var dayDateTime = new DateTime.fromMillisecondsSinceEpoch(day.date);
    var formatter = new DateFormat.yMMMd();
    return new Text(
      formatter.format(dayDateTime),
      style: new TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildDayDistributionChart(BloodSugarDayState day) =>
      new charts.PieChart(
        [
          new charts.Series<_DistributionSeriesData, String>(
              id: 'distribution',
              domainFn: (data, _) => data.type,
              measureFn: (data, _) => data.val,
              colorFn: (data, index) => index == 0
                  ? new charts.Color(
                      r: Colors.red.red,
                      g: Colors.red.green,
                      b: Colors.red.blue,
                      a: Colors.red.alpha)
                  : index == 1
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
              data: [
                new _DistributionSeriesData('lows', day.distribution.lows),
                new _DistributionSeriesData(
                    'in range', day.distribution.inRange),
                new _DistributionSeriesData('highs', day.distribution.highs)
              ])
        ],
        animate: false,
      );

  Widget _buildDayStats(BloodSugarDayState day) {
    var typeTextStyle = new TextStyle(
        color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500);
    var valTextStyle = new TextStyle(
        color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w300);

    double _getDistributionPercentage(val) =>
        (val /
            (day.distribution.lows +
                day.distribution.inRange +
                day.distribution.highs)) *
        100;

    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Average',
              style: typeTextStyle,
            ),
            new Text(
              'Lows',
              style: typeTextStyle,
            ),
            new Text(
              'In range',
              style: typeTextStyle,
            ),
            new Text(
              'Hight',
              style: typeTextStyle,
            )
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(
              day.average.toStringAsFixed(2),
              style: valTextStyle,
            ),
            new Text(
              _getDistributionPercentage(day.distribution.lows)
                      .toStringAsFixed(0) +
                  '%',
              style: valTextStyle,
            ),
            new Text(
              _getDistributionPercentage(day.distribution.inRange)
                      .toStringAsFixed(0) +
                  '%',
              style: valTextStyle,
            ),
            new Text(
              _getDistributionPercentage(day.distribution.highs)
                      .toStringAsFixed(0) +
                  '%',
              style: valTextStyle,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDayMeasurementsChart(BloodSugarDayState day) {
    var dayDateTime = new DateTime.fromMillisecondsSinceEpoch(day.date);

    return new charts.TimeSeriesChart(
      [
        new charts.Series<Measurement, DateTime>(
            domainFn: (data, _) =>
                new DateTime.fromMillisecondsSinceEpoch(data.x),
            measureFn: (data, _) => data.y,
            colorFn: (Measurement data, _) => new charts.Color(
                r: Colors.green.red,
                g: Colors.green.green,
                b: Colors.green.blue,
                a: Colors.green.alpha),
            id: 'measurements',
            data: day.measurements),
        new charts.Series<_DummyData, DateTime>(
            domainFn: (data, _) => data.date,
            measureFn: (data, _) => data.val,
            colorFn: (_data, _) => new charts.Color(
                r: Colors.transparent.red,
                g: Colors.transparent.green,
                b: Colors.transparent.blue,
                a: Colors.transparent.alpha),
            id: 'dummy',
            data: [
              new _DummyData(
                  new DateTime(dayDateTime.year, dayDateTime.month,
                      dayDateTime.day, 2, 0),
                  0),
              new _DummyData(
                  new DateTime(dayDateTime.year, dayDateTime.month,
                      dayDateTime.day, 23, 59),
                  26)
            ])
      ],
      animate: false,
      dateTimeFactory: new charts.LocalDateTimeFactory(),
      defaultRenderer: new charts.LineRendererConfig(strokeWidthPx: 6.0),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 12, color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.gray.shade500)),
          tickProviderSpec: new charts.StaticNumericTickProviderSpec([
            new charts.TickSpec(4),
            new charts.TickSpec(9),
            new charts.TickSpec(15),
            new charts.TickSpec(26)
          ])),
      domainAxis: new charts.DateTimeAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
            labelStyle: new charts.TextStyleSpec(
                fontSize: 13, color: charts.MaterialPalette.white),
          ),
          tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
              hour: new charts.TimeFormatterSpec(
                  format: 'HH', transitionFormat: 'HH'))),
    );
  }

  @override
  Widget build(BuildContext context) =>
      new StoreConnector<AppState, _DaysStoreVM>(
          distinct: true,
          converter: (store) => new _DaysStoreVM(
              getSelectedDays(store.state), store.state.bloodSugarDays.loading),
          builder: (context, vm) => new Container(
              color: Theme.of(context).primaryColor,
              child: vm.loading || vm.days.length == 0
                  ? new Center(child: new CircularProgressIndicator())
                  : new CustomScrollView(
                      slivers: <Widget>[
                        const SliverAppBar(
                          pinned: true,
                          expandedHeight: 100.0,
                          flexibleSpace: const FlexibleSpaceBar(
                            centerTitle: true,
                            title: const Text(
                              "Blood sugar by day",
                            ),
                          ),
                        ),
                        new SliverFixedExtentList(
                          itemExtent: 410.0,
                          delegate: new SliverChildBuilderDelegate(
                              (BuildContext context, int index) =>
                                  _buildDay(vm.days[index]),
                              childCount: vm.days.length),
                        )
                      ],
                    )));
}
