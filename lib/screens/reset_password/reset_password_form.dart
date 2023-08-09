import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/custom_surfix_icon.dart';
import '../../components/form_error.dart';
import '../../global/global.dart';
import '../../global/regExp.dart';
import '../../global/snackbar.dart';
import '../../services/auth/forgate_password_service.dart';
import '../../services/general_services/size_config.dart';
import '../sign_in/sign_in_screen.dart';
import '../splash_screen/components/button.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _passwordHide = true;
  String? password;
  String? email;
  String? conformPassword;
  bool remember = false;
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

  void getEmail() async {
    email = await storage.read(key: 'email');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                http.Response response = await PasswordReset().resetPassword(
                    email!, password!, conformPassword!, context);
                Map responseMap = jsonDecode(response.body);
                final statues = responseMap['status'];
                if (response.statusCode == 200) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.routeName, (route) => false);
                  passSnackBar(context, "تمت اعادة تعيين كلمة السر بنجاح");
                } else if (statues != 200) {
                  errorSnackBar(context, "يوجد مشكلة ما يرجى اعادة المحاولة");
                }
              }
            },
          ),
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
}
