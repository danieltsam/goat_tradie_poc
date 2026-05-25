import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

class WeeklyScheduleBody extends StatelessWidget {
  const WeeklyScheduleBody({super.key, required this.events});

  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < weekDayLabels.length; i++)
              Expanded(
                child: _DayColumn(
                  dayIndex: i,
                  label: weekDayLabels[i],
                  isLast: i == weekDayLabels.length - 1,
                  events: events.where((e) => e.dayIndex == i).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  const _DayColumn({
    required this.dayIndex,
    required this.label,
    required this.isLast,
    required this.events,
  });

  final int dayIndex;
  final String label;
  final bool isLast;
  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          child: Container(
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(label, style: const TextStyle(fontSize: 14, fontFamily: 'Inter')),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.maxHeight;
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: isLast
                        ? BorderSide.none
                        : BorderSide(color: Colors.black.withValues(alpha: 0.5)),
                  ),
                ),
                child: Stack(
                  children: [
                    for (final event in events) _eventBlock(context, event, h),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _eventBlock(BuildContext context, ScheduleEvent event, double columnHeight) {
    final top = scheduleFraction(event.startTime) * columnHeight;
    final height =
        (scheduleFraction(event.endTime) - scheduleFraction(event.startTime)) * columnHeight;
    final color = categoryById(event.categoryId).color.withValues(alpha: 0.9);

    return Positioned(
      top: top,
      left: 2,
      right: 2,
      height: height.clamp(28, columnHeight - top),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            event.blockLabel(context),
            style: const TextStyle(fontSize: 9, height: 1.1, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
