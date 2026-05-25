import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

/// Colour dot + label for each category (home strip and drawer).
class CategoryLegend extends StatelessWidget {
  const CategoryLegend({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [for (final cat in scheduleCategories) _chip(cat)],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [for (final cat in scheduleCategories.take(3)) _chip(cat)],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: [for (final cat in scheduleCategories.skip(3)) _chip(cat)],
        ),
      ],
    );
  }

  Widget _chip(ScheduleCategory cat) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 8 : 10,
          height: compact ? 8 : 10,
          decoration: BoxDecoration(color: cat.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(cat.name, style: TextStyle(fontSize: compact ? 10 : 11)),
      ],
    );
  }
}

/// Drawer sidebar — swipe from left or tap ? on the footer.
class ScheduleSidebar extends StatelessWidget {
  const ScheduleSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final step = activeStepCategory;
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const CategoryLegend(),
              const SizedBox(height: 24),
              Text(
                'Step ${guidedCurrentStepIndex + 1} of $guidedTotalSteps',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Now adding: ${step.name}'),
              const SizedBox(height: 8),
              Text(
                'Tap + on the footer to add time blocks.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
