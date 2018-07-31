import 'package:ddata/store/stats/stat/actions.dart';
import 'package:ddata/store/stats/stat/state.dart';
import 'package:redux/redux.dart';

Reducer<BloodSugarStatState> getStatReducer(BloodSugarStatType statType) =>
    combineReducers([
      TypedReducer<BloodSugarStatState, FetchBloodSugarStatsSuccessAction>(
          (BloodSugarStatState lastState,
                  FetchBloodSugarStatsSuccessAction action) =>
              action.statType == statType ? action.payload : lastState)
    ]);
