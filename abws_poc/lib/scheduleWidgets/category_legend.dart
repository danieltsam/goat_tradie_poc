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
    final dotSize = compact ? 10.0 : 12.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: cat.color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 4),
        Text(cat.name, style: TextStyle(fontSize: compact ? 10 : 11, color: Colors.black87)),
      ],
    );
  }
}

/// Segmented bar: each category gets its own colour and proportional fill.
class CategoryProgressBar extends StatelessWidget {
  const CategoryProgressBar({super.key, required this.events});

  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    final slots = categoryProgressSlots(events);

    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          for (var i = 0; i < slots.length; i++)
            Expanded(
              flex: slots[i].flex,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: i < slots.length - 1
                      ? const Border(right: BorderSide(color: Colors.black12))
                      : null,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FractionallySizedBox(
                      widthFactor: slots[i].fill,
                      alignment: Alignment.centerLeft,
                      child: ColoredBox(color: slots[i].category.color),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
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
