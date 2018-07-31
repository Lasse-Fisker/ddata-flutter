// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return new AppState(
      json['bloodSugarStats'] == null
          ? null
          : new BloodSugarStatsState.fromJson(json['bloodSugarStats']),
      json['bloodSugarDays'] == null
          ? null
          : new BloodSugarDaysState.fromJson(json['bloodSugarDays']),
      json['navigation'] == null
          ? null
          : new NavigationState.fromJson(
              json['navigation'] as Map<String, dynamic>),
      json['periodState'] == null
          ? null
          : new PeriodState.fromJson(
              json['periodState'] as Map<String, dynamic>));
}

abstract class _$AppStateSerializerMixin {
  BloodSugarStatsState get bloodSugarStats;
  BloodSugarDaysState get bloodSugarDays;
  NavigationState get navigation;
  PeriodState get periodState;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'bloodSugarStats': bloodSugarStats,
        'bloodSugarDays': bloodSugarDays,
        'navigation': navigation,
        'periodState': periodState
      };
}
