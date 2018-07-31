import 'package:ddata/store/app/state.dart';
import 'package:ddata/widgets/Bottom/bottomNavBar.dart';
import 'package:ddata/widgets/Bottom/selectPeriod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new StoreConnector<AppState, bool>(
        distinct: true,
        converter: (store) => store.state.periodState.selectPeriodOpen,
        builder: (context, isOpen) => new AnimatedPositioned(
            bottom: isOpen ? 0.0 : -135.0,
            height: 200.0,
            left: 0.0,
            right: 0.0,
            duration: new Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: new Column(
              children: <Widget>[
                new BottomNavBar(),
                new Expanded(
                  flex: 1,
                  child: new SelectPeriod(),
                )
              ],
            )),
      );
}
