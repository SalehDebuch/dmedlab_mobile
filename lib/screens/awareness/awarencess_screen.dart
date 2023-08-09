import '../sign_up/signup_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../global/colors.dart';
import '../../theme.dart';

class AwarencessScreen extends StatelessWidget {
  final List<Map<String, dynamic>> elements = [
    {
      'img': 'assets/images/Tests Doctor 1.jpg',
      'title': 'أهلا بك',
      'subtitle': 'في تطبيق الموسوعة المخبرية الطبية ديميدلاب',
      'btnlabel': 'التالي',
      'isActive': true.obs
    },
    {
      'img': 'assets/images/Asset 3 1.jpg',
      'title': 'نقدم لك',
      'subtitle': 'قائمة واسعة من التحاليل السريرية',
      'btnlabel': 'التالي',
      'isActive': false.obs
    },
    {
      'img': 'assets/images/Asset 2 1.jpg',
      'title': 'بالإضافة',
      'subtitle': 'الى قائمة بالمختصرات الطبية الانكليزية ودلالاتها',
      'btnlabel': 'التالي',
      'isActive': false.obs
    },
    {
      'img': 'assets/images/docs 1.jpg',
      'title': 'ديميدلاب',
      'subtitle': 'سيكون مساعدك الشخصي في وضع التشخيص الصحيح',
      'btnlabel': 'ابدأ',
      'isActive': false.obs
    },
  ];

  Map<String, dynamic> get currentElement {
    Map<String, dynamic> element =
        elements.firstWhere((element) => element['isActive'].value == true);
    return {'element': element, 'currentIndex': elements.indexOf(element)};
  }

  AwarencessScreen({Key? key}) : super(key: key);
  static String routeName = '/awarencess';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Image.asset(currentElement['element']['img'])),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Obx(() => Text(
                        currentElement['element']['title'],
                        textDirection: TextDirection.rtl,
                        style: textTheme()
                            .displayLarge!
                            .copyWith(color: TEXT_COLOR),
                      )),
                  const SizedBox(height: 30),
                  Obx(() => Text(
                        currentElement['element']['subtitle'],
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: textTheme()
                            .displaySmall!
                            .copyWith(color: TEXT_COLOR),
                      )),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: elements
                  .map((e) => Obx(
                        () => Container(
                          decoration: BoxDecoration(
                              color: e['isActive'].value
                                  ? kPrimaryColr
                                  : SECONDTITLECOLOR,
                              borderRadius: BorderRadius.circular(50.0)),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 12,
                          height: 12,
                        ),
                      ))
                  .toList()
                  .reversed
                  .toList(),
            ),
            const SizedBox(height: 30),
            InkWell(
              splashColor: SECONDTITLECOLOR,
              overlayColor: MaterialStatePropertyAll(SECONDTITLECOLOR),
              onTap: () {
                if ((elements.length - 1) != currentElement['currentIndex']) {
                  int currentIndex = currentElement['currentIndex'];
                  currentElement['element']['isActive'].value = false;
                  elements[currentIndex + 1]['isActive'].value = true;
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SignUpView.routeName, (route) => false);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/images/arrow_simple.svg'),
                  const SizedBox(width: 15),
                  Text('التالي',
                      style: textTheme()
                          .displaySmall!
                          .copyWith(color: kPrimaryColr)),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
