import 'package:flutter/material.dart';

class ScheduleCategory {
  const ScheduleCategory({
    required this.id,
    required this.name,
    required this.color,
    this.recommendedHours,
  });

  final String id;
  final String name;
  final Color color;
  final int? recommendedHours;
}

/// Life-area categories shown in the tablet sidebar.
const List<ScheduleCategory> scheduleCategories = [
  ScheduleCategory(id: 'health', name: 'Health', color: Color(0xFF7CB342), recommendedHours: 3),
  ScheduleCategory(id: 'friends', name: 'Friends', color: Color(0xFFE91E8C)),
  ScheduleCategory(id: 'spiritual', name: 'Spiritual', color: Color(0xFFCDDC39)),
  ScheduleCategory(id: 'cultural', name: 'Cultural', color: Color(0xFF00BCD4)),
  ScheduleCategory(id: 'family', name: 'Family', color: Color(0xFF4FC3F7)),
  ScheduleCategory(id: 'personal', name: 'Personal', color: Color(0xFF1565C0)),
  ScheduleCategory(id: 'community', name: 'Community', color: Color(0xFFFF9800)),
  ScheduleCategory(id: 'travel', name: 'Travel', color: Color(0xFF5C6BC0)),
  ScheduleCategory(id: 'admin', name: 'Admin', color: Color(0xFFFFEB3B)),
  ScheduleCategory(id: 'marketing', name: 'Marketing', color: Color(0xFFD81B60)),
  ScheduleCategory(id: 'financial', name: 'Financial', color: Color(0xFF9E9E9E)),
  ScheduleCategory(id: 'on_the_tools', name: 'On the Tools', color: Color(0xFFCE93D8)),
];

ScheduleCategory categoryById(String id) {
  return scheduleCategories.firstWhere((c) => c.id == id);
}

/// Guided onboarding steps (Step 1 = Health, etc.).
const List<String> guidedStepCategoryIds = [
  'health',
  'friends',
  'spiritual',
  'cultural',
  'family',
  'personal',
  'community',
  'travel',
  'admin',
  'marketing',
  'financial',
  'on_the_tools',
];
