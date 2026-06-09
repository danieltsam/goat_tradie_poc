import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

class CategoryLegend extends StatelessWidget {
  const CategoryLegend({super.key, required this.events});

  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: [
        for (final cat in scheduleCategories) _chip(cat, hoursForCategory(events, cat.id)),
      ],
    );
  }

  Widget _chip(ScheduleCategory cat, double hours) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: cat.color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '${cat.name} ${formatHours(hours)}h',
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }
}

class CategoryProgressBar extends StatelessWidget {
  const CategoryProgressBar({super.key, required this.events});

  final List<ScheduleEvent> events;

  static const double _barHeight = 12;

  @override
  Widget build(BuildContext context) {
    final slots = categoryProgressSlots(events);
    final booked = [for (final slot in slots) if (slot.hours > 0) slot];

    if (booked.isEmpty) {
      return Container(
        height: _barHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: _barHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < booked.length; i++)
              Expanded(
                flex: (booked[i].hours * 100).round().clamp(1, 10000),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: booked[i].category.color,
                    border: i < booked.length - 1
                        ? const Border(right: BorderSide(color: Colors.black12))
                        : null,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
