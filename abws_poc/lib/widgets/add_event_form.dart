import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_constants.dart';
import 'package:abws_poc/schedule/schedule_event_builder.dart';
import 'package:abws_poc/widgets/time_picker_button.dart';
import 'package:flutter/material.dart';

/// Shared form for adding events — used on tablet (sidebar) and phone (dialog).
class AddEventForm extends StatefulWidget {
  const AddEventForm({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.onEventAdded,
    this.showTitleField = false,
    this.submitLabel = 'Add to Schedule +',
  });

  final String categoryId;
  final String categoryName;
  final ValueChanged<ScheduleEvent> onEventAdded;
  final bool showTitleField;
  final String submitLabel;

  @override
  State<AddEventForm> createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final _titleController = TextEditingController();
  int? _dayIndex;
  TimeOfDay _startTime = const TimeOfDay(hour: 6, minute: 30);
  TimeOfDay _endTime = const TimeOfDay(hour: 7, minute: 30);
  String? _errorMessage;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = widget.showTitleField
        ? _titleController.text.trim()
        : widget.categoryName;
    if (title.isEmpty) {
      setState(() => _errorMessage = 'Please enter a title.');
      return;
    }

    final error = validateScheduleEventInput(
      dayIndex: _dayIndex,
      startTime: _startTime,
      endTime: _endTime,
    );
    if (error != null) {
      setState(() => _errorMessage = error);
      return;
    }

    widget.onEventAdded(
      buildScheduleEvent(
        title: title,
        categoryId: widget.categoryId,
        dayIndex: _dayIndex!,
        startTime: _startTime,
        endTime: _endTime,
      ),
    );
    setState(() => _errorMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Inter', color: Colors.black87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitleField) ...[
          TextField(
            controller: _titleController,
            style: labelStyle,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: labelStyle,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
        ],
        TimePickerButton(
          label: 'Start',
          time: _startTime,
          onTimeChanged: (t) => setState(() {
            _startTime = t;
            _errorMessage = null;
          }),
        ),
        const SizedBox(height: 8),
        TimePickerButton(
          label: 'End',
          time: _endTime,
          onTimeChanged: (t) => setState(() {
            _endTime = t;
            _errorMessage = null;
          }),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButton<int>(
            isExpanded: true,
            value: _dayIndex,
            hint: const Text('Select Day', style: TextStyle(fontFamily: 'Inter')),
            underline: const SizedBox.shrink(),
            items: List.generate(
              weekDayLabels.length,
              (i) => DropdownMenuItem(
                value: i,
                child: Text(weekDayLabels[i], style: labelStyle),
              ),
            ),
            onChanged: (v) => setState(() {
              _dayIndex = v;
              _errorMessage = null;
            }),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: Colors.red.shade700,
            ),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          ),
          child: Text(
            widget.submitLabel,
            style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
