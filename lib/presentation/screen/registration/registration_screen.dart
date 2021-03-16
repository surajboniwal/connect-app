import 'package:connect/controller/otp_controller.dart';
import 'package:connect/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegistrationScreen extends StatelessWidget {
  final OtpController otpController = Get.put(OtpController());
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GetBuilder<OtpController>(
          builder: (controller) {
            if (controller.state == 1) {
              _pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
            }
            if (controller.state == 2) {
              _pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeOut);
            }
            return PageView(
              controller: _pageController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                WelcomeScreen(),
                SendingOtpScreen(),
                OtpVerificationScreen(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OtpVerificationScreen extends StatelessWidget {
  final TextEditingController _otpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/app_icon.png",
            width: 80,
          ),
          Column(
            children: [
              Text(
                "OTP Verification",
                style: Theme.of(context).textTheme.headline6.copyWith(),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.subtitle2,
                  children: [
                    TextSpan(text: "Enter the OTP sent to"),
                    TextSpan(text: " "),
                    TextSpan(
                      text: "+91-" + Get.find<OtpController>().phone,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              PinCodeTextField(
                controller: _otpTextController,
                appContext: context,
                length: 4,
                autoDisposeControllers: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: AppColors.PRIMARY_COLOR,
                  activeFillColor: AppColors.PRIMARY_COLOR,
                  inactiveColor: AppColors.GREY_COLOR,
                  selectedColor: AppColors.PRIMARY_COLOR,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (String pin) {
                  if (pin.length == 4) {
                    Get.find<OtpController>().verifyOtp(pin).then((value) {
                      if (value) {
                        Get.offAllNamed('/');
                      } else {
                        print("failed");
                      }
                    });
                  }
                },
              ),
              GetBuilder<OtpController>(
                builder: (controller) => controller.verifyingOtp
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.PRIMARY_COLOR),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.verifyOtp(_otpTextController.value).then((value) {
                            if (value) {
                              Get.offAllNamed('/');
                            } else {
                              print("failed");
                            }
                          });
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.grey[300],
                                spreadRadius: 1,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Verify",
                              style: TextStyle(
                                color: AppColors.WHITE_COLOR,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SendingOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please wait while we send you the\none time password.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14),
          ),
          SizedBox(height: 16),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(top: Get.height / 8, left: Get.width / 8, right: Get.width / 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/app_icon.png",
                  width: 80,
                ),
                SizedBox(height: 12),
                Text(
                  "Welcome to Connect.",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: AppColors.PRIMARY_COLOR,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            SizedBox(height: Get.height / 6),
            Column(
              children: [
                Text(
                  "Please enter your phone number to continue.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption.copyWith(fontSize: 14),
                ),
                SizedBox(height: 12),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefix: Text("+91"),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Get.find<OtpController>().sendOtp(_phoneController.text);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey[300],
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    height: 45,
                    child: Center(
                      child: Text(
                        "Get OTP",
                        style: TextStyle(
                          color: AppColors.WHITE_COLOR,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
