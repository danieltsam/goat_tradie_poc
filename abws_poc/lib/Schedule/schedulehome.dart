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
              child: _DayColumn(
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

class _DayColumn extends StatelessWidget {
  final String day;
  final bool isLast;
  final List<EventModel> events;

  const _DayColumn({
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
                    : BorderSide(
                        color: Colors.black.withOpacity(0.5),
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

/// Redundant, replaced by EventModel, not removed for backup purposes
class ScheduleBlock {
  final String day;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const ScheduleBlock({
    required this.day,
    required this.startTime,
    required this.endTime,
  });
}

Future<EventModel?> _showAddSchedule(
    BuildContext context, int currentStep) async {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String? selectedDay = 'Mon';

  return await showDialog<EventModel>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              "Add ${eventTypes[currentStep].name} Time",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    "Start Time: ${startTime.format(context)}",
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );

                    if (picked != null) {setState(() => startTime = picked);
                    }
                  },
                ),

                ListTile(
                  title: Text(
                    "End Time: ${endTime.format(context)}",
                  ),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) {setState(() => endTime = picked);
                    }
                  },
                ),

                const SizedBox(height: 20),

                DropdownButton<String>(
                  value: selectedDay,
                  isExpanded: true,
                  items: WeeklyScheduleBody.days
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => selectedDay = newValue);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(context),
                child: const Text('Cancel'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    EventModel(
                      id: 'Sample',
                      eventType: eventTypes[currentStep].name,
                      day: selectedDay!,
                      startTime: startTime,
                      endTime: endTime,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    },
  );
}

class ScheduleHomePage extends StatefulWidget {
  const ScheduleHomePage({super.key});

  @override
  State<ScheduleHomePage> createState() =>
      _ScheduleHomePageState();
}

class _ScheduleHomePageState
    extends State<ScheduleHomePage> {

  int _stepTracker = 0;
  final List<EventModel> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Header
      appBar: appBar(),

      // body
      body: Column(
        children: [
          WeeklyScheduleBody(events: events),
        ],
      ),

      floatingActionButton: floatingActionButton(context),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'A Better Weekly Structure',
        style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'HighVoltage'),
      ),
      backgroundColor: Colors.red,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/back_arrow.png',
            height: 20,
            width: 20,
          ),
        ),
      ),

      //Comtains the GOAT profile button
      //the "actions" section is a special property of the appBar widget for things like your profile icon or notifications icon
      actions: [
        Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/icons/goat_temp.png',
            height: 20,
            width: 20,
          ),
        ),
      ],

      //Contains the legend and step count
      //the "bottom" property of the appBar wiget is a special little property that takes a PrefferedSize widget. the PS widget can be set to a custom height and we can put other things in it. these other things are also part of the header bc theyre in the appBar widget

      //To Note:
      //The fromHeight variable is responsible for adjusting the entire appBar height and will scale everything upwards to fit.
      //The height variable is the position of the upper bound of the PrefferedSize widget, it will also scale the contents of the PS widget AND the appBar widget (the text and buttons)
      //Its kinda funky but just mess with changing the numbers and see what happens
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          height: 90.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),

          child: Row(
            children: [
              //The step count square
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(child: Text('Step ${_stepTracker+1} of 12',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
                ),
              ),

              //A box for padding
              const SizedBox(
                width: 15,
              ), // Add a little gap between the square and the text

              //The progress bar and legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    //The progress bar
                    Expanded(
                      flex: 3,
                      child: Container(
                        //color: Colors.blue, // Placeholder for top box
                        padding: const EdgeInsets.all(5.0), // Creates the inset space
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity, // Spans the full inset width
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                    
                    //The legend
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: Colors.green, // Placeholder for bottom box
                        alignment: Alignment.center,
                        child: const Text(
                          'legend box',
                          style: TextStyle(color: Colors.white),
                        ),
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

  Widget floatingActionButton(
      BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Information'),
            content: const Text('Placeholder'), // Include, What is ABWS, How to use, and why can't I put work first?
            actions: [
              TextButton(
                onPressed: () {
                  // Perform your action here
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    },
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.help),
        ),

        const SizedBox(width: 10),

        FloatingActionButton(
          heroTag: "btn2",
          onPressed: () async {

            final newEvent = await _showAddSchedule(context, _stepTracker);

            if (newEvent != null) {
              setState(() {
                events.add(newEvent);
              });
            }
          },
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),

        const SizedBox(width: 10),

        FloatingActionButton(
          heroTag: "btn3",
          onPressed: () {
            if (_stepTracker < eventTypes.length - 1) {
              setState(() => _stepTracker++);
            }
          },
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }
}