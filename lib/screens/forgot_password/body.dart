import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/blank_container.dart';
import '../../global/colors.dart';
import '../../services/general_services/size_config.dart';
import '../../services/general_services/unfocus_service.dart';
import '../../theme.dart';
import 'forgot_paswword_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(context),
      child: Stack(children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  SvgPicture.asset('assets/images/frame.svg'),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text(
                    '''يرجى إدخال حسابك الالكتروني
      وسنقوم بإرسال رابط لاستعادة كلمة
      المرور الخاصة بك''',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style:
                        textTheme().displaySmall!.copyWith(color: kPrimaryColr),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  ForgotPassForm(),
                ],
              ),
            ),
          ),
        ),
        SizeConfig.screenHeight > 700 ? BlankContainer() : SizedBox()
      ]),
    );
  }
}
