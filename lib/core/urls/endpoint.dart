class Urls {
  // static const String baseUrl = 'https://udode-backend.vercel.app/api/v1';
  // static const String baseUrl = 'https://sports-app-hpbg.onrender.com';
  // static const String baseUrl = 'https://sports-app-dvka.onrender.com';
  // static const String baseUrl = 'https://sports-app-y7lq.onrender.com';
  static const String baseUrl = 'https://freepik.softvenceomega.com';
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String otpVerification = '$baseUrl/auth/verify-email';
  static const String verifyEmail = '$baseUrl/auth/verify-email';
  static const String sendPasswordResetCode =
      '$baseUrl/auth/send-password-reset-code';
  static const String verifyResetCode = '$baseUrl/auth/verify-reset-code';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String passwordReset = '$baseUrl/auth/send-password-reset-code';
  static const String verifyResetCode1 = '$baseUrl/auth/verify-reset-code';
  static const String resetPassword1 = '$baseUrl/auth/reset-password';
  static const String resendVerificationCode =
      '$baseUrl/auth/resend-verification-code';
  static const String resendPasswordResetCode =
      '$baseUrl/auth/send-password-reset-code';

  static const String getEventPreference = '$baseUrl/event-preference/get';

  static const String serviceProviderProfileSetup =
      '$baseUrl/profile/service-provider-setup';

  static const String venueOwnerSetupProfile =
      '$baseUrl/profile/venue-owner-setup';

  static const String uploadServiceProviderProfile =
      '$baseUrl/profile/service-provider-setup';

  static String updateServiceProviderProfile(String id) =>
      '$baseUrl/profile/service-provider-profile-update/$id';

  static const String getUserInfo = '$baseUrl/auth/user-info';
  static const String eventDecorationEnum = '$baseUrl/booking/decoration_enum';
  static const String eventAmenities = '$baseUrl/amenities/get-all-amenities';
  static const String createAmenity = '$baseUrl/amenities/create-amenity';
  static const String venueCreate = '$baseUrl/venue/create';
  static const String sendVerificationRequest =
      '$baseUrl/profile-verification/send-verification-request';


}
