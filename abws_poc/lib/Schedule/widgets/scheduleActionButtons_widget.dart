import 'package:flutter/material.dart';

class ScheduleActionButtonsWidget extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onNextPressed;
  final VoidCallback? onHelpPressed;

  const ScheduleActionButtonsWidget({
    super.key,
    required this.onAddPressed,
    required this.onNextPressed,
    this.onHelpPressed,
  });

  void _defaultHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Information'),
          content: const Text(
            'Placeholder',
          ), // Include, What is ABWS, How to use, and why can't I put work first?
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Question mark button, responsible for the info section of the ABWS
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: onHelpPressed ?? () => _defaultHelpDialog(context),
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.help),
        ),

        const SizedBox(width: 10),

        // 'Plus' button, for adding things to the schedule
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: onAddPressed,
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),

        const SizedBox(width: 10),

        // Arrow / Next button, for changing categories
        FloatingActionButton(
          heroTag: "btn3",
          onPressed: onNextPressed,
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}

