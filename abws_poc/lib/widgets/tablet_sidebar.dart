import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_categories.dart';
import 'package:abws_poc/schedule/schedule_constants.dart';
import 'package:abws_poc/widgets/add_event_form.dart';
import 'package:flutter/material.dart';

/// Left panel on tablet — categories, step hint, and the shared add-event form.
class TabletSidebar extends StatelessWidget {
  const TabletSidebar({
    super.key,
    required this.events,
    required this.onEventAdded,
  });

  final List<ScheduleEvent> events;
  final ValueChanged<ScheduleEvent> onEventAdded;

  static const int totalSteps = 12;
  static const int currentStepIndex = 0;

  double _hoursForCategory(String categoryId) {
    return events
        .where((e) => e.categoryId == categoryId)
        .fold<double>(0, (sum, e) => sum + e.durationMinutes / 60);
  }

  @override
  Widget build(BuildContext context) {
    final active = categoryById(guidedStepCategoryIds[currentStepIndex]);
    final currentHours = _hoursForCategory(active.id);
    final recommended = active.recommendedHours;

    return Container(
      width: tabletSidebarWidth,
      color: const Color(0xFFE8E8E8),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFD0D0D0),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 10),
            CategoryHoursList(hoursForCategory: _hoursForCategory),
            const SizedBox(height: 10),
            const Row(
              children: [
                _HelpButton(),
                SizedBox(width: 8),
                Icon(Icons.warning_amber, color: Color(0xFFFFC107), size: 22),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'No issues detected',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              'Step ${currentStepIndex + 1} of $totalSteps',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              recommended != null
                  ? "Fill '${active.name}' time | Recommended: $recommended hours | Current: ${currentHours.toStringAsFixed(0)} hours"
                  : "Fill '${active.name}' time | Current: ${currentHours.toStringAsFixed(0)} hours",
              style: const TextStyle(fontFamily: 'Inter', fontSize: 11),
            ),
            const SizedBox(height: 14),
            AddEventForm(
              categoryId: active.id,
              categoryName: active.name,
              onEventAdded: onEventAdded,
            ),
          ],
        ),
      ),
    );
  }
}

/// Two-column list of life areas and hours logged per area.
class CategoryHoursList extends StatelessWidget {
  const CategoryHoursList({super.key, required this.hoursForCategory});

  final double Function(String categoryId) hoursForCategory;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Inter', fontSize: 11);

    Widget column(List<ScheduleCategory> items) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((cat) {
          final hours = hoursForCategory(cat.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                style: labelStyle,
                children: [
                  TextSpan(
                    text: cat.name,
                    style: TextStyle(color: cat.color, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: ' ${hours.toStringAsFixed(0)} hours'),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: column(scheduleCategories.take(6).toList())),
        const SizedBox(width: 8),
        Expanded(child: column(scheduleCategories.skip(6).toList())),
      ],
    );
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 36,
          height: 36,
          child: Icon(Icons.help, color: Colors.black, size: 22),
        ),
      ),
    );
  }
}
