import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';

/// Default weekly target when a category has no [ScheduleCategory.recommendedHours].
const int defaultRecommendedHoursPerCategory = 2;

/// Hours scheduled per category id.
Map<String, double> hoursPerCategory(List<ScheduleEvent> events) {
  final totals = <String, double>{};
  for (final event in events) {
    totals[event.categoryId] =
        (totals[event.categoryId] ?? 0) + event.durationMinutes / 60;
  }
  return totals;
}

int recommendedHoursFor(ScheduleCategory category) {
  return category.recommendedHours ?? defaultRecommendedHoursPerCategory;
}

/// Sum of weekly recommended hours across all life areas (bar = 100% of this).
int get totalRecommendedHours {
  return scheduleCategories.fold(
    0,
    (sum, category) => sum + recommendedHoursFor(category),
  );
}

/// One slot in the header progress bar.
class CategoryProgressSlot {
  const CategoryProgressSlot({
    required this.category,
    required this.recommendedHours,
    required this.scheduledHours,
  });

  final ScheduleCategory category;
  final int recommendedHours;
  final double scheduledHours;

  /// How much of this category's slot is filled (0–1).
  double get fillFraction =>
      (scheduledHours / recommendedHours).clamp(0.0, 1.0);
}

/// Fixed-width bar slots (by recommended hours) with current fill per category.
List<CategoryProgressSlot> categoryProgressSlots(List<ScheduleEvent> events) {
  final scheduled = hoursPerCategory(events);
  return scheduleCategories
      .map(
        (category) => CategoryProgressSlot(
          category: category,
          recommendedHours: recommendedHoursFor(category),
          scheduledHours: scheduled[category.id] ?? 0,
        ),
      )
      .toList();
}

/// Categories with any time booked (for legend chips).
List<CategoryProgressSlot> categoryHourSegments(List<ScheduleEvent> events) {
  return categoryProgressSlots(events)
      .where((slot) => slot.scheduledHours > 0.001)
      .toList();
}
