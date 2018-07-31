import 'package:ddata/store/stats/stat/state.dart';

class FetchBloodSugarStatsAction {
  final BloodSugarStatType type;

  FetchBloodSugarStatsAction([this.type]);
}

class FetchBloodSugarStatsSuccessAction {
  final BloodSugarStatState payload;
  final BloodSugarStatType statType;

  FetchBloodSugarStatsSuccessAction(this.payload, this.statType);
}

class FetchBloodSugarStatsFailureAction {
  final BloodSugarStatType statType;

  FetchBloodSugarStatsFailureAction(this.statType);
}
