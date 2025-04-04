import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashoScreen = "/splashoScreen";
  static String homeEventPlanner = "/homeEventPlanner";
  static String roleScreen = "/roleScreen";

  static String getsplashoScreen() => splashoScreen;
  static String getroleScreen() => roleScreen;

  static List<GetPage> routes = [
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
    GetPage(name: homeEventPlanner, page: () => const HomeEventPlanner()),
    GetPage(name: roleScreen, page: () => const RoleScreen()),
  ];
}
