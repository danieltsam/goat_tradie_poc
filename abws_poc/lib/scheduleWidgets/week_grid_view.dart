import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';
import 'package:abws_poc/schedule/schedule_constants.dart';
import 'package:flutter/material.dart';

const double _dayHeaderHeight = 44;

/// Tablet weekly grid — 7 columns with 4AM / 12PM / 10PM markers.
class WeekGridView extends StatelessWidget {
  const WeekGridView({
    super.key,
    required this.events,
    required this.onEventTap,
    this.onNextWeek,
  });

  final List<ScheduleEvent> events;
  final void Function(ScheduleEvent event) onEventTap;
  final VoidCallback? onNextWeek;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: _dayHeaderHeight,
          child: Row(
            children: List.generate(
              weekDayLabels.length,
              (index) => Expanded(child: _DayHeader(label: weekDayLabels[index])),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  weekDayLabels.length,
                  (index) => Expanded(
                    child: _DayColumn(
                      dayIndex: index,
                      isLast: index == weekDayLabels.length - 1,
                      events: events,
                      onEventTap: onEventTap,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: FloatingActionButton(
                  heroTag: 'week_next',
                  mini: true,
                  onPressed: onNextWeek ?? () {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MilestoneLine extends StatelessWidget {
  const _MilestoneLine({
    required this.height,
    required this.label,
    this.fraction,
    this.alignBottom = false,
  });

  final double height;
  final String label;
  final double? fraction;
  final bool alignBottom;

  @override
  Widget build(BuildContext context) {
    final line = Container(
      height: 1,
      color: Colors.black.withValues(alpha: 0.35),
    );
    final text = Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontFamily: 'Inter',
        color: Colors.black.withValues(alpha: 0.5),
      ),
    );

    if (alignBottom) {
      return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
          children: [text, line],
        ),
      );
    }

    final top = (fraction ?? 0) * height;
    return Positioned(
      top: top.clamp(0, height - 20),
      left: 0,
      right: 0,
      child: Column(children: [text, line]),
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFBDBDBD),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 14, fontFamily: 'Inter', color: Colors.black),
        ),
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  const _DayColumn({
    required this.dayIndex,
    required this.isLast,
    required this.events,
    required this.onEventTap,
  });

  final int dayIndex;
  final bool isLast;
  final List<ScheduleEvent> events;
  final void Function(ScheduleEvent event) onEventTap;

  @override
  Widget build(BuildContext context) {
    final dayEvents =
        events.where((e) => e.dayIndex == dayIndex).toList()
          ..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            border: Border(
              right: isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.black.withValues(alpha: 0.45), width: 1),
            ),
          ),
          child: Stack(
            children: [
              _MilestoneLine(
                height: height,
                label: '4AM',
                fraction: scheduleFraction(const TimeOfDay(hour: 4, minute: 0)),
              ),
              _MilestoneLine(
                height: height,
                label: '12PM',
                fraction: scheduleFraction(const TimeOfDay(hour: 12, minute: 0)),
              ),
              _MilestoneLine(
                height: height,
                label: '10PM',
                alignBottom: true,
              ),
              ...dayEvents.map(
                (event) => _EventBlock(
                  event: event,
                  columnHeight: height,
                  onTap: () => onEventTap(event),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventBlock extends StatelessWidget {
  const _EventBlock({
    required this.event,
    required this.columnHeight,
    required this.onTap,
  });

  final ScheduleEvent event;
  final double columnHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final top = scheduleFraction(event.startTime) * columnHeight;
    final bottom = scheduleFraction(event.endTime) * columnHeight;
    final height = (bottom - top).clamp(20.0, columnHeight - top);

    Color blockColor;
    try {
      blockColor = categoryById(event.categoryId).color.withValues(alpha: 0.85);
    } catch (_) {
      blockColor = Colors.red.shade300;
    }

    return Positioned(
      top: top,
      left: 3,
      right: 3,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: blockColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black26),
            ),
            child: Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
