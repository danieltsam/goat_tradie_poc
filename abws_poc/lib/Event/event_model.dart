// This file defines the data models related to a schedule event.
// It includes the core `EventModel` for individual events, and the `EventType` which defines the properties of different event categories.
import 'package:flutter/material.dart';

// ==== Helper Classes ========================================================

/// A data class that holds the properties for a specific category of event.
/// This couples the name of the event type (e.g., 'Health') with its associated UI color.
class EventType {
  final String name;
  final Color color;
  const EventType(this.name, this.color);
}

/// A const list that serves as the single source of truth for all available event categories in the application. Its a more robust way pairing event name and colour data.
/// 
/// This list defines the order of steps for the user's weekly structure setup.
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

/// A utility function to find and return the [EventType] details for a given
/// event name string.
///
/// If the name is not found in the [eventTypes] list, it returns a default
/// 'Unknown' type with a grey color to prevent errors.
EventType getEventTypeDetails(String name) {
  return eventTypes.firstWhere((type) => type.name == name, orElse: () => const EventType('Unknown', Colors.grey));
}
// ===============================================================================


/// The core data model for a single scheduled event.
///
/// This class is a plain Dart object that holds all the necessary data for an
/// event, but contains no UI logic.
/// 
/// This exists to track the users entries and interpret them throughout the app.
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

  /// A getter to retrieve the color for this event.
  /// 
  /// It looks up the color from the [eventTypes] list using its `eventType` string.
  Color get color => getEventTypeDetails(eventType).color;

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