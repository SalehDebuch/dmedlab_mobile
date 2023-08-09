// ignore_for_file: unused_element

import 'package:dmed_lab/screens/sign_in/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/Loading.dart';
import '../../components/keyboard.dart';
import '../../global/global.dart';
import '../../global/regExp.dart';
import '../../global/snackbar.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/device_info/device_info.dart';
import '../../theme.dart';

import '../../global/colors.dart';
import '../../services/general_services/size_config.dart';
import '../otp_email/otp_screen.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  static String routeName = "/sign_up";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _rePasswordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  RxString flag = '🇦🇪'.obs;
  RxBool isHide = true.obs;
  RxBool isHide2 = true.obs;
  RxBool isAgree = false.obs;
  RxBool isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? name;
  String? password;
  String? otp;
  String? conformPassword;
  bool remember = false;
  String? deviceName;
  // bool _passwordHide = true;
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

  void getDeviceName() async {
    if (kIsWeb) {
      deviceName = "web_browser";
    } else {
      DeviceUtil deviceUtil = DeviceUtil();
      deviceName = await deviceUtil.getDeviceName();
    }
  }

  @override
  void initState() {
    super.initState();
    getDeviceName();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إنشاء حساب",
          style: textTheme().displayLarge,
        ),
      ),
      body: Obx(
        () => isLoading.value
            ? Center(child: InfiniteRotation())
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/frame.svg',
                        ),
                        SizedBox(height: getProportionateScreenHeight(40)),
                        buildNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        buildEmailFormField(),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Obx(
                          () => buildPasswordFormField(),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        Obx(() => buildConformPassFormField()),

                        SizedBox(height: getProportionateScreenHeight(30)),
                        Obx(
                          () => CheckboxListTile(
                            value: isAgree.value,
                            onChanged: (value) => isAgree.value = value!,
                            title: InkWell(
                              onTap: () async => await launchUrl(
                                  Uri.parse('https://dmedlab.com/policy.html')),
                              child: Text(
                                'الشروط والأحكام',
                                textDirection: TextDirection.rtl,
                                style: textTheme()
                                    .displaySmall!
                                    .copyWith(color: TEXT_COLOR),
                              ),
                            ),
                            checkboxShape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        // _CustomInputField(
                        //   textInputType: TextInputType.phone,
                        // country: TextButton(
                        //   child: Obx(() => Container(
                        //         margin: const EdgeInsets.only(left: 5),
                        //         child: Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Text(
                        //               flag.value,
                        //               style: TextStyle(fontSize: 30),
                        //             ),
                        //             Icon(Icons.arrow_drop_down)
                        //           ],
                        //         ),
                        //       )),
                        //   onPressed: () {
                        //     showCountryPicker(
                        //       useSafeArea: true,
                        //       countryListTheme: CountryListThemeData(
                        //           flagSize: 38,
                        //           borderRadius: BorderRadius.circular(0),
                        //           bottomSheetHeight: SizeConfig.screenHeight * 0.60,
                        //           textStyle: textTheme()
                        //               .bodyLarge!
                        //               .copyWith(color: TEXT_COLOR)),
                        //       context: context,
                        //       showPhoneCode:
                        //           true, // optional. Shows phone code before the country name.
                        //       onSelect: (Country country) {
                        //         // print('Select country: ${country.displayName}');
                        //         flag.value = country.flagEmoji;
                        //         print(country.flagEmoji);
                        //       },
                        //     );
                        //   },
                        // ),
                        //   // controller: _mobileController,
                        //   text: 'رقم الجوال',
                        //   img: 'assets/images/mobile.svg',
                        // ),

                        SizedBox(height: getProportionateScreenHeight(20)),

                        Obx(
                          () => ElevatedButton(
                              style: ButtonStyle(
                                fixedSize:
                                    MaterialStatePropertyAll(Size(350, 60)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0))),
                              ),
                              onPressed: isAgree.value
                                  ? () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        var registerResponse =
                                            await AuthProvider.register(
                                                name!,
                                                email!,
                                                password!,
                                                deviceName!,
                                                context);

                                        if (registerResponse.statusCode ==
                                            201) {
                                          KeyboardUtil.hideKeyboard(context);

                                          passSnackBar(context,
                                              "قمنا بارسال رمز التحقق الى حسابك الالكتروني");

                                          Navigator.pushReplacementNamed(
                                              context, OtpEmailScreen.routeName,
                                              arguments: email);
                                          await storage.write(
                                              key: 'email', value: email);
                                        } else {
                                          errorSnackBar(
                                              context, registerResponse.body);
                                        }
                                      }
                                    }
                                  : null,
                              child: Text(
                                'استمرار',
                                style: textTheme().displayLarge!,
                              )),
                        ),

                        SizedBox(height: getProportionateScreenHeight(30)),

                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName),
                            child: Text(
                              'هل لديك حساب سابق؟',
                              style: textTheme()
                                  .displaySmall!
                                  .copyWith(color: kPrimaryColr),
                            )),
                        InkWell(
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName),
                            child: Text(
                              'تسجيل الدخول',
                              style: textTheme()
                                  .displaySmall!
                                  .copyWith(color: Colors.black),
                            )),

                        // SizedBox(height: getProportionateScreenHeight(20)),
                        // Text('ليس لديك حساب سابق؟',
                        //     style: textTheme()
                        //         .displayLarge!
                        //         .copyWith(color: kPrimaryColr)),
                        // TextButton(
                        //   onPressed: () => Navigator.pushNamed(
                        //       context, SignUpView.SignUpView.routeName),
                        //   child: Text('إنشاء حساب',
                        //       style: textTheme()
                        //           .displayLarge!
                        //           .copyWith(color: Colors.black)),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
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
        labelText: 'البريد الإلكتروني',
        // prefixIcon: country ?? null,
        labelStyle: textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            // onTap: onTap,
            child: SvgPicture.asset(
              'assets/images/email.svg',
              height: 38,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
      obscureText: isHide2.value,
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
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'تأكيد كلمة المرور',

        // prefixIcon: country ?? null,
        labelStyle: textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () => isHide2.value = !isHide2.value,
            child: SvgPicture.asset(
              'assets/images/password.svg',
              height: 38,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isHide.value,
      style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
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
        labelText: 'كلمة المرور',
        // prefixIcon: country ?? null,
        labelStyle: textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () => isHide.value = !isHide.value,
            child: SvgPicture.asset(
              'assets/images/password.svg',
              height: 38,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      style: textTheme().bodyMedium!.copyWith(color: TEXT_COLOR),
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
        labelText: 'اسم المستخدم',
        // prefixIcon: country ?? null,
        labelStyle: textTheme().bodyMedium!.copyWith(color: kPrimaryColr),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            // onTap: onTap,
            child: SvgPicture.asset(
              'assets/images/person.svg',
              height: 38,
            ),
          ),
        ),
      ),
    );
  }
}
