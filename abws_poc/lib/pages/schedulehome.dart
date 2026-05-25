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
    final stepProgress = stepNumber / guidedTotalSteps;

    return Scaffold(
      drawer: const ScheduleSidebar(),
      appBar: _appBar(stepNumber, stepProgress),
      body: Column(
        children: [
          WeeklyScheduleBody(events: _events),
        ],
      ),
      floatingActionButton: _footerButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _appBar(int stepNumber, double stepProgress) {
    return AppBar(
      title: const Text(
        'A Better Weekly Schedule',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      backgroundColor: Colors.red,
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
        preferredSize: const Size.fromHeight(96),
        child: Container(
          height: 96,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
                    '$stepNumber',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Step $stepNumber of $guidedTotalSteps', style: const TextStyle(fontSize: 10)),
                    const SizedBox(height: 2),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: stepProgress,
                        minHeight: 6,
                        backgroundColor: Colors.white,
                        color: activeStepCategory.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CategoryLegend(compact: true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
