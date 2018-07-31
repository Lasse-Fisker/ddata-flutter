import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

enum SelectablePeriod { DAY, WEEK, MONTH, QUARTER, CUSTOM }

getPeriodName(SelectablePeriod period) {
  switch (period) {
    case SelectablePeriod.DAY:
      return 'Day';
    case SelectablePeriod.WEEK:
      return 'Week';
    case SelectablePeriod.MONTH:
      return 'Month';
    case SelectablePeriod.QUARTER:
      return 'Quarter';
    case SelectablePeriod.CUSTOM:
      return 'Custom';
    default:
      return '';
  }
}

@JsonSerializable()
class PeriodState extends Object with _$PeriodStateSerializerMixin {
  final SelectablePeriod selectedPeriod;
  final bool selectPeriodOpen;

  PeriodState(this.selectedPeriod, this.selectPeriodOpen);

  factory PeriodState.empty() => new PeriodState(SelectablePeriod.WEEK, false);

  factory PeriodState.fromJson(Map<String, dynamic> json) =>
      _$PeriodStateFromJson(json);
}
