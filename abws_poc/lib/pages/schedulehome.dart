import 'package:flutter/material.dart';

class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Better Weekly Structure',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal
        )
        ),
        backgroundColor: Colors.red,
        elevation: 0.0,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10)
          ),
        )
      )
    );
  }
}
