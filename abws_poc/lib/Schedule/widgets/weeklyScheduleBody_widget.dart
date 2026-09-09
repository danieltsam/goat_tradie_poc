import 'package:flutter/material.dart';
import 'package:abws_poc/Event/event_model.dart';
import 'package:abws_poc/Event/event_widget.dart';

class WeeklyScheduleBody extends StatelessWidget {
  const WeeklyScheduleBody({
    super.key,
    required this.events,
  });

  static const List<String> days = [
    'Mon',
    'Tues',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  final List<EventModel> events;

  // Creates the white background of the weekly structure, generates it based on length of days
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            days.length,
            (index) => Expanded(
              child: DayColumnWidget(
                day: days[index],
                isLast: index == days.length - 1,
                events: events
                    .where((event) => event.day == days[index])
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DayColumnWidget extends StatelessWidget {
  final String day;
  final bool isLast;
  final List<EventModel> events;

  const DayColumnWidget({
    super.key,
    required this.day,
    required this.isLast,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context); // Shorthand saves from writing whole thing

    final screenHeight = mediaQuery.size.height;
    final paddingTop = mediaQuery.padding.top;
    final appBarHeight = kToolbarHeight;

    final usableHeight = screenHeight - paddingTop - appBarHeight - 140;

    final heightPerHour = usableHeight / 24.0;

    // This column is responsible for the headings above the rows (of the day name)
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
            vertical: 8,
          ),
          child: Container(
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              day.substring(0, 3),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: isLast
                    ? BorderSide.none
                    : const BorderSide(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        width: 1,
                      ),
              ),
            ),
            child: Stack(
              children: events
                  .map((event) => EventWidget(
                        model: event,
                        heightPerHour: heightPerHour,
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
