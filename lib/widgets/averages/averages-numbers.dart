import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/stats/stat/state.dart';
import 'package:ddata/store/stats/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AveragesNumbersWidget extends StatelessWidget {
  Column _buildPeriodColumn() {
    var textStyle = new TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(bottom: 7.0),
          child: new Text(
            "Period",
            style: textStyle,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 7.0),
          child: new Text(
            getStatTypeString(BloodSugarStatType.DAY),
            style: textStyle,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 7.0),
          child: new Text(
            getStatTypeString(BloodSugarStatType.WEEK),
            style: textStyle,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 7.0),
          child: new Text(
            getStatTypeString(BloodSugarStatType.MONTH),
            style: textStyle,
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(top: 7.0),
          child: new Text(
            getStatTypeString(BloodSugarStatType.QUARTER),
            style: textStyle,
          ),
        )
      ],
    );
  }

  Column _buildValueColumn(List<String> values, String header) {
    var valueStyle = new TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200);
    var headerStyle = new TextStyle(
        color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold);

    return new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          new Container(
            margin: new EdgeInsets.only(bottom: 7.0),
            child: new Text(
              header,
              style: headerStyle,
            ),
          ),
        ]..addAll(values
            .map((value) => new Container(
                  margin: new EdgeInsets.only(top: 7.0),
                  child: new Text(
                    value,
                    style: valueStyle,
                  ),
                ))
            .toList()),
        mainAxisSize: MainAxisSize.min);
  }

  _buildAverages(BloodSugarStatsState stats) => new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildPeriodColumn(),
          _buildValueColumn(<String>[
            stats.day.mean.toStringAsFixed(2) + " mmol",
            stats.week.mean.toStringAsFixed(2) + " mmol",
            stats.month.mean.toStringAsFixed(2) + " mmol",
            stats.quarter.mean.toStringAsFixed(2) + " mmol"
          ], "Blood sugar"),
          _buildValueColumn(<String>[
            stats.day.stDev.toStringAsFixed(2),
            stats.week.stDev.toStringAsFixed(2),
            stats.month.stDev.toStringAsFixed(2),
            stats.quarter.stDev.toStringAsFixed(2)
          ], "St. dev")
        ],
      );

  @override
  Widget build(BuildContext context) => new Center(
        child: new StoreConnector<AppState, BloodSugarStatsState>(
            distinct: true,
            converter: (store) => store.state.bloodSugarStats,
            builder: (context, stats) => _buildAverages(stats)),
      );
}
