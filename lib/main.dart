import 'package:blinqo/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/theme/custom_themes/text_theme.dart';

void main() {
  Get.put(ThemeController());
  runApp(const Blinqo());
}
