import 'package:flutter/material.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../global/global.dart';
import '../../../global/snackbar.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/general_services/size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../splash_screen/components/button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  bool _passwordHide = true;
  bool _isLoading = false; // Add this line to initialize _isLoading
  String? userId = "null";

  final List<String?> errors = [];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getTestListTests();
    super.initState();
  }

  void getTestListTests() async {
    userId = await storage.read(key: 'userId');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        buildEmailFormField(),
        SizedBox(height: getProportionateScreenHeight(50)),
        buildPasswordFormField(),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: Text(
                "نسيت كلمة السر",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(40)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomeButton(
              text: "تسجيل الدخول",
              press: () async {
                setState(() {
                  _isLoading = true;
                });
                _email = _emailController.text;
                _password = _passwordController.text;

                if (_email!.isNotEmpty && _password!.isNotEmpty) {
                  await AuthProvider().login(_email!, _password!, context);
                } else {
                  errorSnackBar(context, KEmptField);
                }
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            SizedBox(height: 10),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        )
      ],
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _passwordHide,
      decoration: InputDecoration(
        labelText: "كلمة المرور",
        hintText: "أدخل كلمة المرور",
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "الحساب الالكتروني",
        hintText: "أدخل حسابك الالكتروني",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
