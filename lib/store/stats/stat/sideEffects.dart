import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/stats/stat/actions.dart';
import 'package:ddata/store/stats/stat/state.dart';
import 'package:redux_epics/redux_epics.dart';

List<Epic<AppState>> getStatSideEffects(BloodSugarStatType statType) => [
      (Stream<dynamic> actions$, EpicStore<AppState> store) => actions$
              .where((action) =>
                  action is FetchBloodSugarStatsAction &&
                  (action.type == null || action.type == statType))
              .asyncMap((action) {
            var url =
                "https://ddata-server.herokuapp.com/api/bloodsugar/stats/${getStatTypeString(statType)}";
            return http.get(url).then((res) {
              return json.decode(res.body);
            }).then((json) {
              return new FetchBloodSugarStatsSuccessAction(
                  new BloodSugarStatState.fromJson(json), statType);
            }).catchError((error) {
              return new FetchBloodSugarStatsFailureAction(statType);
            });
          })
    ];
