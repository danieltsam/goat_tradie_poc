import 'package:abws_poc/Event/event_model.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.model,
    required this.heightPerHour,

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
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Event Details'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day: ${model.day}',
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Activity Type: ${model.eventType}',
                    ),
                    const SizedBox(height: 8),

                    //Start Time
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? newStartTime =
                            await showTimePicker(
                          context: context,
                          initialTime: model.startTime,
                        );
                        // Currently doesn't let you edit the time, using SetState() I think it will automatically update the duration / height
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),

                        child: Row(
                          children: [
                            const Text(
                              'Start Time: ',
                              style: TextStyle(fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              model.startTime.format(context),
                              style: const TextStyle(decoration: TextDecoration.underline,
                              ),
                            ),

                            const SizedBox(width: 8),
                            const Icon(Icons.access_time, size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // End Time
                     InkWell(
                      onTap: () async {
                        final TimeOfDay? newEndTime =
                            await showTimePicker(
                          context: context,
                          initialTime: model.endTime,
                        );
                      // Currently doesn't let you edit the time, using SetState() I think it will automatically update the duration / height
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric( vertical: 8,
                        ),

                        child: Row(
                          children: [
                            const Text(
                              'End Time: ',
                              style: TextStyle( fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              model.endTime.format(context),
                              style: const TextStyle(decoration: TextDecoration.underline,
                              ),
                            ),

                            const SizedBox(width: 8),
                            const Icon(Icons.access_time, size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Text(
                      'Duration: ${duration.toStringAsFixed(1)} hours',
                    ),
                  ],
                ),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Add delete functionality here
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        
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
      )
    );
  }
}

double timeToDouble(TimeOfDay myTime) {
  return myTime.hour + (myTime.minute / 60.0);
}