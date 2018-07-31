import 'package:ddata/isDebug.dart';
import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/app/store.dart';
import 'package:ddata/store/days/actions.dart';
import 'package:ddata/store/stats/stat/actions.dart';
import 'package:ddata/store/stats/stat/state.dart';
import 'package:ddata/widgets/Bottom/bottom.dart';
import 'package:ddata/widgets/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() {
  loadState();
  runApp(new MaterialApp(home: new DDataApp()));
}

class TabItem {
  String title;
  IconData icon;
  int id;
  TabItem(this.title, this.icon, this.id);
}

class DDataApp extends StatefulWidget {
  // _initDays() {
  //   final date = new DateTime.now();

  //   var days = new Iterable<DateTime>.generate(7, (i) {
  //     return date.subtract(new Duration(days: i));
  //   }).toList();
  //   store.dispatch(new SetSelectedDaysAction(days));
  // }

  // _initReduxState() {
  //   _initDays();
  //   _initStats();
  // }

  @override
  State<StatefulWidget> createState() => new DDataAppState();
}

class DDataAppState extends State<DDataApp>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  ThemeData _theme = new ThemeData(
      accentColor: Colors.deepOrangeAccent, primaryColor: Colors.blueGrey);

  DDataAppState() {
    WidgetsBinding.instance.addObserver(this);
  }

  _refreshCurrentDay() {
    store.dispatch(new FetchDaysAction([new DateTime.now()]));
    store.dispatch(new FetchBloodSugarStatsAction(BloodSugarStatType.DAY));
  }

  _persistState() {
    saveState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _refreshCurrentDay();
        break;
      case AppLifecycleState.paused:
        _persistState();
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) => new PersistorGate(
      persistor: persistor,
      builder: (context) {
        // get updated stats now that state is loaded
        store.dispatch(new FetchBloodSugarStatsAction());
        // fetch missing days from the currently selected dates
        store.dispatch(new SetSelectedDaysAction(store
            .state.bloodSugarDays.selectedDates
            .map((d) => DateTime.parse(d))
            .toList()));

        return new MaterialApp(
            theme: _theme,
            home: new StoreProvider<AppState>(
                store: store,
                child: new Scaffold(
                    body: new Stack(
                  children: <Widget>[
                    new Content(),
                    new Bottom(),
                  ],
                ))));
      });
}
