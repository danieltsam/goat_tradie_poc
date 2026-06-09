import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

Future<void> showHelpModal(BuildContext context, {required int stepIndex}) {
  final step = stepCategoryAt(stepIndex);
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
        ),
        child: const Text(
          'How this works',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${stepIndex + 1} of $guidedTotalSteps: add ${step.name} blocks to your week.',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const Text('• Tap + to add a time block for the current step.'),
          const SizedBox(height: 6),
          const Text('• Tap → when you are done to move to the next category.'),
          const SizedBox(height: 6),
          const Text('• The coloured bar shows progress for each category.'),
          const SizedBox(height: 6),
          const Text('• Match the legend dots to blocks on the calendar.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it'),
        ),
      ],
    ),
  );
}
