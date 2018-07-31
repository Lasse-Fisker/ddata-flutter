// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodSugarStatState _$BloodSugarStatStateFromJson(Map<String, dynamic> json) {
  return new BloodSugarStatState(
      (json['mean'] as num)?.toDouble(),
      (json['stDev'] as num)?.toDouble(),
      json['highs'] as int,
      json['inRange'] as int,
      json['lows'] as int,
      json['loading'] as bool);
}

abstract class _$BloodSugarStatStateSerializerMixin {
  double get mean;
  double get stDev;
  int get highs;
  int get inRange;
  int get lows;
  bool get loading;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'mean': mean,
        'stDev': stDev,
        'highs': highs,
        'inRange': inRange,
        'lows': lows,
        'loading': loading
      };
}
