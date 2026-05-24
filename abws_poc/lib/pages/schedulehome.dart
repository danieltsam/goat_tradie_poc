import 'package:flutter/material.dart';

final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Header
      appBar: appBar(),

      //Footer
      floatingActionButton: floatingActionButton(),
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
      bottom: PreferredSize(
        // Adjust this height based on how much content you need to fit
        preferredSize: const Size.fromHeight(100.0), 
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Extra Header Information Here', style: TextStyle(color: Colors.white, fontSize: 16)),
              // Add your extra information widgets here!
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingActionButton() {
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
          onPressed: () {},
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
