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
  static const String getPaymentOptions =
      "$BASE_URL$apiVersion/Paymode/LoadPaymode";
  static const String myEvents =
      "$BASE_URL$apiVersion/EventEnroll/LoadMyEvents";
  static const String saveEvents = "$BASE_URL$apiVersion/EventEnroll/SaveEvent";
}
