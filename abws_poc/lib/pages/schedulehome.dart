import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleHomePage extends StatelessWidget {
  const ScheduleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar()
    );
  }





  AppBar appBar() {
    return AppBar(
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

      leading: GestureDetector(
        onTap: () {
          // Add your action here, for example navigating back:
          // Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10)
          ),
          child: SvgPicture.asset(
            'assets/icons/left-arrow-svgrepo-com.svg',
            height: 25,
            width: 25,
          ),
        ),
      ),
    );
  }


}
