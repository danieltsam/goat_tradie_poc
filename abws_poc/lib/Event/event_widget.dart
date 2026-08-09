import 'package:abws_poc/Event/schedule_event.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
    required this.heightPerHour,
  });

  final ScheduleEvent event; //The type of event this widget is
  final double heightPerHour; //The calculated height this widget will be so it is proportional to the height of the day.

  @override
  Widget build(BuildContext context) {
    
    final start = timeToDouble(event.startTime);
    final end = timeToDouble(event.endTime);
    final duration = end - start;

    return Positioned(
      top: start * heightPerHour,
      left: 4,
      right: 4,
        
      child: Container(
        height: duration * heightPerHour,
        decoration: BoxDecoration(
          color: event.color, // Uses the color from the ScheduleEvent object
          borderRadius: BorderRadius.circular(8),
        ),
        
        child: Center(
          child: Text(
            "${event.eventType} ${event.startTime.format(context)} - ${event.endTime.format(context)}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        
      ),
    );
  }
}

double timeToDouble(TimeOfDay myTime) {
  return myTime.hour + (myTime.minute / 60.0);
}