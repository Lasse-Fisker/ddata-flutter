import 'package:ddata/store/days/state.dart';
import 'package:ddata/store/navigation/state.dart';
import 'package:ddata/store/period/state.dart';
import 'package:ddata/store/stats/state.dart';
import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

@JsonSerializable()
class AppState extends Object with _$AppStateSerializerMixin {
  final BloodSugarStatsState bloodSugarStats;
  final BloodSugarDaysState bloodSugarDays;
  final NavigationState navigation;
  final PeriodState periodState;

  AppState(this.bloodSugarStats, this.bloodSugarDays, this.navigation,
      this.periodState);

  factory AppState.empty() => new AppState(
      new BloodSugarStatsState.empty(),
      new BloodSugarDaysState.empty(),
      new NavigationState.empty(),
      new PeriodState.empty());

  static AppState fromJson(dynamic json) => _$AppStateFromJson(json);

  static AppState fromJsonDecoder(dynamic json) => AppState.fromJson(json);
}
