import 'package:flutter/material.dart';

/// A block of personal time on the weekly schedule.
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
  /// 0 = Monday … 6 = Sunday
  final int dayIndex;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  int get startMinutes => _minutes(startTime);
  int get endMinutes => _minutes(endTime);
  int get durationMinutes => endMinutes - startMinutes;

  static int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

  String timeRangeLabel(BuildContext context) {
    final start = startTime.format(context);
    final end = endTime.format(context);
    return '$start – $end';
  }
}
