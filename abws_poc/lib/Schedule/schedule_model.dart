import 'package:flutter/material.dart';
import 'package:abws_poc/Event/event_model.dart';

// ==== Constants =============================================================

const List<String> scheduleDays = [
  'Mon',
  'Tues',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

// ==== Helper Functions & Business Logic =====================================

int timeToMinutes(TimeOfDay time) {
  return time.hour * 60 + time.minute;
}

bool isStartBeforeEnd(TimeOfDay startTime, TimeOfDay endTime) {
  return timeToMinutes(startTime) < timeToMinutes(endTime);
}

/// Checks if a proposed event on [day] from [startTime] to [endTime]
/// overlaps with any existing events in [events].
///
/// If [ignoreEventId] is provided, that event will be excluded from collision
/// detection (useful when editing an existing event).
bool checkEventOverlap({
  required List<EventModel> events,
  required String day,
  required TimeOfDay startTime,
  required TimeOfDay endTime,
  String? ignoreEventId,
}) {
  final newStart = timeToMinutes(startTime);
  final newEnd = timeToMinutes(endTime);

  return events.any((event) {
    // Only check collision against events on the same day
    if (event.day != day) return false;

    // Skip the event being edited
    if (ignoreEventId != null && event.id == ignoreEventId) return false;

    final existingStart = timeToMinutes(event.startTime);
    final existingEnd = timeToMinutes(event.endTime);
    
    return newStart < existingEnd && newEnd > existingStart;
  });
}

List<EventModel> getEventsForDay(List<EventModel> events, String day) {
  return events.where((event) => event.day == day).toList();
}