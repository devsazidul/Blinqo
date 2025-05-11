import 'package:blinqo/features/profile/screen/pick_color_screen.dart';
import 'package:blinqo/features/profile/screen/profile_screen.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/change_password_screen.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/forget_password_screen.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/login_screen.dart';
import 'package:blinqo/features/role/event_planner/auth/screen/signup_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_home_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/event_services_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/featured_venues_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/filter_view_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/search_details_screens/screens/search_details_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/screens/venues_near_screen.dart';
import 'package:blinqo/features/role/event_planner/event_home_page/sharch_start_booking/screen/search_start_booking.dart';
import 'package:blinqo/features/role/event_planner/home/start_booking.dart';
import 'package:blinqo/features/role/event_planner/onboring/home_event_planner.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/even_payment_option.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/evetnt_congratulation_screen.dart';
import 'package:blinqo/features/role/event_planner/payment_method/screen/final_review_booking_datieals.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking.dart';
import 'package:blinqo/features/role/event_planner/review_booking/screen/review_booking_datieals.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/forget_password_verify_otp_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_change_password_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_forget_password_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_login_screen.dart';
import 'package:blinqo/features/role/service_provider/auth/screen/sp_signup_screen.dart';
import 'package:blinqo/features/role/service_provider/bottom_nav_bar/screen/sp_bottom_nav_bar.dart';
import 'package:blinqo/features/role/service_provider/onbording/screen/sp_onbording_screen.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_congratulations_page.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_get_verified_screen.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_payment_option_card.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_submission.dart';
import 'package:blinqo/features/role/service_provider/payment_page/screen/sp_verification_thanks.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/sp_booking_page.dart';
import 'package:blinqo/features/role/service_provider/service_booking_page/screen/sp_project_request.dart';
import 'package:blinqo/features/role/service_provider/service_chat_page/screen/sp_chat_page.dart';
import 'package:blinqo/features/role/service_provider/service_earning_page/screen/sp_earning_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/sp_home_page.dart';
import 'package:blinqo/features/role/service_provider/service_home_page/screen/sp_upcoming_project.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/edit_profile_page.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/profile_settings_screen.dart';
import 'package:blinqo/features/role/service_provider/sp_profile/screen/share_work_page.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_change_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_forget_password.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_login_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_opt_send_screen.dart';
import 'package:blinqo/features/role/venue_owner/authentication/screen/v_signup_screen.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/addshift.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/createshift.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/myteamedit.dart';
import 'package:blinqo/features/role/venue_owner/team/screen/teaminformation.dart';
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
  static String spHomePage = "/spHomePage";
  static String spEarningPage = "/spEarningPage";
  static String spBookingPage = "/spBookingPage";
  static String spChatPage = "/spChatPage";
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
  static String spPaymentOptionCard = '/spPaymentOptionCard';
  static String eventHomeScreen = '/eventHomeScreen';
  static String eventServicesScreen = '/eventServicesScreen';
  static String featuredVenuesScreen = '/featuredVenuesScreen';
  static String venuesNearScreen = '/venuesNearScreen';
  static String spProjectRequest = '/spProjectRequest';
  static String spUpcomingProject = '/spUpcomingProject';
  static String loginscreen = '/loginscreen';
  static String signupscreen = '/signupscreen';
  static String forgetpasswordscreen = '/forgetpasswordscreen';
  static String otpscreen = '/otpscreen';
  static String changePasswordScreen = '/changePasswordScreen';
  static String createshift = '/createShiftScreen';
  static String addShift = '/addShift';
  static String searchDetailsScreen = '/searchDetailsScreen';
  static String filterDetailsScreen = '/filterDetailsScreen';
  static String filterViewScreen = '/filterViewScreen';
  static String profile = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String pickColorScreen = "/pick_color_screen";
  static String startBooking = '/startBooking';
  static String employeeInformtaion = '/employeeInformation';
  static String myteamedit = '/myteamedit';
  static String allreview = '/allreview';
  static String reviewBooking = '/ReviewBooking';
  static String reviewBookingDetails = '/reviewBookingDetails';
  static String eventPaymentOption = '/eventPaymentOption';
  static String profileEdit = '/edit_profile_page';
  static String eventCongratulationScreen = '/eventCongratulationScreen';
  static String finalReviewBookingDatieals = '/finalReviewBookingDatieals';
  static String evenPaymentOption = '/evenPaymentOption';
  static String searchStartBooking = '/searchStartBooking';
  static String spSignupScreen = '/spSignupScreen';
  static String spLoginScreen = '/spLoginScreen';
  static String spForgetPassword = '/spForgetPassword';
  static String spFOtpSendScreen = '/spFOtpSendScreen';
  static String spChangePassword = '/spChangePassword';

  static String getsplashoScreen() => splashoScreen;
  static String gethomeEventPlanner() => homeEventPlanner;
  static String getroleScreen() => roleScreen;
  static String getprofileScreen() => profileScreen;
  static String getonbordingScreen() => onbordingScreen;
  static String getbottomNavBar() => bottomNavBar;
  static String getspHomePage() => spHomePage;
  static String getspEarningPage() => spEarningPage;
  static String getspBookingPage() => spBookingPage;
  static String getspChatPage() => spChatPage;
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
  static String getspPaymentOptionCard() => spPaymentOptionCard;
  static String geteventHomeScreen() => eventHomeScreen;
  static String geteventServicesScreen() => eventServicesScreen;
  static String getfeaturedVenuesScreen() => featuredVenuesScreen;
  static String getvenuesNearScreen() => venuesNearScreen;
  static String getspProjectRequest() => spProjectRequest;
  static String getspUpcomingProject() => spUpcomingProject;
  static String getloginscreen() => loginscreen;
  static String getsignupscreen() => signupscreen;
  static String getforgetpasswordscreen() => forgetpasswordscreen;
  static String getotpscreen() => otpscreen;
  static String getchangePasswordScreen() => changePasswordScreen;
  static String getsearchDetailsScreen() => searchDetailsScreen;
  static String getfilterDetailsScreen() => filterDetailsScreen;
  static String getfilterViewScreen() => filterViewScreen;
  static String getProfile() => profile;
  static String getEditProfileScreen() => editProfileScreen;
  static String getPickColorScreen() => pickColorScreen;
  static String getstartBooking() => startBooking;
  static String getReviewBooking() => reviewBooking;
  static String getReviewBookingDetails() => reviewBookingDetails;
  static String geteventPaymentOption() => eventPaymentOption;
  static String getprofileEdit() => profileEdit;
  static String geteventCongratulationScreen() => eventCongratulationScreen;
  static String getfinalReviewBookingDatieals() => finalReviewBookingDatieals;
  static String getevenPaymentOption() => evenPaymentOption;
  static String getsearchStartBooking() => searchStartBooking;
  static String getspSignupScreen() => spSignupScreen;
  static String getspLoginScreen() => spLoginScreen;
  static String getspForgetPassword() => spForgetPassword;
  static String getspFOtpSendScreen() => spFOtpSendScreen;
  static String getspChangePassword() => spChangePassword;

  static List<GetPage> routes = [
    GetPage(name: splashoScreen, page: () => const SplashoScreen()),
    GetPage(name: homeEventPlanner, page: () => const HomeEventPlanner()),
    GetPage(name: roleScreen, page: () => const RoleScreen()),
    GetPage(name: addShift, page: () => Addshift()),
    // GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: onbordingScreen, page: () => SpOnBoardingScreen()),
    GetPage(name: bottomNavBar, page: () => SpBottomNavBarScreen()),
    GetPage(name: spHomePage, page: () => SpHomePage()),
    GetPage(name: spEarningPage, page: () => SpEarningPage()),
    GetPage(name: spBookingPage, page: () => SpBookingPage()),
    GetPage(name: spChatPage, page: () => SpChatPage()),
    GetPage(name: spProfilePage, page: () => SpProfileSettingsScreen()),
    GetPage(name: vloginscreen, page: () => VLoginScreen()),
    GetPage(name: vsignupscreen, page: () => VSignupScreen()),
    GetPage(name: vforgetpassword, page: () => VForgetPassword()),
    GetPage(name: vchangepassword, page: () => VChangePassword()),
    GetPage(name: votpsendscreen, page: () => VOptSendScreen()),
    GetPage(name: getVerifiedScreen, page: () => SpGetVerifiedScreen()),
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
    GetPage(name: spPaymentOptionCard, page: () => SpPaymentOptionCard()),
    GetPage(name: eventHomeScreen, page: () => EventHomeScreen()),
    GetPage(name: eventServicesScreen, page: () => EventServicesScreen()),
    GetPage(name: featuredVenuesScreen, page: () => FeaturedVenuesScreen()),
    GetPage(name: venuesNearScreen, page: () => VenuesNearScreen()),
    GetPage(name: spProjectRequest, page: () => SpProjectRequest()),
    GetPage(name: spUpcomingProject, page: () => SpUpcomingProject()),
    GetPage(name: loginscreen, page: () => LogInScreen()),
    GetPage(name: signupscreen, page: () => SignUpScreen()),
    GetPage(name: forgetpasswordscreen, page: () => ForgetPasswordScreen()),
    // GetPage(name: otpscreen, page: () => OTPScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: createshift, page: () => Createshift()),
    GetPage(name: searchDetailsScreen, page: () => SearchDetailsScreen()),
    GetPage(name: filterDetailsScreen, page: () => FilterDetailsScreen()),
    GetPage(name: filterViewScreen, page: () => FilterViewScreen()),
    GetPage(name: getProfile(), page: () => MainProfileScreen()),
    GetPage(name: getEditProfileScreen(), page: () => SpEditProfilePage()),
    GetPage(name: getPickColorScreen(), page: () => PickColorScreen()),
    GetPage(name: createshift, page: () => Createshift()),
    GetPage(name: employeeInformtaion, page: () => EmployeeInformation()),
    GetPage(
      name: myteamedit,
      page: () => Myteamedit(index: Get.arguments as int),
    ),
    GetPage(name: startBooking, page: () => StartBooking()),
    GetPage(name: reviewBooking, page: () => ReviewBooking()),
    GetPage(name: reviewBookingDetails, page: () => ReviewBookingDetails()),
    GetPage(name: eventPaymentOption, page: () => EvenPaymentOption()),
    GetPage(
      name: eventCongratulationScreen,
      page: () => EventCongratulationScreen(),
    ),
    GetPage(
      name: finalReviewBookingDatieals,
      page: () => FinalReviewBookingDatieals(),
    ),
    GetPage(name: evenPaymentOption, page: () => EvenPaymentOption()),
    GetPage(name: searchStartBooking, page: () => SearchStartBooking()),
    GetPage(name: spSignupScreen, page: () => SpSignupScreen()),
    GetPage(name: spLoginScreen, page: () => SpLoginScreen()),
    GetPage(name: spForgetPassword, page: () => SpForgetPasswordScreen()),
    GetPage(
      name: spFOtpSendScreen,
      page:
          () => SpForgetPasswordVerifyOtpScreen(email: Get.arguments as String),
    ),
    GetPage(
      name: spChangePassword,
      page:
          () => SpChangePasswordScreen(
            email: Get.arguments as String,
            otp: Get.arguments as String,
          ),
    ),
  ];
}
