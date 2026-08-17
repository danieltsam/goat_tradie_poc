import 'package:abws_poc/Event/event_model.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.model,
    required this.heightPerHour,
  });

  final EventModel model; //The data model for this widget
  final double heightPerHour; //The calculated height this widget will be so it is proportional to the height of the day.

  @override
  Widget build(BuildContext context) {
    
    final start = timeToDouble(model.startTime);
    final end = timeToDouble(model.endTime);
    final duration = end - start;

    return Positioned(
      top: start * heightPerHour,
      left: 4,
      right: 4,
        
      child: Container(
        height: duration * heightPerHour,
        decoration: BoxDecoration(
          color: model.color, // Uses the color from the EventModel object
          borderRadius: BorderRadius.circular(8),
        ),
        
        child: Center(
          child: Text(
            "${model.eventType} ${model.startTime.format(context)} - ${model.endTime.format(context)}",
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