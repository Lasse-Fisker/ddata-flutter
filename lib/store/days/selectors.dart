import 'package:ddata/store/app/state.dart';

final getSelectedDays = (AppState state) => state.bloodSugarDays.days
    .where((day) => state.bloodSugarDays.selectedDates.any((dateString) {
          var selectedDate = DateTime.parse(dateString);
          var dayDateTime = new DateTime.fromMillisecondsSinceEpoch(day.date);

          return new DateTime(
                      selectedDate.year, selectedDate.month, selectedDate.day)
                  .compareTo(new DateTime(
                      dayDateTime.year, dayDateTime.month, dayDateTime.day)) ==
              0;
        }))
    .toList();
