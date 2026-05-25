import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/widgets/add_event_form.dart';
import 'package:flutter/material.dart';

/// Phone-friendly dialog — wraps the same [AddEventForm] as the tablet sidebar.
Future<void> showAddEventDialog(
  BuildContext context, {
  required ValueChanged<ScheduleEvent> onEventAdded,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'Add Personal Time',
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Inter'),
      ),
      content: SingleChildScrollView(
        child: AddEventForm(
          categoryId: 'personal',
          categoryName: 'Personal',
          showTitleField: true,
          submitLabel: 'Add',
          onEventAdded: (event) {
            onEventAdded(event);
            Navigator.of(context).pop();
          },
        ),
      ),
    ),
  );
}
