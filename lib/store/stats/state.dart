import 'package:ddata/store/stats/stat/state.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';
part 'state.g.dart';

@JsonSerializable()
class BloodSugarStatsState extends Object
    with _$BloodSugarStatsStateSerializerMixin {
  final BloodSugarStatState day;
  final BloodSugarStatState week;
  final BloodSugarStatState month;
  final BloodSugarStatState quarter;

  BloodSugarStatsState(this.day, this.week, this.month, this.quarter);

  factory BloodSugarStatsState.empty() => new BloodSugarStatsState(
      new BloodSugarStatState.empty(),
      new BloodSugarStatState.empty(),
      new BloodSugarStatState.empty(),
      new BloodSugarStatState.empty());

  factory BloodSugarStatsState.fromJson(dynamic json) =>
      _$BloodSugarStatsStateFromJson(json);

  // overload == and hascode to enable flutter_redux performance optimization
  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! BloodSugarStatsState) {
      return false;
    }

    final BloodSugarStatsState typedOther = other;

    bool equal = typedOther.day == this.day &&
        typedOther.week == this.week &&
        typedOther.month == this.month &&
        typedOther.quarter == this.quarter;

    return equal;
  }

  @override
  int get hashCode => hash4(this.day.hashCode, this.week.hashCode,
      this.month.hashCode, this.quarter.hashCode);
}
