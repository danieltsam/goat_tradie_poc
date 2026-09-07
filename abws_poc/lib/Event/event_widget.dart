import 'package:abws_poc/Event/event_model.dart';
import 'package:flutter/material.dart';


// Used for the display of text in the event blocks, handles cutting off 0s when they are :00
String formatEventTime(BuildContext context, TimeOfDay time) {
  if (time.minute == 0) {
    final formatted = time.format(context);
    return formatted.replaceAll(':00', '');
  }

  return time.format(context);
}

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
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  // Recalculate duration whenever the times change
                  final updatedStart = timeToDouble(model.startTime);
                  final updatedEnd = timeToDouble(model.endTime);
                  final updatedDuration = updatedEnd - updatedStart;
                  final updatedMinutes = model.endTime.minute - model.startTime.minute; // Calculated minutes of given, used for display
                  final updatedHours = model.endTime.hour - model.startTime.hour; // Calculated hours of given time, used for display

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

                        // Start Time
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? picked =
                                await showTimePicker(
                              context: context,
                              initialTime: model.startTime,
                            );

                            if (picked != null) {
                              setState(() {
                                model.startTime = picked; // When updating, you need to reload, will issue fix shortly
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Start Time: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  model.startTime.format(context),
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // End Time
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? picked =
                                await showTimePicker(
                              context: context,
                              initialTime: model.endTime,
                            );

                            if (picked != null) {
                              setState(() {
                                model.endTime = picked;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'End Time: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  model.endTime.format(context),
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                              updatedMinutes == 0
                              ? 'Duration: $updatedHours ${updatedHours == 1 ? 'hour' : 'hours'}'
                              : 'Duration: $updatedHours ${updatedHours == 1 ? 'hour' : 'hours'}, $updatedMinutes ${updatedMinutes == 1 ? 'minute' : 'minutes'}',
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
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },

        // This Container is the child of GestureDetector
        child: Container(
          height: duration * heightPerHour,
          decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '${model.shortType} \n'
              '${formatEventTime(context, model.startTime)}\n'
              '${formatEventTime(context, model.endTime)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade // Happy to change it, not sure what other options would look better
            ),
          ),
        ),
      ),
    );
  }
}

double timeToDouble(TimeOfDay myTime) {
  return myTime.hour + (myTime.minute / 60.0);
}