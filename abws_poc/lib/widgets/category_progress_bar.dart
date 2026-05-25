import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/category_hours.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';
import 'package:abws_poc/schedule/guided_steps.dart';
import 'package:flutter/material.dart';

/// Red header strip: step badge, coloured progress bar, and compact legend.
class ScheduleHeaderProgress extends StatelessWidget {
  const ScheduleHeaderProgress({
    super.key,
    required this.events,
  });

  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    final segments = categoryHourSegments(events);
    final totalHours = segments.fold<double>(0, (sum, s) => sum + s.hours);

    return Container(
      height: 90,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.red,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${guidedCurrentStepIndex + 1}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: _ColoredProgressBar(
                      segments: segments,
                      totalHours: totalHours,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: _CategoryLegend(segments: segments),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColoredProgressBar extends StatelessWidget {
  const _ColoredProgressBar({
    required this.segments,
    required this.totalHours,
  });

  final List<({ScheduleCategory category, double hours})> segments;
  final double totalHours;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.centerLeft,
      child: totalHours <= 0
          ? const SizedBox.expand()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final segment in segments)
                  Expanded(
                    flex: (segment.hours * 1000).round().clamp(1, 100000),
                    child: ColoredBox(color: segment.category.color),
                  ),
              ],
            ),
    );
  }
}

class _CategoryLegend extends StatelessWidget {
  const _CategoryLegend({required this.segments});

  final List<({ScheduleCategory category, double hours})> segments;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Text(
          'Add time to see your week fill in',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final segment in segments) ...[
              _LegendChip(
                color: segment.category.color,
                label: segment.category.name,
                hours: segment.hours,
              ),
              const SizedBox(width: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({
    required this.color,
    required this.label,
    required this.hours,
  });

  final Color color;
  final String label;
  final double hours;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$label ${hours.toStringAsFixed(1)}h',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
