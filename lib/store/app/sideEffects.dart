import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/days/sideEffects.dart';
import 'package:ddata/store/period/sideEffects.dart';
import 'package:ddata/store/stats/sideEffects.dart';
import 'package:redux_epics/redux_epics.dart';

final _epic = combineEpics<AppState>(new List()
  ..addAll(daysSideEffects)
  ..addAll(statsSideEffects)
  ..addAll(periodSideEffects));

final appSideEffectsMiddleware = new EpicMiddleware(_epic);
