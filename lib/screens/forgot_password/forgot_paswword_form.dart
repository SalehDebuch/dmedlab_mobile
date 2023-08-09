import 'package:flutter/material.dart';

import '../../components/no_account_text.dart';
import '../../components/rounded_button.dart';
import '../../global/colors.dart';
import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../../services/auth/forgate_password_service.dart';
import '../../services/general_services/size_config.dart';
import '../../theme.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  TextEditingController _emailController = new TextEditingController();
  String? email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextFormField(
        //   keyboardType: TextInputType.emailAddress,
        //   controller: _emailController,
        //   decoration: InputDecoration(
        //     labelText: "الحساب الالكتروني",

        //     hintText: "ادخل حسابك الالكتروني", //Enter your email

        //     // If  you are using latest version of flutter then lable text and hint text shown like this
        //     // if you r using flutter less then 1.20.* then maybe this is not working properly
        //     floatingLabelBehavior: FloatingLabelBehavior.always,
        //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        //   ),
        // ),

        _CustomInputField(
          controller: _emailController,
          text: 'البريد الإلكتروني',
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        RoundedButton(
          btnText: "استمرار",
          onBtnPressed: () async {
            email = _emailController.text;
            storage.write(key: 'email', value: email);

            if (email!.isNotEmpty) {
              await PasswordReset().forgotPassword(email!, context);
            } else {
              errorSnackBar(context, "يرجى ادخال حسابك الالكتروني");
            }
          },
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        NoAccountText(),
      ],
    );
  }
}

// ignore: must_be_immutable
class _CustomInputField extends StatelessWidget {
  final String text;
  bool? hide;
  final TextEditingController controller;
  var onTap;
  _CustomInputField({Key? key, required this.text, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: textTheme()
              .displaySmall!
              .copyWith(color: kPrimaryColr, letterSpacing: 1.7),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          obscureText: hide ?? false,
          style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
        )
      ],
    );
  }
}
