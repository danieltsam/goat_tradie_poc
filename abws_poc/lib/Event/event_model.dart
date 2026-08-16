import 'package:flutter/material.dart';

class EventType {
  final String name;
  final Color color;
  const EventType(this.name, this.color);
}

// A list of all event types, with their corresponding colors
const List<EventType> eventTypes = [
  EventType('Health', Color(0xFF0BC42A)),
  EventType('Friends Time', Color(0xFFCE2127)),
  EventType('Spiritual', Color(0xABCEED00)),
  EventType('Cultural', Color(0xC0C0C0C0)),
  EventType('Family Time', Color(0xA1C1E3EE)),
  EventType('Personal Time', Color(0xFF5E35B1)), // Placeholder
  EventType('Community', Color(0xFFFDD835)), // Placeholder
  EventType('Travel', Color(0xFFFB8C00)), // Placeholder
  EventType('Admin', Color(0xFF43A047)), // Placeholder
  EventType('Marketing', Color(0xFF1E88E5)), // Placeholder
  EventType('Financial', Color(0xFF8E24AA)), // Placeholder
  EventType('On the Tools', Color(0xFFD81B60)), // Placeholder
];

// Helper to get event details by name
EventType getEventTypeDetails(String name) {
  return eventTypes.firstWhere((type) => type.name == name, orElse: () => const EventType('Unknown', Colors.grey));
}

class EventModel {
  final String id;
  final String eventType;
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const EventModel({
    required this.id,
    required this.eventType,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  // A getter to easily access the color
  Color get color => getEventTypeDetails(eventType).color;

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