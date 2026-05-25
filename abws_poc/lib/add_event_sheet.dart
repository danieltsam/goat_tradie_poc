import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

Future<void> showAddEventSheet(
  BuildContext context, {
  required ScheduleCategory category,
  required ValueChanged<ScheduleEvent> onSaved,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => _AddEventSheet(category: category, onSaved: onSaved),
  );
}

class _AddEventSheet extends StatefulWidget {
  const _AddEventSheet({required this.category, required this.onSaved});

  final ScheduleCategory category;
  final ValueChanged<ScheduleEvent> onSaved;

  @override
  State<_AddEventSheet> createState() => _AddEventSheetState();
}

class _AddEventSheetState extends State<_AddEventSheet> {
  int? _dayIndex;
  TimeOfDay _start = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 9, minute: 0);
  String? _error;

  Future<void> _pickTime(bool start) async {
    final value = await showTimePicker(context: context, initialTime: start ? _start : _end);
    if (value == null) return;
    setState(() {
      if (start) {
        _start = value;
      } else {
        _end = value;
      }
      _error = null;
    });
  }

  void _save() {
    final error = validateEvent(dayIndex: _dayIndex, start: _start, end: _end);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    widget.onSaved(buildEvent(
      categoryId: widget.category.id,
      title: widget.category.name,
      dayIndex: _dayIndex!,
      startTime: _start,
      endTime: _end,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + MediaQuery.paddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Add ${widget.category.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              const Spacer(),
              IconButton(onPressed: _save, icon: const Icon(Icons.check)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _timeTile('Start', _start, () => _pickTime(true))),
              const Icon(Icons.arrow_forward),
              Expanded(child: _timeTile('End', _end, () => _pickTime(false))),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            decoration: InputDecoration(
              labelText: 'Select Day',
              filled: true,
              fillColor: const Color(0xFFE0E0E0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            ),
            initialValue: _dayIndex,
            items: List.generate(
              weekDayLabels.length,
              (i) => DropdownMenuItem(value: i, child: Text(weekDayLabels[i])),
            ),
            onChanged: (v) => setState(() {
              _dayIndex = v;
              _error = null;
            }),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _timeTile(String label, TimeOfDay time, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 11)),
          Text(time.format(context), style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
