import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../components/custom_drawer.dart';
import '../../global/colors.dart';
import '../../theme.dart';

class TubesScreen extends StatelessWidget {
  static const String routeName = '/TubesScreen';
  const TubesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الأنابيب', style: textTheme().displayLarge)),
      body: CustomExpansionPanelList(),
      endDrawer: CustomDrawer(),
    );
  }
}

class CustomExpansionPanelList extends StatelessWidget {
  final List<Map> samples = [
    {
      "name": "اديتات دم كامل",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(215, 68, 252, 1),
      'description':
          'الحاوي على الإديتات EDTA المعلَّم بالغطاء البنفسجي للحصول على الدم الكامل ويستخدم في الاختبارات التالية (CBC - رحلان الخضاب – الزمرة الدموية – كومبس المباشر – معظم تحاليل الPCR   و الطفرات ...)'
    },
    {
      "name": "اديتات بلازما",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(215, 68, 252, 1),
      'description':
          'الحاوي على الإديتات EDTA المعلَّم بالغطاء البنفسجي للحصول على المصورة ويستخدم في الاختبارات التالية ( الامونيا – اللاكتات – ACTH...)'
    },
    {
      "name": "هيبارينات الليثيوم",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(53, 193, 75, 1),
      'description':
          'أنبوب عقيم مخلَّى من الهواء و يحتوي على هيبارينات الليثيومEvacuated lithium heparin و معلَّم بالغطاء الأخضر ( و يستخدم في الاختبارات التالية : الهشاشة الكروية – الشوارد – الامونيا – اللاكتات ...'
    },
    {
      "name": "غير حاوي على موانع تخثر",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(255, 66, 66, 1),
      'description':
          'انبوب عقيم مخلى من الهواء غير حاوي على موانع التخثر Evacuated plain tube المعلَّم بالغطاء الأحمر للحصول على المصل.( ويستخدم في معظم التحاليل الكيميائية و الهرمونية و المناعية)'
    },
    {
      "name": "سترات الصوديوم",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(52, 174, 213, 1),
      'description':
          'أنبوب عقيم مخلَّى من الهواء حاوي على سترات الصوديوم الثلاثية 0.11 مول/ليتر (3.13 غ/دسل إن كانت السترات ثنائية جزيئة الماء أو 3.8 غ/دسل إن كانت السترات خماسية جزيئة الماء)، بنسبة 9 دم/1 سترات المعلَّم بالغطاء الأزرق للحصول على المصورة Plasma. ( يستخدم لاجراء معظم التحاليل الخثرية مثل:  vWF, PT,PTT و عوامل التخثر المختلفة)'
    },
    {
      "name": "الأدينوزين سترات دكستروز",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(193, 187, 48, 1),
      'description':
          'أنبوب عقيم مخلَّى من الهواء حاوي على الأدينوزين سترات دكستروز ACD المعلَّم بالغطاء الأصفر نادر الاستخدام مخبريا مثل ( كومبس المباشر) و يستخدم عموما كمانع تخثر و مغذي في اكياس سحب الدم'
    },
    {
      "name": "المعادن النادرة",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(52, 174, 213, 1),
      'description':
          'الأنبوب العقيم المخلَّى من الهواء الحاوي على الإديتات (Royal Blue (Trace metal-free الخاص المعلَّم بالغطاء الأزرق ونادر الاستخدام مخبريا ويقتصر استخدامه على معايرة بعض المعادن النادرة كالرصاص'
    },
    {
      "name": "ابندورف للمصل والمصورة",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(193, 187, 48, 1),
      'description':
          'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ المصل او المصورة'
    },
    {
      "name": "ابندورف للدم الكامل",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(255, 66, 66, 1),
      'description':
          'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ الدم الكامل'
    },
    {
      "name": "ابندورف للسوائل الحيوية",
      'isExpanded': false.obs,
      'color': Color.fromRGBO(217, 217, 217, 1),
      'description':
          'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ السائل الدماغي الشوكي'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // print('dsadsadsad');
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) => Obx(
        () => ExpansionTile(
          shape: OutlineInputBorder(),
          childrenPadding: EdgeInsets.symmetric(horizontal: 20),
          tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          // trailing: SvgPicture.asset(
          //   'assets/images/tube1.svg',
          //   // ignore: deprecated_member_use
          //   color: samples[index]['color'],
          //   width: 20,
          // ),
          trailing: SizedBox
              .shrink(), // This will create an empty and invisible trailing widget
          onExpansionChanged: (value) =>
              samples[index]['isExpanded'].value = value,
          leading: samples[index]['isExpanded'].value
              ? SvgPicture.asset('assets/images/down_arrow.svg')
              : SvgPicture.asset('assets/images/right_arrow.svg'),
          collapsedShape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
          title: Text(
            samples[index]['name'],
            style: testBoldStyle.copyWith(fontSize: 18),
            textDirection: TextDirection.rtl,
          ),
          children: [
            Text(
              samples[index]['description'],
              style: testStyle.copyWith(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      itemCount: samples.length,
    );
  }
}

// Row(
//                   children: [
//                     SvgPicture.asset('assets/images/tube1.svg'),
//                     const SizedBox(width: 30),
//                     Text(
//                       'red cells tube',
//                       style: textTheme()
//                           .displayLarge!
//                           .copyWith(color: Colors.black),
//                     )
//                   ],
//                 ),







// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import '../../theme.dart';

// import '../../global/colors.dart';
// import '../../widgets/custom_drawer.dart';

// class TubesScreen extends StatelessWidget {
//   static const String routeName = '/TubesScreen';
//   const TubesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('الأنابيب', style: textTheme().displayLarge)),
//       body: CustomExpansionPanelList(),
//       endDrawer: CustomDrawer(),
//     );
//   }
// }

// class CustomExpansionPanelList extends StatelessWidget {
//   final List<Map> samples = [
//     {
//       "name": "اديتات دم كامل",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(215, 68, 252, 1),
//       'description':
//           'الحاوي على الإديتات EDTA المعلَّم بالغطاء البنفسجي للحصول على الدم الكامل ويستخدم في الاختبارات التالية (CBC -  - رحلان الخضاب – الزمرة الدموية – كومبس المباشر – معظم تحاليل الPCR   و الطفرات ...)'
//     },
//     {
//       "name": "اديتات بلازما",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(215, 68, 252, 1),
//       'description':
//           'الحاوي على الإديتات EDTA المعلَّم بالغطاء البنفسجي للحصول على المصورة ويستخدم في الاختبارات التالية ( الامونيا – اللاكتات – ACTH...)'
//     },
//     {
//       "name": "هيبارينات الليثيوم",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(53, 193, 75, 1),
//       'description':
//           'أنبوب عقيم مخلَّى من الهواء و يحتوي على هيبارينات الليثيومEvacuated lithium heparin و معلَّم بالغطاء الأخضر ( و يستخدم في الاختبارات التالية : الهشاشة الكروية – الشوارد – الامونيا – اللاكتات ...'
//     },
//     {
//       "name": "غير حاوي على موانع تخثر",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(255, 66, 66, 1),
//       'description':
//           'انبوب عقيم مخلى من الهواء غير حاوي على موانع التخثر Evacuated plain tube المعلَّم بالغطاء الأحمر للحصول على المصل.( ويستخدم في معظم التحاليل الكيميائية و الهرمونية و المناعية)'
//     },
//     {
//       "name": "سترات الصوديوم",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(52, 174, 213, 1),
//       'description':
//           'أنبوب عقيم مخلَّى من الهواء حاوي على سترات الصوديوم الثلاثية 0.11 مول/ليتر (3.13 غ/دسل إن كانت السترات ثنائية جزيئة الماء أو 3.8 غ/دسل إن كانت السترات خماسية جزيئة الماء)، بنسبة 9 دم/1 سترات المعلَّم بالغطاء الأزرق للحصول على المصورة Plasma. ( يستخدم لاجراء معظم التحاليل الخثرية مثل:  vWF, PT,PTT و عوامل التخثر المختلفة)'
//     },
//     {
//       "name": "الأدينوزين سترات دكستروز",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(193, 187, 48, 1),
//       'description':
//           'أنبوب عقيم مخلَّى من الهواء حاوي على الأدينوزين سترات دكستروز ACD المعلَّم بالغطاء الأصفر نادر الاستخدام مخبريا مثل ( كومبس المباشر) و يستخدم عموما كمانع تخثر و مغذي في اكياس سحب الدم'
//     },
//     {
//       "name": "المعادن النادرة",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(52, 174, 213, 1),
//       'description':
//           'الأنبوب العقيم المخلَّى من الهواء الحاوي على الإديتات (Royal Blue (Trace metal-free الخاص المعلَّم بالغطاء الأزرق ونادر الاستخدام مخبريا ويقتصر استخدامه على معايرة بعض المعادن النادرة كالرصاص'
//     },
//     {
//       "name": "ابندورف للمصل والمصورة",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(193, 187, 48, 1),
//       'description':
//           'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ المصل او المصورة'
//     },
//     {
//       "name": "ابندورف للدم الكامل",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(255, 66, 66, 1),
//       'description':
//           'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ الدم الكامل'
//     },
//     {
//       "name": "ابندورف للسوائل الحيوية",
//       'isExpanded': false.obs,
//       'color': Color.fromRGBO(217, 217, 217, 1),
//       'description':
//           'عبوات صغيرة معقمة ملائمة محكمة الإغلاق (eppendorf) لحفظ السائل الدماغي الشوكي'
//     }
//   ];

//   @override
//   Widget build(BuildContext context) {
//     print('dsadsadsad');
//     return ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//       separatorBuilder: (context, index) => const SizedBox(height: 15),
//       itemBuilder: (context, index) => Obx(
//         () => ExpansionTile(
//           shape: OutlineInputBorder(),
//           childrenPadding: EdgeInsets.symmetric(horizontal: 20),
//           tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//           leading: SvgPicture.asset(
//             'assets/images/tube1.svg',
//             // ignore: deprecated_member_use
//             color: samples[index]['color'],
//             width: 20,
//           ),
//           onExpansionChanged: (value) =>
//               samples[index]['isExpanded'].value = value,
//           trailing: samples[index]['isExpanded'].value
//               ? SvgPicture.asset('assets/images/down_arrow.svg')
//               : SvgPicture.asset('assets/images/right_arrow.svg'),
//           collapsedShape:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
//           title: Text(
//             samples[index]['name'],
//             style: testBoldStyle.copyWith(fontSize: 18),
//           ),
//           children: [
//             Text(
//               samples[index]['description'],
//               style: testStyle.copyWith(fontSize: 20),
//               textDirection: TextDirection.rtl,
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       itemCount: samples.length,
//     );
//   }
// }

// // Row(
// //                   children: [
// //                     SvgPicture.asset('assets/images/tube1.svg'),
// //                     const SizedBox(width: 30),
// //                     Text(
// //                       'red cells tube',
// //                       style: textTheme()
// //                           .displayLarge!
// //                           .copyWith(color: Colors.black),
// //                     )
// //                   ],
// //                 ),
