import 'package:get/state_manager.dart';

class AppBarController extends GetxController {
  double appBarElevation = 0;

  changeElevation(double elevation) {
    appBarElevation = elevation;
    update();
  }
}
