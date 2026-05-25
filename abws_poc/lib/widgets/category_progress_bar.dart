import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/category_hours.dart';
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
    final slots = categoryProgressSlots(events);
    final booked = categoryHourSegments(events);

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
                    child: _ColoredProgressBar(slots: slots),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: _CategoryLegend(slots: booked),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Bar divided by recommended hours; colour fills only the booked portion of each slot.
class _ColoredProgressBar extends StatelessWidget {
  const _ColoredProgressBar({required this.slots});

  final List<CategoryProgressSlot> slots;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final slot in slots)
            Expanded(
              flex: slot.recommendedHours,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final fillWidth =
                      constraints.maxWidth * slot.fillFraction;
                  return Stack(
                    children: [
                      if (fillWidth > 0)
                        SizedBox(
                          width: fillWidth,
                          child: ColoredBox(color: slot.category.color),
                        ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryLegend extends StatelessWidget {
  const _CategoryLegend({required this.slots});

  final List<CategoryProgressSlot> slots;

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'Bar shows progress toward $totalRecommendedHours recommended hours',
          textAlign: TextAlign.center,
          style: const TextStyle(
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
            for (final slot in slots) ...[
              _LegendChip(slot: slot),
              const SizedBox(width: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  const _LegendChip({required this.slot});

  final CategoryProgressSlot slot;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: slot.category.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '${slot.category.name} ${slot.scheduledHours.toStringAsFixed(1)}/${slot.recommendedHours}h',
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
