import '../../../global/colors.dart';
import '../../../theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../global/global.dart';
import '../../../global/snackbar.dart';
import '../../../services/auth/email_verification_service.dart';
import '../../../services/general_services/size_config.dart';
import '../../login_success/login_success_screen.dart';
import '../../splash_screen/components/button.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  String? one;
  String? two;
  String? three;
  String? four;
  String? userOtp;
  String? otp;
  String? email;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void getotp() async {
    email = await storage.read(key: 'email');

    checkOTP();
    //;
  }

  void checkOTP() async {
    http.Response response =
        await EmailVerification().verifyEmail(email!, userOtp!, context);
    print(response.statusCode);
    response.statusCode == 200
        ? Navigator.pushNamedAndRemoveUntil(
            context, LoginSuccessScreen.routeName, (route) => false)
        : errorSnackBar(context, "رمز التحقق غير صالح");
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text("قمنا بارسال رمز التحقق إلى  \nحسابك الالكتروني",
              textAlign: TextAlign.center,
              style: textTheme().displayLarge!.copyWith(color: kPrimaryColr)),
          SizedBox(height: SizeConfig.screenHeight * 0.035),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    one = value;
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                    focusNode: pin2FocusNode,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin3FocusNode);
                      two = value;
                    }),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                    focusNode: pin3FocusNode,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin4FocusNode);
                      three = value;
                    }),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    four = value;
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.035),
          // Text(
          //   'رجاءا أدخل كود التحقق المرسل إلى الإيميل${email ?? 'mail@example.com'}',
          //   textAlign: TextAlign.center,
          //   style: textTheme().displayLarge!.copyWith(color: kPrimaryColr),
          // ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          CustomeButton(
            text: "تحقق",
            press: () {
              getotp();

              userOtp = [one, two, three, four].join('');
            },
          ),
        ],
      ),
    );
  }
}
