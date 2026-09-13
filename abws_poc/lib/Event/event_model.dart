// This file defines the data models related to a schedule event.
// It includes the core `EventModel` for individual events, and the `EventType` which defines the properties of different event categories.
import 'package:flutter/material.dart';

// ==== Helper Classes ========================================================

/// A data class that holds the properties for a specific category of event.
/// This couples the name of the event type (e.g., 'Health') with its associated UI color.
class EventType {
  final String name;
  final Color color;
  final String shortName;
  const EventType(this.name, this.color, this.shortName);
}

/// A const list that serves as the single source of truth for all available event categories in the application. Its a more robust way pairing event name and colour data.
/// 
/// This list defines the order of steps for the user's weekly structure setup.
const List<EventType> eventTypes = [
  EventType('Health', Color(0xFF8A9A86), 'Health'), // Earthy Green
  EventType('Friends', Color(0xFFB5A1E2), 'Friends'), // Lavender
  EventType('Spiritual', Color(0xFF5C5292), 'Spirit'), // Medium Violet/ Indigo
  EventType('Cultural', Color(0xFFFFB347), 'Culture'), // Awakening Gold
  EventType('Family', Color(0xFFF3A78D), 'Family'), // Come together Warm Peach
  EventType('Personal', Color(0xFF2C7A7B), 'Person'), // Connection Teal
  EventType('Community', Color(0xFF007AFF), 'Comm.'), // Bright blue
  EventType('Travel', Color(0xFFFFD166), 'Travel'), // Yellow
  EventType('Admin', Color(0xFF8E8E93), 'Admin'), // Mid Grey
  EventType('Marketing', Color(0xFFFF7A00), 'Market'), // Orange
  EventType('Financial', Color(0xFF2E7D32), 'Finance'),  // Green
  EventType('On the Tools', Color(0xFF4A6572), 'Tools'), // Steel blue / charcoal
];

/// A utility function to find and return the [EventType] details for a given
/// event name string.
///
/// If the name or shortened version is not found in the [eventTypes] list, it returns a default
/// 'Unknown' type with a grey color to prevent errors.
EventType getEventTypeDetails(String name) {
  return eventTypes.firstWhere((type) => type.name == name || type.shortName == name, orElse: () => const EventType('Unknown', Colors.grey, '?'));
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
  final String shortType;
  final String day;
  TimeOfDay startTime;
  TimeOfDay endTime;

  EventModel({
    required this.id,
    required this.eventType,
    required this.shortType,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  /// A getter to retrieve the color for this event.
  /// 
  /// It looks up the color from the [eventTypes] list using its `eventType` string.
  Color get color => getEventTypeDetails(eventType).color;
  String get shortName =>getEventTypeDetails(eventType).shortName;

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