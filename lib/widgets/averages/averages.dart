import 'package:flutter/material.dart';
import 'averages-chart.dart';
import 'averages-numbers.dart';

class AveragesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Theme.of(context).primaryColor,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              flex: 1,
              child: new Container(
                  alignment: Alignment.bottomCenter,
                  child: new Text(
                    "Average Blood sugar",
                    style: new TextStyle(
                        color: Colors.grey[200],
                        fontSize: 30.0,
                        fontWeight: FontWeight.w300),
                  )),
            ),
            new Flexible(
              flex: 3,
              child: new AveragesNumbersWidget(),
            ),
            new Flexible(
              flex: 3,
              child: new AveragesChartWidget(),
            ),
          ],
        ));
  }
}
