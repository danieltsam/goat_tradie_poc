import 'package:abws_poc/add_event_form.dart';
import 'package:abws_poc/schedule_data.dart';
import 'package:abws_poc/week_grid_view.dart';
import 'package:flutter/material.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  final List<ScheduleEvent> _events = [];

  void _addEvent(ScheduleEvent event) => setState(() => _events.add(event));

  void _showEventActions(ScheduleEvent event) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${weekDayLabels[event.dayIndex]} · ${event.timeRangeLabel(context)}'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Remove event'),
              onTap: () {
                setState(() => _events.removeWhere((e) => e.id == event.id));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Personal Time', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Inter')),
        content: SingleChildScrollView(
          child: AddEventForm(
            categoryId: 'personal',
            categoryName: 'Personal',
            showTitleField: true,
            submitLabel: 'Add',
            onEventAdded: (event) {
              _addEvent(event);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tablet = isTabletLayout(context);
    final grid = WeekGridView(events: _events, onEventTap: _showEventActions);

    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('A Better Weekly Structure', style: TextStyle(color: Colors.black, fontSize: 20)),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/back_arrow.png', height: 28, width: 28),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/icons/goat_temp.png', height: 36, width: 36),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: _HeaderProgress(events: _events),
        ),
      ),
      body: tablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TabletSidebar(events: _events, onEventAdded: _addEvent),
                Expanded(child: grid),
              ],
            )
          : grid,
      floatingActionButton: tablet
          ? null
          : FloatingActionButton(
              onPressed: _showAddDialog,
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
    );
  }
}

// --- Header progress bar (colour fill = booked ÷ recommended per slot) ---

class _HeaderProgress extends StatelessWidget {
  const _HeaderProgress({required this.events});
  final List<ScheduleEvent> events;

  @override
  Widget build(BuildContext context) {
    final slots = progressSlots(events);
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.red,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text(
                '${guidedCurrentStepIndex + 1}',
                style: const TextStyle(fontFamily: 'Inter', fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < slots.length; i++)
                      Expanded(
                        flex: slots[i].recommendedHours,
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final w = c.maxWidth * slots[i].fillFraction;
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                border: i < slots.length - 1
                                    ? Border(right: BorderSide(color: Colors.black12))
                                    : null,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  if (w > 0)
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      width: w,
                                      child: ColoredBox(color: slots[i].category.color),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Tablet sidebar ---

class _TabletSidebar extends StatelessWidget {
  const _TabletSidebar({required this.events, required this.onEventAdded});

  final List<ScheduleEvent> events;
  final ValueChanged<ScheduleEvent> onEventAdded;

  @override
  Widget build(BuildContext context) {
    final active = activeStepCategory;
    final booked = hoursForCategory(events, active.id);
    final recommended = active.recommendedHours;

    return Container(
      width: tabletSidebarWidth,
      color: const Color(0xFFE8E8E8),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _categoryList(),
            const SizedBox(height: 10),
            const Row(
              children: [
                _HelpButton(),
                SizedBox(width: 8),
                Icon(Icons.warning_amber, color: Color(0xFFFFC107), size: 22),
                SizedBox(width: 6),
                Expanded(child: Text('No issues detected', style: TextStyle(fontFamily: 'Inter', fontSize: 12))),
              ],
            ),
            const SizedBox(height: 14),
            Text('Step ${guidedCurrentStepIndex + 1} of $guidedTotalSteps',
                style: const TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(
              recommended != null
                  ? "Fill '${active.name}' time | Recommended: $recommended h | Current: ${formatHours(booked)} h"
                  : "Fill '${active.name}' time | Current: ${formatHours(booked)} h",
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

  Widget _categoryList() {
    Widget col(List<ScheduleCategory> items) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((cat) {
          final h = hoursForCategory(events, cat.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontFamily: 'Inter', fontSize: 11),
                children: [
                  TextSpan(text: cat.name, style: TextStyle(color: cat.color, fontWeight: FontWeight.w600)),
                  TextSpan(text: ' ${formatHours(h)} hours', style: const TextStyle(color: Colors.black87)),
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
        Expanded(child: col(scheduleCategories.take(6).toList())),
        const SizedBox(width: 8),
        Expanded(child: col(scheduleCategories.skip(6).toList())),
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
        child: const SizedBox(width: 36, height: 36, child: Icon(Icons.help, color: Colors.black, size: 22)),
      ),
    );
  }
}
