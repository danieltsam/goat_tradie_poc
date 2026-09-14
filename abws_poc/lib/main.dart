import 'package:abws_poc/Schedule/schedule_widget.dart';
import 'package:abws_poc/Schedule/scheduleTabhome.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: const ScheduleTabHomePage(), // For testing, I chnaged this to launch the Tablet view, 
      // For mobile view, const ScheduleHomePage() should be used instead.
    );
  }
} 
