import 'package:ddata/store/stats/stat/state.dart';
import 'package:ddata/store/stats/state.dart';
import 'package:ddata/store/stats/stat/reducer.dart';

import 'package:redux/redux.dart';

Reducer<BloodSugarStatsState> statsReducer =
    (BloodSugarStatsState lastState, action) => new BloodSugarStatsState(
        getStatReducer(BloodSugarStatType.DAY)(lastState.day, action),
        getStatReducer(BloodSugarStatType.WEEK)(lastState.week, action),
        getStatReducer(BloodSugarStatType.MONTH)(lastState.month, action),
        getStatReducer(BloodSugarStatType.QUARTER)(lastState.quarter, action));
