import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_constants.dart';
import 'package:flutter/material.dart';

/// Validates form input. Returns an error message, or null if OK.
String? validateScheduleEventInput({
  required int? dayIndex,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
}) {
  if (dayIndex == null) return 'Please select a day.';
  if (!isTimeWithinSchedule(startTime) || !isTimeWithinSchedule(endTime)) {
    return 'Times must be between 4:00 AM and 10:00 PM.';
  }
  final startM = startTime.hour * 60 + startTime.minute;
  final endM = endTime.hour * 60 + endTime.minute;
  if (endM <= startM) return 'End time must be after start time.';
  return null;
}

/// Creates a new event after validation has passed.
ScheduleEvent buildScheduleEvent({
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
