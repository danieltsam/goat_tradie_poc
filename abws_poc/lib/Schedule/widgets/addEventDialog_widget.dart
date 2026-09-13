import 'package:flutter/material.dart';
import 'package:abws_poc/Event/event_model.dart';

const List<String> _days = [
  'Mon',
  'Tues',
  'Wed',
  'Thur',
  'Fri',
  'Sat',
  'Sun',
];

/// Opens the modal dialog for adding an event to the schedule.
Future<EventModel?> showAddScheduleDialog(
  BuildContext context,
  int currentStep,
  List<EventModel> events,
) async {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String? selectedDay = 'Mon';

  return await showDialog<EventModel>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          int timetoMinutes(TimeOfDay time) {
            return time.hour * 60 + time.minute;
          }

          return AlertDialog(
            title: Text(
              "Add ${eventTypes[currentStep].name} Time",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    "Start Time: ${startTime.format(context)}",
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );

                    if (picked != null) {
                      setState(() => startTime = picked);
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    "End Time: ${endTime.format(context)}",
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) {
                      setState(() => endTime = picked);
                    }
                  },
                ),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  value: selectedDay,
                  isExpanded: true,
                  items: _days.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => selectedDay = newValue);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newStart = timetoMinutes(startTime);
                  final newEnd = timetoMinutes(endTime);

                  // (1) First check: start time earlier than end time
                  if (newStart >= newEnd) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Start time must be earlier than end time.'),
                      ),
                    );
                    return;
                  }

                  // (2) Second check: overlap
                  final hasOverlap = events.any((event) {
                    if (event.day != selectedDay) {
                      return false;
                    }

                    final existingStart = timetoMinutes(event.startTime);
                    final existingEnd = timetoMinutes(event.endTime);

                    return newStart < existingEnd && newEnd > existingStart;
                  });

                  if (hasOverlap) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('This activity overlaps with another one.'),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(
                    context,
                    EventModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      eventType: eventTypes[currentStep].name,
                      shortType: eventTypes[currentStep].shortName,
                      day: selectedDay!,
                      startTime: startTime,
                      endTime: endTime,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    },
  );
}
