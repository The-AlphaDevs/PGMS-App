import 'package:flutter/material.dart';

final Map<String, Color> COMPLAINT_STATUS_COLOR_MAP = {
  'Pending': Colors.orange[400],
  'Rejected': Colors.red,
  'In Progress': Colors.blue,
  'Resolved': Colors.green,
  'Closed': Colors.green[900],
  'Issue Raised': Colors.purple[400],
};

const DARK_PURPLE = Color(0xFF322144);
const GOLDEN_YELLOW = Color(0xFFFFCA28);
final SILVER_GREY = Colors.grey[300];
final BRONZE_BROWN = Colors.orange[400];
const DARK_BLUE = Color(0xFF181D3D);

final SHIMMER_BASE_COLOR = Colors.grey[300];
final SHIMMER_HIGHLIGHT_COLOR = Colors.grey[100];
List<Color> donutChartColorList = [
  Colors.green,
  Colors.orange,
  Colors.pink,
];
