import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/profile_setup_page/screeen/profile_screen.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/booking_page.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/chat_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/home_page.dart';
import 'package:blinqo/features/role/service_provider/servide_earning_page/screen/earning_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/home_page.dart';
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
  static String bottomNavBar = "/bottomNavBar";
  static String homePage = "/homePage";
  static String earningPage = "/earningPage";
  static String bookingPage = "/bookingPage";
  static String chatPage = "/chatPage";
  static String profilePage = "/profilePage";
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
  static String getbottomNavBar() => bottomNavBar;
  static String gethomePage() => homePage;
  static String getearningPage() => earningPage;
  static String getbookingPage() => bookingPage;
  static String getchatPage() => chatPage;
  static String getprofilePage() => profilePage;
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
    // GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: onbordingScreen, page: () => OnbordingScreen()),
    GetPage(name: bottomNavBar, page: () => BottomNavBar()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: earningPage, page: () => EarningPage()),
    GetPage(name: bookingPage, page: () => BookingPage()),
    GetPage(name: chatPage, page: () => ChatPage()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    GetPage(name: vloginscreen, page: () => VLoginScreen()),
    GetPage(name: vsignupscreen, page: () => VSignupScreen()),
    GetPage(name: vforgetpassword, page: () => VForgetPassword()),
    GetPage(name: vchangepassword, page: () => VChangePassword()),
    GetPage(name: votpsendscreen, page: () => VOptSendScreen()),
    GetPage(name: vfotpsendscreen, page: () => VFOtpSendScreen()),
  ];
}
