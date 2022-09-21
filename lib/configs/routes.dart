import 'package:eventz/view/dashboard/dashboard.dart';
import 'package:eventz/view/dashboard/event_details.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/myEvent/my_event.dart';
import 'package:eventz/view/myEvent/my_event_details.dart';
import 'package:eventz/view/myEvent/my_event_qr_code.dart';
import 'package:get/get.dart';

class Routers {
  static final route = [
    GetPage(
      name: LoginView.routeName,
      page: () => LoginView(),
    ),
    GetPage(
      name: DashBoard.routeName,
      page: () => DashBoard(),
    ),
    GetPage(
      name: EventDetails.routeName,
      page: () => EventDetails(),
    ),
    GetPage(
      name: MyEventView.routeName,
      page: () => MyEventView(),
    ),
    GetPage(
      name: MyEventDetailsView.routeName,
      page: () => MyEventDetailsView(),
    ),
    GetPage(
      name: MyEventQRView.routeName,
      page: () => MyEventQRView(),
    ),
  ];
}
