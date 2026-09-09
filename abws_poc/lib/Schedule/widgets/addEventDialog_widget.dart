import 'package:flutter/material.dart';
import 'package:abws_poc/Event/event_model.dart';
import 'package:abws_poc/Schedule/schedule_model.dart';

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
                  items: scheduleDays.map((String value) {
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
                  // 1. Check start earlier than end
                  if (!isStartBeforeEnd(startTime, endTime)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Start time must be earlier than end time.'),
                      ),
                    );
                    return;
                  }

                  // 2. Check collision / overlap
                  if (checkEventOverlap(
                    events: events,
                    day: selectedDay!,
                    startTime: startTime,
                    endTime: endTime,
                  )) {
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
