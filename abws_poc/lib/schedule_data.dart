import 'package:flutter/material.dart';

const List<String> weekDayLabels = ['Sun', 'Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat'];

const int scheduleStartHour = 4;
const int scheduleEndHour = 22;
const int guidedTotalSteps = 5;
const int guidedCurrentStepIndex = 2; // "Step 3" in the UI

class ScheduleCategory {
  const ScheduleCategory({
    required this.id,
    required this.name,
    required this.color,
    this.recommendedHours = 2,
  });
  final String id;
  final String name;
  final Color color;
  final int recommendedHours;
}

const List<ScheduleCategory> scheduleCategories = [
  ScheduleCategory(id: 'on_tools', name: 'On The Tools', color: Color(0xFFE53935)),
  ScheduleCategory(id: 'family', name: 'Family Time', color: Color(0xFF81C784), recommendedHours: 3),
  ScheduleCategory(id: 'work_admin', name: 'Work Admin', color: Color(0xFF4FC3F7)),
  ScheduleCategory(id: 'personal', name: 'Personal Time', color: Color(0xFFFFEB3B)),
  ScheduleCategory(id: 'life_admin', name: 'Life Admin', color: Color(0xFFBA68C8)),
  ScheduleCategory(id: 'sleep', name: 'Sleep', color: Color(0xFF1565C0)),
];

const List<String> stepCategoryIds = [
  'on_tools', 'family', 'work_admin', 'personal', 'life_admin',
];

ScheduleCategory categoryById(String id) =>
    scheduleCategories.firstWhere((c) => c.id == id);

ScheduleCategory get activeStepCategory => categoryById(stepCategoryIds[guidedCurrentStepIndex]);

class ScheduleEvent {
  ScheduleEvent({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.dayIndex,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String title;
  final String categoryId;
  final int dayIndex;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  int get durationMinutes {
    final start = startTime.hour * 60 + startTime.minute;
    final end = endTime.hour * 60 + endTime.minute;
    return end - start;
  }

  String blockLabel(BuildContext context) {
    final start = startTime.format(context).replaceAll(' ', '');
    final end = endTime.format(context).replaceAll(' ', '');
    return '$start - $end\n$title';
  }
}

double scheduleFraction(TimeOfDay time) {
  final minutes = (time.hour - scheduleStartHour) * 60 + time.minute;
  return minutes / ((scheduleEndHour - scheduleStartHour) * 60);
}

ScheduleEvent buildEvent({
  required String categoryId,
  required String title,
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

double hoursForCategory(List<ScheduleEvent> events, String categoryId) {
  return events
      .where((e) => e.categoryId == categoryId)
      .fold<double>(0, (sum, e) => sum + e.durationMinutes / 60);
}

/// One segment per category: slot width = recommended hours, fill = hours booked.
List<({ScheduleCategory category, int flex, double fill})> categoryProgressSlots(
  List<ScheduleEvent> events,
) {
  return [
    for (final category in scheduleCategories)
      (
        category: category,
        flex: category.recommendedHours,
        fill: (hoursForCategory(events, category.id) / category.recommendedHours).clamp(0.0, 1.0),
      ),
  ];
}

String? validateEvent({required int? dayIndex, required TimeOfDay start, required TimeOfDay end}) {
  if (dayIndex == null) return 'Select a day.';
  if (end.hour * 60 + end.minute <= start.hour * 60 + start.minute) {
    return 'End time must be after start.';
  }
  return null;
}
