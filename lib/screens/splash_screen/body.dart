// import 'package:flutter/material.dart';
// import '../../global/colors.dart';
// import '../sign_in/sign_in_screen.dart';
// import '../../size_config.dart';
// import 'components/button.dart';
// import 'components/splash_content.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   int currentPage = 0;
//   List<Map<String, String>> splashData = [
//     {
//       "text": "أفضل الطرق الحديثة لاجراء الاختبارات الطبية",
//       "image": "assets/images/b.png"
//     },
//     {
//       "text": "المرجع الأول والأحدث للتحاليل الطبية",
//       "image": "assets/images/A.jpg"
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 onPageChanged: (value) => setState(() {
//                   currentPage = value;
//                 }),
//                 itemCount: splashData.length,
//                 itemBuilder: (context, index) => SplashContent(
//                   image: splashData[index]['image'],
//                   text: splashData[index]['text'],
//                 ),
//               ),
//             ),
//             Expanded(
//               // flex: 1,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       splashData.length,
//                       (index) => buildDot(index: index),
//                     ),
//                   ),
//                   Spacer(flex: 3),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: (30)),
//                     child: SizedBox(
//                       width: SizeConfig.screenWidth * 0.8,
//                       child: CustomeButton(
//                         text: "  أهلا بكم ",
//                         press: () {
//                           Navigator.pushReplacementNamed(
//                               context, SignInScreen.routeName);
//                         },
//                       ),
//                     ),
//                   ),
//                   const Spacer(flex: 1),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   AnimatedContainer buildDot({int? index}) {
//     return AnimatedContainer(
//       duration: kAnimationDuration,
//       margin: const EdgeInsets.only(right: 5),
//       height: 6,
//       width: currentPage == index ? 20 : 6,
//       decoration: BoxDecoration(
//         color: currentPage == index ? kPrimaryColr : const Color(0xFFD8D8D8),
//         borderRadius: BorderRadius.circular(3),
//       ),
//     );
//   }
// }
