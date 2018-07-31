// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSugarStatsState _$BloodSugarStatsStateFromJson(Map<String, dynamic> json) {
  return new BloodSugarStatsState(
      json['day'] == null
          ? null
          : new BloodSugarStatState.fromJson(json['day']),
      json['week'] == null
          ? null
          : new BloodSugarStatState.fromJson(json['week']),
      json['month'] == null
          ? null
          : new BloodSugarStatState.fromJson(json['month']),
      json['quarter'] == null
          ? null
          : new BloodSugarStatState.fromJson(json['quarter']));
}

abstract class _$BloodSugarStatsStateSerializerMixin {
  BloodSugarStatState get day;
  BloodSugarStatState get week;
  BloodSugarStatState get month;
  BloodSugarStatState get quarter;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'day': day,
        'week': week,
        'month': month,
        'quarter': quarter
      };
}
