import 'package:flutter/material.dart';
import '../scheduleWidgets/schedulewidgets.dart';

void _showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: TextStyle(fontFamily: 'Inter', color: Colors.black, ),
        // contentTextStyle: TextStyle(fontFamily: 'Inter', color: Colors.black), Currently unused, same formatting as title
        title: Text(('Add Personal Time'), textAlign: TextAlign.center),
        // content: TimePickerDialog(initialTime: TimeOfDay.now()), Currently not working, too big I think
        // TODO: Fix that and implement,
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[     
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop(); // Closes the dialog
            },
          ),
        ],
      );
    },
  );
}

class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Header
      appBar: appBar(),
      
      // body
      body: const WeeklyScheduleBody(),
        
      //Footer
      floatingActionButton: floatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'A Better Weekly Structure',
        style: TextStyle(color: Colors.black, fontSize: 18),
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

  //Contains the footers buttons.
  Widget floatingActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.help),
        ),

        const SizedBox(width: 10),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: (){
          _showMyDialog(context);
          },
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),

        const SizedBox(width: 10),
        FloatingActionButton(
          heroTag: "btn3",
          onPressed: () {},
          foregroundColor: Colors.black,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_right),
        ),
      ],
    );
  }

}

