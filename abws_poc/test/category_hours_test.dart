import 'package:abws_poc/models/schedule_event.dart';
import 'package:abws_poc/schedule/category_hours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('progress slot fill is scheduled divided by recommended', () {
    final event = ScheduleEvent(
      id: '1',
      title: 'Health',
      categoryId: 'health',
      dayIndex: 0,
      startTime: TimeOfDay(hour: 9, minute: 0),
      endTime: TimeOfDay(hour: 10, minute: 0),
    );

    final healthSlot = categoryProgressSlots([event]).first;

    expect(healthSlot.category.id, 'health');
    expect(healthSlot.recommendedHours, 3);
    expect(healthSlot.scheduledHours, 1);
    expect(healthSlot.fillFraction, closeTo(1 / 3, 0.001));
  });
}
