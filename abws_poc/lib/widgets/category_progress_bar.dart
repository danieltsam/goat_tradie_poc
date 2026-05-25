import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/category_hours.dart';
import 'package:abws_poc/schedule/guided_steps.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';
import 'package:flutter/material.dart';

/// Red header strip: step badge, coloured progress bar, colour key (no duplicate text).
class ScheduleHeaderProgress extends StatelessWidget {
  const ScheduleHeaderProgress({
    super.key,
    required this.events,
  });

  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    final slots = categoryProgressSlots(events);

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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: _ColorKeyStrip(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Bar width = recommended hours per category; fill = scheduled ÷ recommended.
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
              child: ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: slot.fillFraction.clamp(0.0, 1.0),
                  child: ColoredBox(color: slot.category.color),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Colour-only key under the bar (labels live in the sidebar list).
class _ColorKeyStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final category in scheduleCategories)
            Expanded(
              flex: recommendedHoursFor(category),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 3),
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
