import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/category_hours.dart';
import 'package:abws_poc/schedule/guided_steps.dart';
import 'package:flutter/material.dart';

/// Red header strip: step badge + one progress bar (sidebar has the text legend).
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _ColoredProgressBar(slots: slots),
            ),
          ),
        ],
      ),
    );
  }
}

/// One bar: slot width = recommended hours; coloured fill = hours booked in that area.
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
          for (var i = 0; i < slots.length; i++)
            Expanded(
              flex: slots[i].recommendedHours,
              child: _ProgressSlot(
                slot: slots[i],
                showRightBorder: i < slots.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _ProgressSlot extends StatelessWidget {
  const _ProgressSlot({
    required this.slot,
    required this.showRightBorder,
  });

  final CategoryProgressSlot slot;
  final bool showRightBorder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fillWidth = constraints.maxWidth * slot.fillFraction.clamp(0.0, 1.0);

        return DecoratedBox(
          decoration: BoxDecoration(
            border: showRightBorder
                ? Border(
                    right: BorderSide(
                      color: Colors.black.withValues(alpha: 0.12),
                    ),
                  )
                : null,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (fillWidth > 0)
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: fillWidth,
                  child: ColoredBox(color: slot.category.color),
                ),
            ],
          ),
        );
      },
    );
  }
}
