class APIs {
  static const String BASE_URL = "http://eventzlk.somee.com";

  static const String apiVersion = "/api";
  static const String register = "$BASE_URL$apiVersion/User/SaveUser";
  static const String login = "$BASE_URL$apiVersion/User/ValidateUser";
  static const String forgotPW = "$BASE_URL$apiVersion/User/ForgotPWRequest";
  static const String resetPW = "$BASE_URL$apiVersion/User/ResetPassword";
  static const String resendOTP = "$BASE_URL$apiVersion/User/ReSendOTP";
  // static const String login = "$BASE_URL$apiVersion/User/ReSendOTP";
  static const String allEvents = "$BASE_URL$apiVersion/Event/LoadAllEvents";
  static const String getAllEventsCreatedByHost = "$BASE_URL$apiVersion/Event/LoadEventByHostId";
  static const String updateProfile = "$BASE_URL$apiVersion/User/UpdateUser";
  static const String changePassword = "$BASE_URL$apiVersion/User/ChangePassword";
  static const String hostRegistration = "$BASE_URL$apiVersion/Host/SaveHost";
  static const String loadCountries = "$BASE_URL$apiVersion/Country/LoadCountry";
  static const String loadHosts = "$BASE_URL$apiVersion/Host/LoadHostfromUserId";
  static const String loadVenues = "$BASE_URL$apiVersion/EventVenue/LoadVenues";
  static const String getPaymentOptions = "$BASE_URL$apiVersion/Paymode/LoadPaymode";
  static const String myEvents = "$BASE_URL$apiVersion/EventEnroll/LoadMyEvents";
  static const String getUserProfile = "$BASE_URL$apiVersion/User/GetSelectedUser";
  static const String saveEvents = "$BASE_URL$apiVersion/Event/SaveEvent";

  static const String updateEvents = "$BASE_URL$apiVersion/Event/UpdateEvent";
}
