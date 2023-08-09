import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../components/Loading.dart';
import '../../components/rounded_button.dart';
import '../../services/auth/auth_provider.dart';
import '../sign_up/signup_screen2.dart';
import '../../theme.dart';

import '../../global/colors.dart';
import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../../services/general_services/size_config.dart';
import '../forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/sign_in";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  RxBool _passwordHide = true.obs;
  bool _isLoading = false; // Add this line to initialize _isLoading
  String? userId = "null";
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تسجيل الدخول',
          style: textTheme().displayLarge,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: InfiniteRotation())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/frame.svg',
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      _CustomInputField(
                        controller: _emailController,
                        text: 'البريد الإلكتروني',
                        img: 'assets/images/email.svg',
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Obx(
                        () => _CustomInputField(
                          hide: _passwordHide.value,
                          onTap: () =>
                              _passwordHide.value = !_passwordHide.value,
                          controller: _passwordController,
                          text: 'كلمة المرور',
                          img: 'assets/images/password.svg',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName),
                        child: Text(
                          'نسيت كلمة السر؟',
                          style: textTheme().bodyMedium!.copyWith(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      RoundedButton(
                          btnText: 'تسجيل الدخول',
                          onBtnPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            _email = _emailController.text;
                            _password = _passwordController.text;

                            if (_email!.isNotEmpty && _password!.isNotEmpty) {
                              await AuthProvider()
                                  .login(_email!, _password!, context);
                            } else {
                              errorSnackBar(context, KEmptField);
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          }),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      InkWell(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, SignUpView.routeName),
                        child: Text('ليس لديك حساب سابق؟',
                            style: textTheme()
                                .copyWith()
                                .displaySmall!
                                .copyWith(color: kPrimaryColr, fontSize: 14)),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, SignUpView.routeName),
                        child: Text('إنشاء حساب',
                            style: textTheme()
                                .displaySmall!
                                .copyWith(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// ignore: must_be_immutable
class _CustomInputField extends StatelessWidget {
  final String text;
  final String img;
  bool? hide;
  final TextEditingController controller;
  var onTap;
  _CustomInputField(
      {Key? key,
      required this.text,
      required this.img,
      required this.controller,
      this.onTap,
      this.hide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: textTheme().displaySmall!.copyWith(color: kPrimaryColr),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          obscureText: hide ?? false,
          style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(onTap: onTap, child: SvgPicture.asset(img)),
            ),
          ),
        )
      ],
    );
  }
}
