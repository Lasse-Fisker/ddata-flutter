// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measurement _$MeasurementFromJson(Map<String, dynamic> json) {
  return new Measurement(json['x'] as int, (json['y'] as num)?.toDouble());
}

abstract class _$MeasurementSerializerMixin {
  int get x;
  double get y;
  Map<String, dynamic> toJson() => <String, dynamic>{'x': x, 'y': y};
}

Distribution _$DistributionFromJson(Map<String, dynamic> json) {
  return new Distribution(
      json['highs'] as int, json['inRange'] as int, json['lows'] as int);
}

abstract class _$DistributionSerializerMixin {
  int get highs;
  int get inRange;
  int get lows;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'highs': highs, 'inRange': inRange, 'lows': lows};
}

BloodSugarDayState _$BloodSugarDayStateFromJson(Map<String, dynamic> json) {
  return new BloodSugarDayState(
      (json['measurements'] as List)
          ?.map((e) => e == null ? null : new Measurement.fromJson(e))
          ?.toList(),
      json['distribution'] == null
          ? null
          : new Distribution.fromJson(json['distribution']),
      (json['average'] as num)?.toDouble(),
      json['date'] as int);
}

abstract class _$BloodSugarDayStateSerializerMixin {
  List<Measurement> get measurements;
  Distribution get distribution;
  double get average;
  int get date;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'measurements': measurements,
        'distribution': distribution,
        'average': average,
        'date': date
      };
}

BloodSugarDaysState _$BloodSugarDaysStateFromJson(Map<String, dynamic> json) {
  return new BloodSugarDaysState(
      (json['days'] as List)
          ?.map((e) => e == null ? null : new BloodSugarDayState.fromJson(e))
          ?.toList(),
      (json['selectedDates'] as List)?.map((e) => e as String)?.toList(),
      loading: json['loading'] as bool);
}

abstract class _$BloodSugarDaysStateSerializerMixin {
  List<BloodSugarDayState> get days;
  List<String> get selectedDates;
  bool get loading;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'days': days,
        'selectedDates': selectedDates,
        'loading': loading
      };
}
