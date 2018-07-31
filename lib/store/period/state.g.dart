// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodState _$PeriodStateFromJson(Map<String, dynamic> json) {
  return new PeriodState(
      $enumDecodeNullable('SelectablePeriod', SelectablePeriod.values,
          json['selectedPeriod'] as String),
      json['selectPeriodOpen'] as bool);
}

abstract class _$PeriodStateSerializerMixin {
  SelectablePeriod get selectedPeriod;
  bool get selectPeriodOpen;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'selectedPeriod': selectedPeriod?.toString()?.split('.')?.last,
        'selectPeriodOpen': selectPeriodOpen
      };
}
