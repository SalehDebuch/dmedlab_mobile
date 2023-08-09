import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../global/colors.dart';
import '../../theme.dart';

class DefinitionScreen extends StatelessWidget {
  static String routeName = '/definition';
  const DefinitionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعريف بالموسوعة',
          style: textTheme().displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              SvgPicture.asset('assets/images/frame.svg'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.030),
              // Text(
              //   'Arabic Clinical Laboratory Encyclopedia',
              //   style: textTheme().displaySmall!.copyWith(color: kPrimaryColr),
              //   textDirection: TextDirection.rtl,
              // ),
              Text(
                'الموسوعة المخبرية السريرية العربية',
                style: textTheme().displaySmall!.copyWith(color: kPrimaryColr),
                textDirection: TextDirection.rtl,
              ),
              // Text('Version 1.0',
              //     style:
              //         textTheme().displaySmall!.copyWith(color: kPrimaryColr)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.020),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 15),
                    ...[
                      "تشمل أكثر من سبعمائة اختبار سريري (دمويات، مناعيات، كيمياء سريرية، أحياء دقيقة)، مرتبة حسب الأبجدية الإنكليزية",
                      "تحتوي على جدول لمختصرات المصطلحات الطبية المخبرية العالمية باللغة الانكليزية، مع صور توضيحية ملائمة للاختبار أو المرض",
                      "تم تجهيز هذا التطبيق الالكتروني الخاص بالموسوعة لتسهيل الوصول اليها عبر مختلف الأجهزة الإلكترونية دون الخاجة للاتصال بالانترنت",
                      // "توفير امكانية البحث عن التحليل باستخدام اللغة العربية والانكليزية والفرنسية والالمانية باستخدام اسم التحليل أو أيٍ من مسمياته الأخرى الشائعة",
                      "تم وضع بعض الروابط الإلكترونية لإجراء الحسابات المعقدة لبعض الاختبارات",
                    ]
                        .map((e) => Column(
                              children: [
                                TextRowItem(text: e),
                                const SizedBox(height: 5),
                              ],
                            ))
                        .toList(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030),
                    TextRowItem(text: 'يتضمن كل اختبار:'),
                    const SizedBox(height: 5),
                    ...[
                      "اسم الاختبار الشائع باللغتين العربية والانكليزية.",
                      "تفريق الاختبار عن الاختبارات المغايرة المشابهة لفظا إن وجدت.",
                      "المسميات الأخرى للاختبار ومختصراته بالإنكليزية والفرنسية والألمانية، للتمكن من قراءة طلبات الأطباء المخبرية من كل أنحاء العالم.",
                      "تعريف موجز بالاختبار.",
                      "تحديد نموذج العينة المطلوبة للاختبار.",
                      "كيفية حفظ النموذج.",
                      "طرق قياس الاختبار الشائعة.",
                      "القيم المرجعية للاختبار لدى البالغين والأطفال والحوامل بالوحدات الشائعة.",
                      "جدول التحويل إلى الوحدات الأخرى المتوفرة.",
                      "تفسير النتائج وذكر أسباب الزيادة أو النقص.",
                      "الاختبارات الأخرى ذات الصلة بهذا الاختبار مع الروابط التشعبية لها."
                    ]
                        .map(
                          (e) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextRowItem(icon: 'dash', text: e),
                              ),
                              const SizedBox(height: 5)
                            ],
                          ),
                        )
                        .toList(),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.060),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextRowItem extends StatelessWidget {
  final String text;
  final String? icon;
  const TextRowItem({Key? key, required this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.end,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          child: Baseline(
            baseline: 20,
            baselineType: TextBaseline
                .alphabetic, // Set the baseline type to match the textBaseline
            child: Text(
              text,

              textDirection: TextDirection.rtl,
              // textAlign: TextAlign.justify,
              style: testStyle.copyWith(fontSize: 18),
            ),
          ),
        ),
        SizedBox(width: 10),
        Baseline(
          baseline: 20,
          baselineType: TextBaseline.alphabetic,
          child: SvgPicture.asset(
            'assets/images/${icon ?? 'point'}.svg',
          ),
        ),
      ],
    );
  }
}
