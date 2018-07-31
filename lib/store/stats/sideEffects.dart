import 'package:ddata/store/app/state.dart';
import 'package:ddata/store/stats/stat/sideEffects.dart';
import 'package:ddata/store/stats/stat/state.dart';
import 'package:redux_epics/redux_epics.dart';

List<Epic<AppState>> statsSideEffects = new List<Epic<AppState>>()
  ..addAll(getStatSideEffects(BloodSugarStatType.DAY))
  ..addAll(getStatSideEffects(BloodSugarStatType.WEEK))
  ..addAll(getStatSideEffects(BloodSugarStatType.MONTH))
  ..addAll(getStatSideEffects(BloodSugarStatType.QUARTER));
