import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

/// Add-event form used in the tablet sidebar and phone dialog.
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
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Colors.red.shade700),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startTime = picked;
      } else {
        _endTime = picked;
      }
      _error = null;
    });
  }

  void _submit() {
    final title =
        widget.showTitleField ? _titleController.text.trim() : widget.categoryName;
    if (title.isEmpty) {
      setState(() => _error = 'Please enter a title.');
      return;
    }
    final validation = validateEventInput(
      dayIndex: _dayIndex,
      startTime: _startTime,
      endTime: _endTime,
    );
    if (validation != null) {
      setState(() => _error = validation);
      return;
    }
    widget.onEventAdded(
      buildEvent(
        title: title,
        categoryId: widget.categoryId,
        dayIndex: _dayIndex!,
        startTime: _startTime,
        endTime: _endTime,
      ),
    );
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    const label = TextStyle(fontFamily: 'Inter', color: Colors.black87);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitleField) ...[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: label,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
        ],
        _TimeRow(label: 'Start', time: _startTime, onTap: () => _pickTime(true)),
        const SizedBox(height: 8),
        _TimeRow(label: 'End', time: _endTime, onTap: () => _pickTime(false)),
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
              (i) => DropdownMenuItem(value: i, child: Text(weekDayLabels[i], style: label)),
            ),
            onChanged: (v) => setState(() {
              _dayIndex = v;
              _error = null;
            }),
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 8),
          Text(_error!, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Colors.red.shade700)),
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
          child: Text(widget.submitLabel, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow({required this.label, required this.time, required this.onTap});

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(time.format(context), style: const TextStyle(fontFamily: 'Inter')),
          const SizedBox(width: 4),
          const Icon(Icons.schedule, size: 18, color: Colors.black54),
        ],
      ),
    );
  }
}
