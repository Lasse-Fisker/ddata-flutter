import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/days/reducer.dart';
import 'package:ddata/store/stats/reducer.dart';
import 'package:ddata/store/navigation/reducer.dart';
import 'package:ddata/store/period/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';

Reducer<AppState> appReducer = (AppState lastState, action) =>
    (action is PersistLoadedAction<AppState>) && action.state != null
        ? action.state
        : new AppState(
            statsReducer(lastState.bloodSugarStats, action),
            daysReducer(lastState.bloodSugarDays, action),
            navigationReducer(lastState.navigation, action),
            periodReducer(lastState.periodState, action));
