import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/get_verified_screen.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_congratulations_page.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_submission.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/booking_page.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/chat_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/home_page.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/screen/earning_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/share_work_page.dart';
import 'package:blinqo/features/role/service_provider/service_profile_page/screen/profile_page.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_change_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_f_otp_send_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_forget_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_opt_send_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_signup_screen.dart';
import 'package:blinqo/features/role_page/screen/role_screen.dart';
import 'package:blinqo/features/splasho_screen/screen/splasho_screen.dart';
import 'package:get/get.dart';
import '../features/role/venue_owner/overview/screen/addcard_screen.dart';

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
  static String getVerifiedScreen = "/getVerifiedScreen";
  static String spProfilePage = "/spProfilePage";
  static String getaddCard = '/getAddCard';
  static String spVerificationSubmission = '/spVerificationSubmission';
  static String spVerificationThanks = '/spVerificationThanks';
  static String spCongratulationsPage = '/spCongratulationsPage';
  static String spPaymentOption = '/spPaymentOption';
  static String spEditProfilePage = '/spEditProfilePage';
  static String spShareWorkPage = '/spShareWorkPage';
  static String eventHomeScreen = '/eventHomeScreen';

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
  static String getgetVerifiedScreen() => getVerifiedScreen;
  static String getspProfilePage() => spProfilePage;
  static String getspVerificationSubmission() => spVerificationSubmission;
  static String getspVerificationThanks() => spVerificationThanks;
  static String getspCongratulationsPage() => spCongratulationsPage;
  static String getspPaymentOption() => spPaymentOption;
  static String getspEditProfilePage() => spEditProfilePage;
  static String getspShareWorkPage() => spShareWorkPage;
  static String geteventHomeScreen() => eventHomeScreen;

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
    GetPage(name: spProfilePage, page: () => SpProfilePage()),
    GetPage(name: vloginscreen, page: () => VLoginScreen()),
    GetPage(name: vsignupscreen, page: () => VSignupScreen()),
    GetPage(name: vforgetpassword, page: () => VForgetPassword()),
    GetPage(name: vchangepassword, page: () => VChangePassword()),
    GetPage(name: votpsendscreen, page: () => VOptSendScreen()),
    GetPage(name: vfotpsendscreen, page: () => VFOtpSendScreen()),
    GetPage(name: getVerifiedScreen, page: () => GetVerifiedScreen()),
    GetPage(name: getaddCard, page: () => AddcardScreen()),
    GetPage(
      name: spVerificationSubmission,
      page: () => SpVerificationSubmission(),
    ),
    GetPage(name: spVerificationThanks, page: () => SpVerificationThanks()),
    GetPage(name: spCongratulationsPage, page: () => SpCongratulationsPage()),
    GetPage(name: spPaymentOption, page: () => SpPaymentOption()),
    GetPage(name: spEditProfilePage, page: () => SpEditProfilePage()),
    GetPage(name: spShareWorkPage, page: () => SpShareWorkPage()),
    GetPage(name: eventHomeScreen, page: () => EventHomeScreen()),
  ];
}
