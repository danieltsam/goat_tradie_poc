import 'package:abws_poc/add_event_sheet.dart';
import 'package:abws_poc/help_modal.dart';
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
  late int _stepIndex;

  @override
  void initState() {
    super.initState();
    _events = demoEvents();
    _stepIndex = initialGuidedStepIndex;
  }

  void _addEvent(ScheduleEvent event) => setState(() => _events.add(event));

  void _openAddSheet() {
    showAddEventSheet(
      context,
      category: stepCategoryAt(_stepIndex),
      onSaved: _addEvent,
    );
  }

  void _openHelp() {
    showHelpModal(context, stepIndex: _stepIndex);
  }

  void _nextStep() {
    if (!canAdvanceStep(_stepIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have completed all guided steps.')),
      );
      return;
    }
    setState(() => _stepIndex++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Step ${_stepIndex + 1}: add ${stepCategoryAt(_stepIndex).name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stepNumber = _stepIndex + 1;
    final currentCategory = stepCategoryAt(_stepIndex);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'A Better Weekly Schedule',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/back_arrow.png', height: 22, width: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/icons/goat_temp.png', height: 32, width: 32),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Adding: ${currentCategory.name}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Step $stepNumber of $guidedTotalSteps', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                CategoryProgressBar(events: _events),
                const SizedBox(height: 10),
                CategoryLegend(events: _events),
              ],
            ),
          ),
          WeeklyScheduleBody(events: _events),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _footerButton(Icons.help_outline, _openHelp),
          _footerButton(Icons.add, _openAddSheet),
          _footerButton(Icons.arrow_forward, _nextStep),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _footerButton(IconData icon, VoidCallback onPressed) {
    return FloatingActionButton(
      heroTag: icon.codePoint.toString(),
      onPressed: onPressed,
      backgroundColor: Colors.red,
      foregroundColor: Colors.black,
      elevation: 2,
      shape: const CircleBorder(),
      child: Icon(icon),
    );
  }
}
