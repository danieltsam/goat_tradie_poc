import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        )
        ),
        backgroundColor: Colors.red,
        elevation: 0.0,
        centerTitle: true,
        leading: Container(
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
        ]
      )
    );
  }
}
