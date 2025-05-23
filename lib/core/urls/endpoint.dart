class Urls {
  // static const String baseUrl = 'https://udode-backend.vercel.app/api/v1';
  // static const String baseUrl = 'https://sports-app-hpbg.onrender.com';
  // static const String baseUrl = 'https://sports-app-dvka.onrender.com';
  // static const String baseUrl = 'https://sports-app-y7lq.onrender.com';
  static const String baseUrl = 'https://freepik.softvenceomega.com';

  // Auth urls
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
  static const String plannerprofilesetup = '$baseUrl/profile/planner-setup';
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

  static String updatePlannerProfile =
      '$baseUrl/profile/planner-profile-update';

  static String getServiceProviderProfile =
      '$baseUrl/profile/get-service-provider-profiles';

  static const String getUserInfo = '$baseUrl/auth/user-info';
  static const String eventDecorationEnum = '$baseUrl/booking/decoration_enum';
  static const String eventAmenities = '$baseUrl/amenities/get-all-amenities';
  static const String createAmenity = '$baseUrl/amenities/create-amenity';
  static const String venueCreate = '$baseUrl/venue/create';

  static const String sendVerificationRequest =
      '$baseUrl/profile-verification/send-verification-request';

  static String venueProfileUpdate(String id) =>
      '$baseUrl/profile/venue-owner-profile-update/$id';

  static String getVenue(String id) => '$baseUrl/venue/get/$id';

  static String updateVenue(String? id) => '$baseUrl/venue/update/$id';
  static String getAllVenue = '$baseUrl/venue/get-all-by-venue-owner';

  // Payment urls
  static String createPaymentIntent = '$baseUrl/billing/create-payment-intent';

  // -----------------------Service Provider urls-----------------------
  static String getServiceProviderTypes = '$baseUrl/service-provider-type/get';

  static String updateServiceProviderProfile =
      '$baseUrl/profile/service-provider-profile-update';

  static String workShowcase = '$baseUrl/works/create-work-showcase';
  static String getAllWorks = '$baseUrl/works/get-all-by-service-provider';

  static String getWorkDetailsByWorkId(String id) => '$baseUrl/works/get/$id';
  static String getAllWorksByProfileId(String id) =>
      '$baseUrl/works/get-all/$id';

  static String getVenueOwnerHome = '$baseUrl/venue/venue-owner-home';
  static String getAllUpcomingBookings =
      '$baseUrl/booking/get-all-venue-owner-bookings';
  static String getAllRecentReviews = '$baseUrl/review/get-all/venue-owner';
  // ------------------------------------------------------------------------

  // -----------------------Venue Owner Shifts-----------------------
  static String getAllShifts(String venueId) => '$baseUrl/shift/all/$venueId';
  static String createShift = '$baseUrl/shift/create';
  static String getSingleShift(String id) => '$baseUrl/shift/$id';
  static String updateShift(String id) => '$baseUrl/shift/update/$id';
  static String deleteShift(String id) => '$baseUrl/shift/delete/$id';
  // ------------------------------------------------------------------------

  // -----------------------Venue Owner Employees-----------------------
  static String getAllEmployees = '$baseUrl/employees/all';
  static String createEmployee = '$baseUrl/employees/create';
  static String getSingleEmployee(String id) => '$baseUrl/employees/$id';
  static String updateEmployee(String id) => '$baseUrl/employees/update/$id';
  static String deleteEmployee(String id) => '$baseUrl/employees/$id';
  // ------------------------------------------------------------------------

  //-----------------------Event Planner -----------------------
  static String getEventPlannerHomeData = '$baseUrl/venue/planner-home';
  //------------------------------------------------------------------------
  //------------------------Review urls-----------------------
  static String getAllReviewsByVenue(String venueId) =>
      '$baseUrl/review/get-all/venue/$venueId';

  // get all bookings by venue owner
  static String getAllBookingsByVenueOwner = '$baseUrl/booking/list';
}
