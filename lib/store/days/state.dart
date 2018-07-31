import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

@JsonSerializable()
class Measurement extends Object with _$MeasurementSerializerMixin {
  final int x;
  final double y;

  factory Measurement.fromJson(dynamic json) => _$MeasurementFromJson(json);

  Measurement(this.x, this.y);
}

@JsonSerializable()
class Distribution extends Object with _$DistributionSerializerMixin {
  int highs;
  int inRange;
  int lows;

  factory Distribution.fromJson(dynamic json) => _$DistributionFromJson(json);

  Distribution(this.highs, this.inRange, this.lows);
}

@JsonSerializable()
class BloodSugarDayState extends Object
    with _$BloodSugarDayStateSerializerMixin {
  final List<Measurement> measurements;
  final Distribution distribution;
  final double average;
  final int date;

  factory BloodSugarDayState.fromJson(dynamic json) =>
      _$BloodSugarDayStateFromJson(json);

  BloodSugarDayState(
      this.measurements, this.distribution, this.average, this.date);
}

@JsonSerializable()
class BloodSugarDaysState extends Object
    with _$BloodSugarDaysStateSerializerMixin {
  final List<BloodSugarDayState> days;
  final List<String> selectedDates;
  final bool loading;

  factory BloodSugarDaysState.empty() => new BloodSugarDaysState(
      new List<BloodSugarDayState>(),
      new Iterable<String>.generate(7, (i) {
        var now = new DateTime.now();
        var date = now.subtract(new Duration(days: i));
        return date.toString();
      }).toList());

  factory BloodSugarDaysState.fromJson(dynamic json) =>
      _$BloodSugarDaysStateFromJson(json);

  BloodSugarDaysState(this.days, this.selectedDates, {this.loading = false});
}

BloodSugarDaysState initialState() => new BloodSugarDaysState.empty();
