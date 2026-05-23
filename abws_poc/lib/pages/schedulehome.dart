import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final List<String> weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  


class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
      
    final availableWidth = MediaQuery.of(context).size.width - 60;
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    FloatingActionButton(
      heroTag: "btn1",
      onPressed: () {},
      child: Icon(Icons.help),
    ),
    SizedBox(width: 10),
    FloatingActionButton(
      heroTag: "btn2",
      onPressed: () {},
      child: Icon(Icons.add),
    ),
    SizedBox(width: 10),
    FloatingActionButton(
      heroTag: "btn3",
      onPressed: () {},
      child: Icon(Icons.arrow_right)
    )
  ],
),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          child: Container(height: 10)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  }

  AppBar appBar() {
    return AppBar(
      title: Text('A Better Weekly Structure',
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      )
      ),
      backgroundColor: Colors.red,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {

        },
        child: Container (
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Image.asset('assets/icons/back_arrow.png',
        height: 20,
        width: 20
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10)
        ),  
      ),
      ),
      actions: [
        Container(
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 37,
        child: Image.asset('assets/icons/goat_temp.png',
        height: 20,
        width: 20
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10)
        ),  
      )
      ],
      
    );
  }
}

class AddSchedButton extends StatelessWidget {
  const AddSchedButton({super.key});

  @override
  Widget build(BuildContext context) {
    Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {}),
        bottomNavigationBar: BottomAppBar(
          color: Colors.yellow,
          child: Container(height: 50)
          ),
    );
    return Scaffold();
  }
}



