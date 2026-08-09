import 'package:flutter/material.dart';

class ScheduleEvent {
  final String id;
  final String eventType;
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Color color;

  const ScheduleEvent({
    required this.id,
    required this.eventType,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.color = Colors.green,
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