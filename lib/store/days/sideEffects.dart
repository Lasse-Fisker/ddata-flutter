import 'dart:async';
import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/days/state.dart';
import 'package:http/http.dart' as http;
import 'package:ddata/store/days/actions.dart';
import 'package:redux_epics/redux_epics.dart';
import 'dart:convert';

List<Epic<AppState>> daysSideEffects = [
  (Stream<dynamic> actions$, EpicStore<AppState> store) =>
      actions$.where((action) => action is FetchDaysAction).asyncMap((action) {
        var calls = (action as FetchDaysAction).daysToGet.map((date) => http
            .get(
                "https://ddata-server.herokuapp.com/api/bloodsugar/day/${date.millisecondsSinceEpoch}/true")
            .then((res) => json.decode(res.body))
            .then((json) => new BloodSugarDayState.fromJson(json))
            .then((BloodSugarDayState day) =>
                // map mgdl to mmol
                new BloodSugarDayState(
                    day.measurements
                        .map((Measurement m) =>
                            new Measurement(m.x, m.y * 0.0555))
                        .toList(),
                    day.distribution,
                    day.average * 0.0555,
                    day.date))
            .catchError((error) => print(error)));

        return Future.wait(calls).then((List<BloodSugarDayState> days) =>
            new FetchDaysSuccessAction(days));
      }),
  (Stream<dynamic> actions$, EpicStore<AppState> store) => actions$
          .where((action) => action is SetSelectedDaysAction)
          .asyncMap((action) {
        var alreadyLoadedDays = store.state.bloodSugarDays.days != null
            ? store.state.bloodSugarDays.days
                .map((day) => new DateTime.fromMillisecondsSinceEpoch(day.date))
                .toList()
            : new List<DateTime>();
        var daysToGet = (action as SetSelectedDaysAction)
            .selectedDays
            .where((dayToLoad) => !alreadyLoadedDays.any((loadedDay) =>
                new DateTime(loadedDay.year, loadedDay.month, loadedDay.day)
                    .compareTo(new DateTime(
                        dayToLoad.year, dayToLoad.month, dayToLoad.day)) ==
                0))
            .toList();

        return new FetchDaysAction(daysToGet);
      })
];
