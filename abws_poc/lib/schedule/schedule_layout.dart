import 'package:flutter/material.dart';

/// Screen width at or above this value uses the tablet layout (sidebar + grid).
const double tabletBreakpoint = 600;

bool isTabletLayout(BuildContext context) {
  return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
}
