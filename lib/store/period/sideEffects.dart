import 'dart:async';
import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/days/actions.dart';
import 'package:ddata/store/period/actions.dart';
import 'package:ddata/store/period/state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'dart:developer';

List<Epic<AppState>> periodSideEffects = [
  (Stream<dynamic> actions$, EpicStore<AppState> store) => actions$
          .where((action) => action is SelectPeriodAction)
          .asyncMap((action) {
        List<DateTime> daysInPeriod = new List();
        var now = new DateTime.now();

        switch ((action as SelectPeriodAction).selectedPeriod) {
          case SelectablePeriod.DAY:
            daysInPeriod.add(new DateTime(now.year, now.month, now.day));
            break;
          case SelectablePeriod.WEEK:
            daysInPeriod = new Iterable.generate(7)
                .map((numberOfDaysToSubtract) => new DateTime(
                    now.year, now.month, now.day - numberOfDaysToSubtract))
                .toList();
            break;
          case SelectablePeriod.MONTH:
            daysInPeriod = new Iterable.generate(30)
                .map((numberOfDaysToSubtract) => new DateTime(
                    now.year, now.month, now.day - numberOfDaysToSubtract))
                .toList();
            break;
          case SelectablePeriod.QUARTER:
            daysInPeriod = new Iterable.generate(90)
                .map((numberOfDaysToSubtract) => new DateTime(
                    now.year, now.month, now.day - numberOfDaysToSubtract))
                .toList();
            break;
        }
        return new SetSelectedDaysAction(daysInPeriod);
      }),
  (Stream<dynamic> actions$, EpicStore<AppState> store) => actions$
          .where((action) => action is CustomPeriodSelectedAction)
          .asyncMap((action) {
        var difference = (action as CustomPeriodSelectedAction)
            .start
            .difference((action as CustomPeriodSelectedAction).end);
        var daysInPeriod = new List.generate(
            difference.inDays,
            (index) => new DateTime(
                (action as CustomPeriodSelectedAction).start.year,
                (action as CustomPeriodSelectedAction).start.month,
                (action as CustomPeriodSelectedAction).start.day + index));

        return new SetSelectedDaysAction(daysInPeriod);
      })
];
