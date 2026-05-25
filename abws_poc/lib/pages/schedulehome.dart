import 'package:abws_poc/add_event_sheet.dart';
import 'package:abws_poc/schedule_data.dart';
import 'package:abws_poc/scheduleWidgets/category_legend.dart';
import 'package:abws_poc/scheduleWidgets/schedulewidgets.dart';
import 'package:flutter/material.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  late List<ScheduleEvent> _events;

  @override
  void initState() {
    super.initState();
    _events = [
      buildEvent(
        categoryId: 'family',
        title: 'Family Time',
        dayIndex: 0,
        startTime: const TimeOfDay(hour: 7, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
      ),
      buildEvent(
        categoryId: 'personal',
        title: 'Personal Time',
        dayIndex: 2,
        startTime: const TimeOfDay(hour: 17, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
      ),
      buildEvent(
        categoryId: 'work_admin',
        title: 'Work Admin',
        dayIndex: 6,
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
      ),
      buildEvent(
        categoryId: 'family',
        title: 'Family Time',
        dayIndex: 6,
        startTime: const TimeOfDay(hour: 12, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
      ),
    ];
  }

  void _addEvent(ScheduleEvent event) => setState(() => _events.add(event));

  void _openAddSheet() {
    showAddEventSheet(context, category: activeStepCategory, onSaved: _addEvent);
  }

  @override
  Widget build(BuildContext context) {
    final stepNumber = guidedCurrentStepIndex + 1;

    return Scaffold(
      drawer: const ScheduleSidebar(),
      appBar: _appBar(stepNumber),
      body: Column(
        children: [
          _statusAndLegend(stepNumber),
          WeeklyScheduleBody(events: _events),
        ],
      ),
      floatingActionButton: _footerButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _appBar(int stepNumber) {
    return AppBar(
      title: const Text(
        'A Better Weekly Schedule',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      backgroundColor: Colors.red,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Image.asset('assets/icons/back_arrow.png', height: 20, width: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Image.asset('assets/icons/goat_temp.png', height: 28, width: 28),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$stepNumber',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// White panel below the red app bar — avoids AppBar tint washing out legend colours.
  Widget _statusAndLegend(int stepNumber) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Step $stepNumber of $guidedTotalSteps', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            CategoryProgressBar(events: _events),
            const SizedBox(height: 10),
            const CategoryLegend(compact: true),
          ],
        ),
      ),
    );
  }

  Widget _footerButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: 'help',
          onPressed: () => Scaffold.of(context).openDrawer(),
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          child: const Icon(Icons.help),
        ),
        FloatingActionButton(
          heroTag: 'add',
          onPressed: _openAddSheet,
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
        ),
        FloatingActionButton(
          heroTag: 'next',
          onPressed: () {},
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
