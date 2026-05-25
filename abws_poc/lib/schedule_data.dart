import 'package:flutter/material.dart';

// --- Layout ---
const double tabletBreakpoint = 600;
const double tabletSidebarWidth = 300;

bool isTabletLayout(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= tabletBreakpoint;

// --- Grid times (4:00 AM – 10:00 PM) ---
const int scheduleStartHour = 4;
const int scheduleEndHour = 22;

const List<String> weekDayLabels = [
  'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun',
];

int get scheduleTotalMinutes => (scheduleEndHour - scheduleStartHour) * 60;

double scheduleFraction(TimeOfDay time) =>
    minutesFromScheduleStart(time) / scheduleTotalMinutes;

int minutesFromScheduleStart(TimeOfDay time) =>
    (time.hour - scheduleStartHour) * 60 + time.minute;

bool isTimeWithinSchedule(TimeOfDay time) {
  if (time.hour < scheduleStartHour) return false;
  if (time.hour > scheduleEndHour) return false;
  if (time.hour == scheduleEndHour && time.minute > 0) return false;
  return true;
}

// --- Guided steps (Step 1 = Health) ---
const int guidedTotalSteps = 12;
const int guidedCurrentStepIndex = 0;

// --- Categories ---
class ScheduleCategory {
  const ScheduleCategory({
    required this.id,
    required this.name,
    required this.color,
    this.recommendedHours,
  });

  final String id;
  final String name;
  final Color color;
  final int? recommendedHours;
}

const int defaultRecommendedHours = 2;

const List<ScheduleCategory> scheduleCategories = [
  ScheduleCategory(id: 'health', name: 'Health', color: Color(0xFF7CB342), recommendedHours: 3),
  ScheduleCategory(id: 'friends', name: 'Friends', color: Color(0xFFE91E8C)),
  ScheduleCategory(id: 'spiritual', name: 'Spiritual', color: Color(0xFFCDDC39)),
  ScheduleCategory(id: 'cultural', name: 'Cultural', color: Color(0xFF00BCD4)),
  ScheduleCategory(id: 'family', name: 'Family', color: Color(0xFF4FC3F7)),
  ScheduleCategory(id: 'personal', name: 'Personal', color: Color(0xFF1565C0)),
  ScheduleCategory(id: 'community', name: 'Community', color: Color(0xFFFF9800)),
  ScheduleCategory(id: 'travel', name: 'Travel', color: Color(0xFF5C6BC0)),
  ScheduleCategory(id: 'admin', name: 'Admin', color: Color(0xFFFFEB3B)),
  ScheduleCategory(id: 'marketing', name: 'Marketing', color: Color(0xFFD81B60)),
  ScheduleCategory(id: 'financial', name: 'Financial', color: Color(0xFF9E9E9E)),
  ScheduleCategory(id: 'on_the_tools', name: 'On the Tools', color: Color(0xFFCE93D8)),
];

const List<String> guidedStepCategoryIds = [
  'health', 'friends', 'spiritual', 'cultural', 'family', 'personal',
  'community', 'travel', 'admin', 'marketing', 'financial', 'on_the_tools',
];

ScheduleCategory categoryById(String id) =>
    scheduleCategories.firstWhere((c) => c.id == id);

ScheduleCategory get activeStepCategory =>
    categoryById(guidedStepCategoryIds[guidedCurrentStepIndex]);

int recommendedHoursFor(ScheduleCategory category) =>
    category.recommendedHours ?? defaultRecommendedHours;

// --- Event model ---
class ScheduleEvent {
  ScheduleEvent({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.dayIndex,
    required this.startTime,
    required this.endTime,
  }) : assert(dayIndex >= 0 && dayIndex < 7),
       assert(_minutes(endTime) > _minutes(startTime));

  final String id;
  final String title;
  final String categoryId;
  final int dayIndex;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  int get startMinutes => _minutes(startTime);
  int get endMinutes => _minutes(endTime);
  int get durationMinutes => endMinutes - startMinutes;

  static int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

  String timeRangeLabel(BuildContext context) =>
      '${startTime.format(context)} – ${endTime.format(context)}';
}

String? validateEventInput({
  required int? dayIndex,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
}) {
  if (dayIndex == null) return 'Please select a day.';
  if (!isTimeWithinSchedule(startTime) || !isTimeWithinSchedule(endTime)) {
    return 'Times must be between 4:00 AM and 10:00 PM.';
  }
  if (endTime.hour * 60 + endTime.minute <= startTime.hour * 60 + startTime.minute) {
    return 'End time must be after start time.';
  }
  return null;
}

ScheduleEvent buildEvent({
  required String title,
  required String categoryId,
  required int dayIndex,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
}) {
  return ScheduleEvent(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: title,
    categoryId: categoryId,
    dayIndex: dayIndex,
    startTime: startTime,
    endTime: endTime,
  );
}

// --- Progress bar ---
class CategoryProgressSlot {
  const CategoryProgressSlot({
    required this.category,
    required this.recommendedHours,
    required this.scheduledHours,
  });

  final ScheduleCategory category;
  final int recommendedHours;
  final double scheduledHours;

  double get fillFraction =>
      (scheduledHours / recommendedHours).clamp(0.0, 1.0);
}

double hoursForCategory(List<ScheduleEvent> events, String categoryId) =>
    events
        .where((e) => e.categoryId == categoryId)
        .fold<double>(0, (sum, e) => sum + e.durationMinutes / 60);

String formatHours(double hours) {
  if (hours <= 0) return '0';
  final rounded = hours.round();
  if ((hours - rounded).abs() < 0.05) return '$rounded';
  return hours.toStringAsFixed(1);
}

List<CategoryProgressSlot> progressSlots(List<ScheduleEvent> events) {
  return scheduleCategories
      .map(
        (category) => CategoryProgressSlot(
          category: category,
          recommendedHours: recommendedHoursFor(category),
          scheduledHours: hoursForCategory(events, category.id),
        ),
      )
      .toList();
}
