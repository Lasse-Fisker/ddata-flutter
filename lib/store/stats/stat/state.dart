import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';
part 'state.g.dart';

@JsonSerializable()
class BloodSugarStatState extends Object
    with _$BloodSugarStatStateSerializerMixin {
  final double mean;
  final double stDev;
  final int highs;
  final int inRange;
  final int lows;
  final bool loading;

  factory BloodSugarStatState.empty() =>
      new BloodSugarStatState(0.0, 0.0, 0, 0, 0, false);

  factory BloodSugarStatState.fromJson(dynamic json) =>
      _$BloodSugarStatStateFromJson(json);

  BloodSugarStatState(
      this.mean, this.stDev, this.highs, this.inRange, this.lows, this.loading);

  // overload == and hascode to enable flutter_redux performance optimization
  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is! BloodSugarStatState) {
      return false;
    }

    final BloodSugarStatState typedOther = other;

    bool equal = typedOther.mean == this.mean &&
        typedOther.stDev == this.stDev &&
        typedOther.highs == this.highs &&
        typedOther.inRange == this.inRange &&
        typedOther.lows == this.lows &&
        typedOther.loading == this.loading;

    return equal;
  }

  @override
  int get hashCode => hashObjects([
        this.mean.hashCode,
        this.stDev.hashCode,
        this.highs.hashCode,
        this.inRange.hashCode,
        this.lows.hashCode,
        this.loading.hashCode
      ]);
}

String getStatTypeString(BloodSugarStatType statType) {
  switch (statType) {
    case BloodSugarStatType.WEEK:
      return "week";
    case BloodSugarStatType.MONTH:
      return "month";
    case BloodSugarStatType.QUARTER:
      return "quarter";
    default:
      return "day";
  }
}

enum BloodSugarStatType { DAY, WEEK, MONTH, QUARTER }

BloodSugarStatState initialState() => new BloodSugarStatState.empty();
