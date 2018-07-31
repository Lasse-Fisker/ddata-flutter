import 'package:ddata/store/period/state.dart';

class SelectPeriodAction {
  final SelectablePeriod selectedPeriod;

  SelectPeriodAction(this.selectedPeriod);
}

class CustomPeriodSelectedAction {
  final DateTime start;
  final DateTime end;

  CustomPeriodSelectedAction(this.start, this.end);
}

class SelectPeriodOpenAction {
  final bool open;

  SelectPeriodOpenAction(this.open);
}
