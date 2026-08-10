import 'package:flutter/material.dart';

// A list of all event types, matched to the steps the user takes to fill them in, i.e., admin and on the tools last
const List<String> eventSteps = ['Health', 'Friends Time', 'Spiritual', 'Cultural', 'Family Time', 'Personal Time', 'Community', 'Travel', 'Admin', 'Marketing', 'Financial', 'On the Tools'];
// A list of colours, corresponding to event types, these should always be indexed together / share value for indexing
const List<Color> eventColors = [Color(0xFF0BC42A), Color(0xFFCE2127), Color(0xABCEED00), Color(0xC0C0C0C0), Color(0xA1C1E3EE)];
// TEMP Colours, waiting on list from Miles, so not finalised
// Both above lists MUST be same length (12), i.e. from 0-11
class ScheduleEvent {
  final String id;
  final String eventType;
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color eventColor;

  

  const ScheduleEvent({
    required this.id,
    required this.eventType,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.eventColor,
  });

  // Convert to Firestore
  Map<String, dynamic> toMap() {
    return {
      'eventType': eventType,
      'day': day,
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
    };
  }
}