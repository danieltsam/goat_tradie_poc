import 'package:flutter/material.dart';

/// Visible hours on the weekly grid (4:00 AM – 10:00 PM per design).
const int scheduleStartHour = 4;
const int scheduleEndHour = 22;

const List<String> weekDayLabels = [
  'Mon',
  'Tues',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

/// Milestone labels drawn inside each day column.
const List<({int hour, String label})> scheduleMilestones = [
  (hour: 4, label: '4AM'),
  (hour: 12, label: '12PM'),
  (hour: 22, label: '10PM'),
];

int get scheduleTotalMinutes => (scheduleEndHour - scheduleStartHour) * 60;

int minutesFromScheduleStart(TimeOfDay time) {
  return (time.hour - scheduleStartHour) * 60 + time.minute;
}

double scheduleFraction(TimeOfDay time) {
  return minutesFromScheduleStart(time) / scheduleTotalMinutes;
}

bool isTimeWithinSchedule(TimeOfDay time) {
  if (time.hour < scheduleStartHour) return false;
  if (time.hour > scheduleEndHour) return false;
  if (time.hour == scheduleEndHour && time.minute > 0) return false;
  return true;
}

/// Tablet sidebar width.
const double tabletSidebarWidth = 300;
