import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

class CategoryLegend extends StatelessWidget {
  const CategoryLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: [
        for (final cat in scheduleCategories) _chip(cat),
      ],
    );
  }

  Widget _chip(ScheduleCategory cat) {
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
        Text(cat.name, style: const TextStyle(fontSize: 11, color: Colors.black87)),
      ],
    );
  }
}

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
