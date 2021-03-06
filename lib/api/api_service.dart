import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:eventz/api/api_client.dart';
import 'package:eventz/api/apis.dart';
import 'package:http/http.dart';

class APIService {
  static APIService _instance;

  factory APIService() => _instance ??= new APIService._();

  APIService._();

  HttpService httpService = HttpService();

  ///Check  availability of internet connection
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  ///login user to API
  Future<Response> userLogin(String email, String pw) async {
    Response setValue;
    await httpService
        .centsPostRequest(null, APIs.login + "?username=$email&password=$pw")
        .then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///get all event from API initiate
  Future<Response> getAllEvent() async {
    Response setValue;
    await httpService
        .centsPostRequest(null, APIs.allEvents, method: HttpMethod.GET)
        .then((value) {
      print("====response received====");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///get payment options from API initiate
  Future<Response> getPaymentOptions() async {
    Response setValue;
    await httpService
        .centsPostRequest(null, APIs.getPaymentOptions, method: HttpMethod.GET)
        .then((value) {
      print("====response received====");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///get all event from API initiate
  Future<Response> getMyEvent(int id) async {
    Response setValue;
    await httpService
        .centsPostRequest(null, APIs.myEvents + "?userId=$id",
            method: HttpMethod.GET)
        .then((value) {
      print("====response received====");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///Register user to API
  Future<Response> userRegister(Map<dynamic, Object> params) async {
    String nameString = jsonEncode(params);
    Response setValue;
    print('*** REQUEST **** ' + nameString);

    await httpService.centsPostRequest(params, APIs.register).then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///Save event to API
  Future<Response> saveEvent(Map<dynamic, Object> params) async {
    String nameString = jsonEncode(params);
    Response setValue;
    print('*** REQUEST **** ' + nameString);

    await httpService.centsPostRequest(params, APIs.saveEvents).then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///login user to API
  Future<Response> forgetPw(String email) async {
    Response setValue;
    await httpService
        .centsPostRequest(null, APIs.forgotPW + "?username=$email")
        .then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///login user to API
  Future<Response> forgetPwOTP(String email, String otp, String pw) async {
    Response setValue;
    await httpService
        .centsPostRequest(
            null, APIs.resetPW + "?username=$email&OTP=$otp&newPassword=$pw")
        .then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }

  ///login user to API
  Future<Response> forgetPwOTPResend(String email, String mobile) async {
    Response setValue;
    await httpService
        .centsPostRequest(
            null, APIs.resendOTP + "?username=$email&mobileNo=$mobile")
        .then((value) {
      print("response received");
      print(value);
      setValue = value;
    });

    return setValue;
  }
}
