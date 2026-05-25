import 'package:flutter/material.dart';

/// Opens the platform time picker (Material / Cupertino depending on device).
Future<TimeOfDay?> pickScheduleTime(
  BuildContext context, {
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Colors.red.shade700),
        ),
        child: child!,
      );
    },
  );
}

/// Tappable row that shows a label and time, then opens [pickScheduleTime].
class TimePickerButton extends StatelessWidget {
  const TimePickerButton({
    super.key,
    required this.label,
    required this.time,
    required this.onTimeChanged,
  });

  final String label;
  final TimeOfDay time;
  final ValueChanged<TimeOfDay> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        final picked = await pickScheduleTime(context, initialTime: time);
        if (picked != null) onTimeChanged(picked);
      },
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            time.format(context),
            style: const TextStyle(fontFamily: 'Inter', color: Colors.black87),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.schedule, size: 18, color: Colors.black54),
        ],
      ),
    );
  }
}
