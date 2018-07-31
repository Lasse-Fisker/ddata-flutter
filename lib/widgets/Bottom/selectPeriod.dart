import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/period/actions.dart';
import 'package:ddata/store/period/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SelectPeriod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SelectPeriodState();
}

class SelectPeriodState extends State<SelectPeriod> {
  bool _showCustomState = false;

  _showSelectCustomPeriod(bool show) {
    setState(() {
      _showCustomState = show;
    });
  }

  @override
  Widget build(BuildContext context) => new Container(
        height: 50.0,
        color: Colors.grey.shade200,
        padding: new EdgeInsets.all(8.0),
        child: new StoreBuilder<AppState>(
            builder: (context, store) => new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: SelectablePeriod.values
                    .where((value) => value != SelectablePeriod.CUSTOM)
                    .map(
                      (selectablePeriod) => new Expanded(
                            flex: 1,
                            child: new GestureDetector(
                              onTap: () => store.dispatch(
                                  new SelectPeriodAction(selectablePeriod)),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  new Radio<SelectablePeriod>(
                                    value: selectablePeriod,
                                    groupValue:
                                        store.state.periodState.selectedPeriod,
                                    onChanged: (period) => store.dispatch(
                                        new SelectPeriodAction(
                                            selectablePeriod)),
                                  ),
                                  new Center(
                                    child: new Text(
                                        getPeriodName(selectablePeriod)),
                                  )
                                ],
                              ),
                            ),
                          ),
                    )
                    .toList()
                // ..add(new Expanded(
                //   flex: 1,
                //   child: new GestureDetector(
                //     child: new Column(
                //       crossAxisAlignment: CrossAxisAlignment.stretch,
                //       children: <Widget>[
                //         new Radio<SelectablePeriod>(
                //           value: SelectablePeriod.CUSTOM,
                //           groupValue:
                //               store.state.periodState.selectedPeriod,
                //           onChanged: (period) =>
                //               _showSelectCustomPeriod(true),
                //         ),
                //         new Center(
                //           child: new Text(
                //               getPeriodName(SelectablePeriod.CUSTOM)),
                //         )
                //       ],
                //     ),
                //     onTap: () => _showSelectCustomPeriod(true),
                //   ),
                // )),
                )),
      );
}
