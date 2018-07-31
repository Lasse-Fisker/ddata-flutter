import 'package:ddata/store/days/state.dart';

class FetchDaysAction {
  final List<DateTime> daysToGet;

  FetchDaysAction(this.daysToGet);
}

class FetchDaysSuccessAction {
  final List<BloodSugarDayState> days;

  FetchDaysSuccessAction(this.days);
}

class SetSelectedDaysAction {
  final List<DateTime> selectedDays;

  SetSelectedDaysAction(this.selectedDays);
}

class FetchDaysErrorAction {}
