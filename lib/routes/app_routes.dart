import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_page/screeen/profile_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_change_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_f_otp_send_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_forget_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_opt_send_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_signup_screen.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static String splashoScreen = "/splashoScreen";
  static String homeEventPlanner = "/homeEventPlanner";
  static String roleScreen = "/roleScreen";
  static String profileScreen = "/profileScreen";
  static String onbordingScreen = "/onbordingScreen";
  static String vloginscreen = "/vloginscreen";
  static String vsignupscreen = "/vsignupscreen";
  static String vforgetpassword = "/Vforgetpassword";
  static String vchangepassword = "/vchangepassword";
  static String votpsendscreen = "/votpsendscreen";
  static String vfotpsendscreen = "/vfotpsendscreen";

  static String getsplashoScreen() => splashoScreen;
  static String gethomeEventPlanner() => homeEventPlanner;
  static String getroleScreen() => roleScreen;
  static String getprofileScreen() => profileScreen;
  static String getonbordingScreen() => onbordingScreen;
  static String getvloginscreen() => vloginscreen;
  static String getvsignupscreen() => vsignupscreen;
  static String getvforgetpassword() => vforgetpassword;
  static String getvchangepassword() => vchangepassword;
  static String getvotpsendscreen() => votpsendscreen;
  static String getvfotpsendscreen() => vfotpsendscreen;

  static List<GetPage> routes = [
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
    GetPage(name: homeEventPlanner, page: () => const HomeEventPlanner()),
    GetPage(name: roleScreen, page: () => const RoleScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: onbordingScreen, page: () => OnbordingScreen()),
    GetPage(name: vloginscreen, page: () => VLoginScreen()),
    GetPage(name: vsignupscreen, page: () => VSignupScreen()),
    GetPage(name: vforgetpassword, page: () => VForgetPassword()),
    GetPage(name: vchangepassword, page: () => VChangePassword()),
    GetPage(name: votpsendscreen, page: () => VOptSendScreen()),
    GetPage(name: vfotpsendscreen, page: () => VFOtpSendScreen()),

  ];
}
