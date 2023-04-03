import 'package:eventz/utils/constants.dart';
import 'package:eventz/utils/helper.dart';
import 'package:eventz/utils/shared_storage.dart';
import 'package:eventz/view/dashboard/dashboard.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupView extends StatefulWidget {
  static const routeName = '/';

  @override
  _StartupViewState createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  Helper _helper = Helper();
  SharedPref _sharedPref = SharedPref();

  @override
  void initState() {
    checkSessionStatus();
    super.initState();
  }

  checkSessionStatus() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      if (await _sharedPref.check(ShardPrefKey.SESSION_TOKEN)) {
        Get.off(DashBoard());
      } else {
        Get.off(LoginView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/eventz-logo.png"),
                  fit: BoxFit.contain)),
        ),
      ),
    );
  }
}
