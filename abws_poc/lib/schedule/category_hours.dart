import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';

/// Hours scheduled per category id.
Map<String, double> hoursPerCategory(List<ScheduleEvent> events) {
  final totals = <String, double>{};
  for (final event in events) {
    totals[event.categoryId] =
        (totals[event.categoryId] ?? 0) + event.durationMinutes / 60;
  }
  return totals;
}

/// Categories that have at least [minHours] scheduled, in display order.
List<({ScheduleCategory category, double hours})> categoryHourSegments(
  List<ScheduleEvent> events, {
  double minHours = 0.001,
}) {
  final totals = hoursPerCategory(events);
  return scheduleCategories
      .map((category) => (category: category, hours: totals[category.id] ?? 0))
      .where((row) => row.hours >= minHours)
      .toList();
}
