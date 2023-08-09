// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../theme.dart';

// import '../../global/colors.dart';
// import '../../services/size_config.dart';
// import '../../widgets/rounded_button.dart';
// import '../sign_in/sign_in_screen.dart';

// class SplashScreen extends StatefulWidget {
//   static String routeName = '/SplashScreen';

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.white,
//         statusBarIconBrightness: Brightness.dark,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         // statusBarColor: Color.fromARGB(255, 5, 77, 81),
//         statusBarColor: kPrimaryColr,
//         // statusBarBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChannels.textInput.invokeMethod('TextInput.hide');

//     SizeConfig().init(context);
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                   'assets/images/intro.jpg',
//                 ))),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             child: SizedBox(
//               width: double.infinity,
//               child: Column(
//                 children: [
//                   Spacer(),
//                   SvgPicture.asset('assets/images/frame.svg'),
//                   const SizedBox(height: 10),
//                   Text('الموسوعة المخبرية الأشمل',
//                       style: textTheme()
//                           .displayLarge!
//                           .copyWith(color: kPrimaryColr)),
//                   Spacer(flex: 4),
//                   RoundedButton(
//                       onBtnPressed: () => Navigator.pushReplacementNamed(
//                           context, SignInScreen.routeName),
//                       btnText: 'ابدأ'),
//                   SizedBox(height: 28)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

//       // Stack(
//       //   children: [

//       //     // Container(
//       //     //   //  width: double.infinity,
//       //     //   //  height: double.infinity,
//       //     //   decoration: BoxDecoration(
//       //     //     image: DecorationImage(
//       //     //       image: AssetImage("assets/images/A.jpg"),
//       //     //       fit: BoxFit.fill,
//       //     //     ),
//       //     //   ),
//       //     // ),

//       //     // Positioned(
//       //     //   bottom: 0,
//       //     //   left: 0,
//       //     //   right: 0,
//       //     //   child:
//       //     //   Container(
//       //     //     height: getProportionateScreenHeight(70),
//       //     //     decoration: BoxDecoration(
//       //     //       gradient: LinearGradient(
//       //     //         colors: [
//       //     //           Color.fromRGBO(34, 154, 219, 1),
//       //     //           Color.fromRGBO(85, 238, 255, 1),
//       //     //         ],
//       //     //         begin: Alignment.centerLeft,
//       //     //         end: Alignment.centerRight,
//       //     //       ),
//       //     //     ),
//       //     //     child: ElevatedButton(
//       //     //       onPressed: () {
//       //     //         Navigator.pushReplacementNamed(
//       //     //             context, SignInScreen.routeName);
//       //     //       },
//       //     //       style: ElevatedButton.styleFrom(
//       //     //         backgroundColor: Colors.transparent,
//       //     //         elevation: 0,
//       //     //         textStyle: TextStyle(
//       //     //           color: Colors.white,
//       //     //           fontSize: 16,
//       //     //           fontWeight: FontWeight.bold,
//       //     //         ),
//       //     //       ),
//       //     //       child: Text('ابدأ الآن'),
//       //     //     ),
//       //     //   ),

//       //     // ),
//       //   ],
//       // ),
//     );
//   }
// }
// //  Positioned(
// //             bottom: 28,
// //             left: 34,
// //             right: 34,
// //             child: RoundedButton(
// //                 onBtnPressed: () => Navigator.pushReplacementNamed(
// //                     context, SignInScreen.routeName),
// //                 btnText: 'ابدأ'))