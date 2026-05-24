import 'package:flutter/material.dart';

class WeeklyScheduleBody extends StatelessWidget {
  const WeeklyScheduleBody({super.key}); // The key is meant for preserving state, which will be important when we start to add stuff to the schedule 

  static const List<String> days = [
    'Mon',
    'Tues',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Repeating 7 times, I know we'll probs want to change this code for the full, but Miles did mention wanting to view less days at a time for mobile
          children: List.generate(
            days.length,
            (index) => Expanded(
              child: _DayColumn(
                day: days[index],
                isLast: index == days.length - 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DayColumn extends StatelessWidget {
  final String day;
  final bool isLast;

  const _DayColumn({
    required this.day,
    required this.isLast,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Day label
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
              day,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                
              ),
            ),
          ),
        ),

        // Schedule column
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: isLast
                    ? BorderSide.none
                    : BorderSide(
                        color: Colors.black.withValues(alpha: 0.5),
                        width: 1,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}