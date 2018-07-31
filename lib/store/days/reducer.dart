import 'package:ddata/store/days/actions.dart';
import 'package:ddata/store/days/state.dart';
import 'package:redux/redux.dart';

Reducer<BloodSugarDaysState> daysReducer = combineReducers([
  TypedReducer<BloodSugarDaysState, FetchDaysSuccessAction>(
      _fetchDaysSuccessReducer),
  TypedReducer<BloodSugarDaysState, SetSelectedDaysAction>(
      _setSelectedDaysReducer),
  TypedReducer<BloodSugarDaysState, FetchDaysAction>(_fetchDaysReducer)
]);

BloodSugarDaysState _fetchDaysSuccessReducer(
    BloodSugarDaysState lastState, FetchDaysSuccessAction action) {
  return new BloodSugarDaysState(
      new List.from(action.days)
        ..addAll(lastState.days != null
            ? lastState.days.where((day) {
                var dayDate = new DateTime.fromMillisecondsSinceEpoch(day.date);
                return !action.days.any((loadedDay) {
                  var loadedDayDate =
                      new DateTime.fromMillisecondsSinceEpoch(loadedDay.date);
                  return new DateTime(dayDate.year, dayDate.month, dayDate.day)
                          .compareTo(new DateTime(loadedDayDate.year,
                              loadedDayDate.month, loadedDayDate.day)) ==
                      0;
                });
              })
            : []),
      new List.from(lastState.selectedDates),
      loading: false);
}

BloodSugarDaysState _setSelectedDaysReducer(
    BloodSugarDaysState lastState, SetSelectedDaysAction action) {
  return new BloodSugarDaysState(
      lastState.days != null ? new List.from(lastState.days) : null,
      action.selectedDays.map((day) => day.toString()).toList());
}

BloodSugarDaysState _fetchDaysReducer(
        BloodSugarDaysState lastState, FetchDaysAction action) =>
    new BloodSugarDaysState(lastState.days, lastState.selectedDates,
        loading: true);
