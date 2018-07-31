import 'package:ddata/store/period/actions.dart';
import 'package:ddata/store/period/state.dart';
import 'package:redux/redux.dart';

Reducer<PeriodState> periodReducer = combineReducers([
  TypedReducer<PeriodState, SelectPeriodAction>(_selectPeriodReducer),
  TypedReducer<PeriodState, SelectPeriodOpenAction>(_selectPeriodOpenReducer)
]);

PeriodState _selectPeriodReducer(
        PeriodState lastState, SelectPeriodAction action) =>
    new PeriodState(action.selectedPeriod, lastState.selectPeriodOpen);

PeriodState _selectPeriodOpenReducer(
        PeriodState lastState, SelectPeriodOpenAction action) =>
    new PeriodState(lastState.selectedPeriod, action.open);
