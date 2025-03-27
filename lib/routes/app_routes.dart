import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashoScreen = "/splashoScreen";

  static String getsplashoScreen() => splashoScreen;

  static List<GetPage> routes = [
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
  ];
}
