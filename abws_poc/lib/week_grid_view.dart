import 'package:abws_poc/schedule_data.dart';
import 'package:flutter/material.dart';

/// Seven-day schedule grid with 4AM / 12PM / 10PM markers.
class WeekGridView extends StatelessWidget {
  const WeekGridView({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  final List<ScheduleEvent> events;
  final void Function(ScheduleEvent event) onEventTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: Row(
            children: weekDayLabels
                .map((d) => Expanded(child: _DayHeader(label: d)))
                .toList(),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  weekDayLabels.length,
                  (i) => Expanded(
                    child: _DayColumn(
                      dayIndex: i,
                      isLast: i == weekDayLabels.length - 1,
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
                  onPressed: () {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
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
        child: Text(label, style: const TextStyle(fontSize: 14, fontFamily: 'Inter')),
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
    final dayEvents = events.where((e) => e.dayIndex == dayIndex).toList()
      ..sort((a, b) => a.startMinutes.compareTo(b.startMinutes));

    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            border: Border(
              right: isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.black.withValues(alpha: 0.45)),
            ),
          ),
          child: Stack(
            children: [
              _timeLine(h, '4AM', scheduleFraction(const TimeOfDay(hour: 4, minute: 0))),
              _timeLine(h, '12PM', scheduleFraction(const TimeOfDay(hour: 12, minute: 0))),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Text('10PM', style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.black54)),
                    Container(height: 1, color: Colors.black38),
                  ],
                ),
              ),
              ...dayEvents.map(
                (e) => _EventBlock(event: e, columnHeight: h, onTap: () => onEventTap(e)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _timeLine(double height, String label, double fraction) {
    return Positioned(
      top: fraction * height,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.black54)),
          Container(height: 1, color: Colors.black38),
        ],
      ),
    );
  }
}

class _EventBlock extends StatelessWidget {
  const _EventBlock({required this.event, required this.columnHeight, required this.onTap});

  final ScheduleEvent event;
  final double columnHeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final top = scheduleFraction(event.startTime) * columnHeight;
    final height = (scheduleFraction(event.endTime) - scheduleFraction(event.startTime)) *
        columnHeight;

    Color color;
    try {
      color = categoryById(event.categoryId).color.withValues(alpha: 0.85);
    } catch (_) {
      color = Colors.red.shade300;
    }

    return Positioned(
      top: top,
      left: 3,
      right: 3,
      height: height.clamp(20, columnHeight - top),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black26),
            ),
            child: Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontFamily: 'Inter', fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
