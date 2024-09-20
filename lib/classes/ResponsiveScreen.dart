// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart' show BuildContext, MediaQuery;

class ResponsiveScreen {
  static late double screen_width;
  static late double screen_height;

  static void initializeScreen(BuildContext context) {
    screen_width = MediaQuery.of(context).size.width;
    screen_height = MediaQuery.of(context).size.height;
  }
}