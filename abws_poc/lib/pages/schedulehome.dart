import 'package:flutter/material.dart';

final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {},
            child: const Icon(Icons.help),
          ),

          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {},
            child: const Icon(Icons.add),
          ),

          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {},
            child: const Icon(Icons.arrow_right),
          ),
        ],
      ),

      bottomNavigationBar: const BottomAppBar(
        color: Colors.transparent,
        child: SizedBox(height: 10),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }
}
