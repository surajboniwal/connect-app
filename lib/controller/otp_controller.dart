import 'dart:math';

import 'package:get/state_manager.dart';
import 'package:dio/dio.dart';

Random random = new Random();

class OtpController extends GetxController {
  int otp;
  int state = 0;
  String phone = '';
  bool verifyingOtp = false;
  bool otpFail = false;
  OtpController() {
    otp = random.nextInt(9999);
  }

  sendOtp(phone) async {
    state = 1;
    update();
    this.phone = phone;
    Response response = await Dio().post(
      "http://nightgangotp.herokuapp.com/",
      data: {
        "phone": phone,
        "otp": otp,
      },
    );
    state = 2;
    update();
    print(response);
  }

  Future<bool> verifyOtp(enteredOtp) async {
    verifyingOtp = true;
    update();
    await Future.delayed(Duration(seconds: 2));
    if (enteredOtp == otp.toString()) {
      otpFail = false;
      return true;
    }
    verifyingOtp = false;
    otpFail = true;
    update();
    return false;
  }
}
