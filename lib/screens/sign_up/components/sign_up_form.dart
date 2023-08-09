import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../components/custom_surfix_icon.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/auth/email_verification_service.dart';
import '../../../services/device_info/device_info.dart';
import '../../otp_email/otp_screen.dart';

import '../../../components/form_error.dart';
import '../../../components/keyboard.dart';
import '../../../global/global.dart';
import '../../../global/regExp.dart';
import '../../../global/snackbar.dart';
import '../../../services/general_services/size_config.dart';
import '../../splash_screen/components/button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? password;
  String? otp;
  String? conformPassword;
  bool remember = false;
  String? deviceName;
  bool _passwordHide = true;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    getDeviceName();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDeviceName() async {
    if (kIsWeb) {
      deviceName = "web_browser";
    } else {
      DeviceUtil deviceUtil = DeviceUtil();
      deviceName = await deviceUtil.getDeviceName();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          CustomeButton(
              text: "استمرار",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  http.Response registerResponse = await AuthProvider.register(
                      name!, email!, password!, deviceName!, context);
                  Map registerResponseMap = jsonDecode(registerResponse.body);

                  if (registerResponse.statusCode == 200) {
                    KeyboardUtil.hideKeyboard(context);
                    await EmailVerification()
                        .sendVerificationEmail(email!, context);
                    passSnackBar(
                        context, "قمنا بارسال رمز التحقق الى حسابك الالكتروني");

                    Navigator.pushReplacementNamed(
                        context, OtpEmailScreen.routeName,
                        arguments: email);
                    await storage.write(key: 'email', value: email);
                  } else {
                    errorSnackBar(context, registerResponseMap.values.first[0]);
                  }
                }
              })
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: _passwordHide,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassConformError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassConformError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "تأكيد كلمة السر",
        hintText: "أعد ادخال كلمة السر",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
            onPressed: () {
              setState(() {
                _passwordHide = !_passwordHide;
              });
            }),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _passwordHide,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "كلمة المرور",
        hintText: "ادخل كلمة المرور ",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
            svgIcon: "assets/icons/Lock.svg",
            onPressed: () {
              setState(() {
                _passwordHide = !_passwordHide;
              });
            }),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        name = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "الاسم  ",
        hintText: "ادخل الاسم  ",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "الحساب الالكتروني",
        hintText: "ادخل حسابك الالكتروني",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
