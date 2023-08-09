import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/rounded_button.dart';
import '../../global/colors.dart';
import '../../global/global.dart';
import '../../global/snackbar.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/general_services/unfocus_service.dart';
import '../../services/storage_service/storage_service.dart';
import '../../services/update_profile_service/update_user_data.dart';
import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  RxBool isLoading = false.obs;
  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _mobileController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  RxString flag = '🇦🇪'.obs;

  String? name;

  String? email;
  String? token;
  String? profile;

  String? userId;

  Future<void> getUserData() async {
    isLoading.value = true;
    name = await storage.read(key: 'name');
    email = await storage.read(key: 'email');
    token = await storage.read(key: 'token');
    _nameController.text = name!;
    _emailController.text = email!;
    _mobileController.text = '099999999999';
    userId = await StorageServices().getUserID();
    profile = name![0];
    isLoading.value = false;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _mobileController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () => unfocus(context),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "الملف الشخصي",
                style: textTheme().displayLarge,
              ),
            ),
            body:

                // Once the data is available, build the UI
                Obx(
              () => isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.01),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: kPrimaryColr,
                          child: Center(
                            child: Text(
                              profile!.substring(0, 1),
                              style: GoogleFonts.montserrat(
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),

                        // CustomFormField(
                        //   controller: _nameController,
                        //   hintText: "Enter your name",
                        //   labelText: "Name",
                        //   keyboardType: TextInputType.text,
                        //   suffixIcon:
                        //       CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
                        // ),
                        _CustomInputField(
                          controller: _nameController,
                          text: 'الاسم',
                          img: 'person',
                        ),
                        SizedBox(height: height * 0.03),
                        // CustomFormField(
                        //   controller: _emailController,
                        //   hintText: "Enter your email",
                        //   labelText: "Email",
                        //   keyboardType: TextInputType.emailAddress,
                        //   suffixIcon:
                        //       CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                        // ),

                        _CustomInputField(
                          controller: _emailController,
                          text: 'البريد الإلكتروني',
                          img: 'email',
                        ),
                        SizedBox(height: height * 0.03),
                        // _CustomInputField(
                        //   country: TextButton(
                        //     child: Obx(() => Container(
                        //           margin: const EdgeInsets.only(left: 5),
                        //           child: Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: [
                        //               Text(
                        //                 flag.value,
                        //                 style: TextStyle(fontSize: 30),
                        //               ),
                        //               Icon(Icons.arrow_drop_down)
                        //             ],
                        //           ),
                        //         )),
                        //     onPressed: () {
                        //       showCountryPicker(
                        //         useSafeArea: true,
                        //         countryListTheme: CountryListThemeData(
                        //             flagSize: 38,
                        //             borderRadius: BorderRadius.circular(0),
                        //             bottomSheetHeight: height * 0.60,
                        //             textStyle: textTheme()
                        //                 .bodyLarge!
                        //                 .copyWith(color: TEXT_COLOR)),
                        //         context: context,
                        //         showPhoneCode:
                        //             true, // optional. Shows phone code before the country name.
                        //         onSelect: (Country country) {
                        //           // print('Select country: ${country.displayName}');
                        //           flag.value = country.flagEmoji;
                        //           print(country.flagEmoji);
                        //         },
                        //       );
                        //     },
                        //   ),
                        //   controller: _mobileController,
                        //   text: 'رقم الجوال',
                        //   img: 'mobile',
                        // ),
                        SizedBox(height: height * 0.05),
                        RoundedButton(
                          btnText: 'تحديث البيانات ',
                          onBtnPressed: () {
                            name = _nameController.text;
                            updateUserProfile(userId!, name!, email!, context);
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        TextButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'حذف الحساب',
                                    style: textTheme()
                                        .displayMedium!
                                        .copyWith(color: Colors.red),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          var _password =
                                              _passwordController.text;
                                          if (_password.isNotEmpty) {
                                            await AuthProvider().deleteAccount(
                                                _password, context, token);
                                            _passwordController.clear();
                                          } else {
                                            errorSnackBar(context, KEmptField);
                                          }
                                        },
                                        child: Text(
                                          'نعم',
                                          style: textTheme()
                                              .bodyLarge!
                                              .copyWith(color: Colors.red),
                                        )),
                                    const SizedBox(width: 50),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        'لا',
                                        style: textTheme()
                                            .bodyLarge!
                                            .copyWith(color: kPrimaryColr),
                                      ),
                                    ),
                                  ],
                                  content: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: 'ادخل كلمة المرور',
                                          hintStyle:
                                              TextStyle(color: TEXT_COLOR))),
                                ),
                              );
                            },
                            child: Text(
                              'حذف الحساب',
                              style: textTheme()
                                  .displayMedium!
                                  .copyWith(color: Colors.red),
                            ))
                      ],
                    ),
            )));
  }
}

// ignore: must_be_immutable
class _CustomInputField extends StatelessWidget {
  final String text;
  final String img;
  final Widget? country;
  bool? hide;
  final TextEditingController controller;
  var onTap;
  _CustomInputField(
      {Key? key,
      required this.text,
      required this.img,
      // ignore: unused_element
      required this.controller,
      // ignore: unused_element
      this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
            prefixIcon: country ?? null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset('assets/images/$img.svg')),
            ),
          ),
        )
      ],
    );
  }
}
