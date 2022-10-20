import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static HttpService _instance;

  factory HttpService() => _instance ??= new HttpService._();

  HttpService._();

  Future<http.Response> centsPostRequest(
      // Future<Map<dynamic, dynamic>> centsPostRequest(
      Map<dynamic, Object> params,
      String path,
      {HttpMethod method}) async {
    String errorMessage;
    // Map<dynamic, dynamic> params;

    print(path);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    http.Response response;
    if (method == null) {
      response = await http.post(
        path,
        headers: headers,
        body: jsonEncode(params),
      );
    } else if (method == HttpMethod.POST) {
      response = await http.post(
        path,
        headers: headers,
        body: jsonEncode(params),
      );
    } else if (method == HttpMethod.GET) {
      response = await http.get(
        path,
        headers: headers,
      );
    }

    print(response.statusCode);
    print(response.body);

    return response;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var res = json.decode(response.body);
        var responseJson = json.decode(response.body.toString());

        return res;
      case 201:
        var res = json.decode(response.body);
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return res;
      // case 400:
      //   throw BadRequestException(response.body.toString());
      // case 401:
      //   print("response.request.url.path");
      //   print(response.request.url.path);
      //   //Get.dialog(Text('djjdjd'), );
      //
      //   if (response.request.url.path != "/api/v1/passwords/validate_pin" &&
      //       globals.isSessionTimeout == false) {
      //     globals.isSessionTimeout = true;
      //
      //     // Navigator.pop(Get.overlayContext,Get.dialog(
      //     //   SessionTimeoutAlert(),
      //     // ));
      //
      //     // Navigator.of(Get.context, rootNavigator: true).pop();
      //     // sleep(const Duration(seconds: 5));
      //     //Get.back();
      //     Get.offAll(LoginWithPinView(), arguments: 'sessiontimeout');
      //   }
      //
      //   var res = centsReadResponse(json.decode(response.body));
      //   var responseJson = json.decode(response.body.toString());
      //   print(responseJson['message']);
      //   print(responseJson);
      //   return res;
      // case 403:
      //   if (response.body != null) {
      //     var res = centsReadResponse(json.decode(response.body));
      //     return res;
      //   } else {
      //     var res = {"message": "exception".tr, "success": false};
      //     return res;
      //   }
      //   throw UnauthorisedException(response.body.toString());
      // case 422:
      //   var res = centsReadResponse(json.decode(response.body)).then((value) {
      //     if (Navigator.canPop(helper.context)) {
      //       Navigator.pop(helper.context);
      //     }
      //     BasicResponseModel responseData = BasicResponseModel.fromJson(value);
      //     Get.dialog(helper.showAlertView(
      //         helper.context, responseData.message, () {}, 'ok'.tr));
      //   });
      //   return res;
      // case 500:
      default:
        var res = {"message": "exception".tr, "success": false};
        return res;
    }
  }
}

enum HttpMethod { GET, POST }
