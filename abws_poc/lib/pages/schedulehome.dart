import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/schedule_constants.dart';
import 'package:abws_poc/schedule/schedule_layout.dart';
import 'package:abws_poc/scheduleWidgets/week_grid_view.dart';
import 'package:abws_poc/widgets/add_event_dialog.dart';
import 'package:abws_poc/widgets/category_progress_bar.dart';
import 'package:abws_poc/widgets/tablet_sidebar.dart';
import 'package:flutter/material.dart';

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() => _ScheduleHomePageState();
}

class _ScheduleHomePageState extends State<ScheduleHomePage> {
  final List<ScheduleEvent> _events = [];

  void _addEvent(ScheduleEvent event) {
    setState(() => _events.add(event));
  }

  void _showEventActions(ScheduleEvent event) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                '${weekDayLabels[event.dayIndex]} · ${event.timeRangeLabel(context)}',
              ),
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

  @override
  Widget build(BuildContext context) {
    final tablet = isTabletLayout(context);
    final grid = WeekGridView(events: _events, onEventTap: _showEventActions);

    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      appBar: _buildAppBar(),
      body: tablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TabletSidebar(events: _events, onEventAdded: _addEvent),
                Expanded(child: grid),
              ],
            )
          : grid,
      floatingActionButton: tablet
          ? null
          : FloatingActionButton(
              onPressed: () => showAddEventDialog(context, onEventAdded: _addEvent),
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 56,
      title: const Text(
        'A Better Weekly Structure',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      backgroundColor: Colors.red,
      centerTitle: true,
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
        child: ScheduleHeaderProgress(events: _events),
      ),
    );
  }
}
