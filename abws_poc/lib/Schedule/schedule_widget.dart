import 'package:flutter/material.dart';
import 'package:abws_poc/Event/event_model.dart';
import 'package:abws_poc/Schedule/widgets/addEventDialog_widget.dart';
import 'package:abws_poc/Schedule/widgets/scheduleActionButtons_widget.dart';
import 'package:abws_poc/Schedule/widgets/scheduleAppBar_widget.dart';
import 'package:abws_poc/Schedule/widgets/weeklyScheduleBody_widget.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() =>
      _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  int _stepTracker = 0;
  final List<EventModel> events = [];

  void _onAddPressed() async {
    final newEvent = await showAddScheduleDialog(context, _stepTracker, events);
    if (newEvent != null) {
      setState(() {
        events.add(newEvent);
      });
    }
  }

  void _onNextPressed() {
    if (_stepTracker < eventTypes.length - 1) {
      setState(() => _stepTracker++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Header App Bar
      appBar: ScheduleAppBarWidget(
        stepTracker: _stepTracker,
      ),

      // 2. 7-Day Calendar Body
      body: Column(
        children: [
          WeeklyScheduleBody(events: events),
        ],
      ),

      // 3. Bottom Action Buttons
      floatingActionButton: ScheduleActionButtonsWidget(
        onAddPressed: _onAddPressed,
        onNextPressed: _onNextPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}