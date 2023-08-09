import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../components/custom_drawer.dart';
import '../abbreviation/abbreviation_screen.dart';
import '../definition/definition_screen.dart';
import '../test_list_views/tests_list_screen.dart';
import '../tubes/tubes_screen.dart';
import '../../theme.dart';

import '../../components/blank_container.dart';
import '../../global/colors.dart';
import '../../global/global.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var name;
  var profile;
  @override
  void initState() {
    readProfileData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
          child: Icon(
            Icons.menu,
            size: 30,
            color: kPrimaryColr,
          )),
      endDrawer: CustomDrawer(),
      body: Center(
        child: Stack(children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                SizedBox(height: 30),
                SvgPicture.asset(
                  'assets/images/frame.svg',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(DefinitionScreen.routeName),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 600),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'تعريف بالموسوعة',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: textTheme()
                          .displayLarge!
                          .copyWith(color: FIRSTITEMSCOLOR),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: FIRSTITEMSCOLOR, width: 5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TestsLists.routeName),
                  child: Box(text: 'التحاليل', img: 'assets/images/tube.svg'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TubesScreen.routeName),
                  child: Box(text: 'الأنابيب', img: 'assets/images/tube1.svg'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AbbreviationScreen.routeName),
                  child: Box(text: 'المختصرات', img: 'assets/images/colon.svg'),
                ),
              ]),
            ),
          ),
          BlankContainer(),
        ]),
      ),
    );
  }

  readProfileData() async {
    // token = await storage.read(key: 'token');
    name = await storage.read(key: 'name');
    // email = await storage.read(key: 'email');

    profile = name![0];
  }
}

class Box extends StatelessWidget {
  final String text;
  final String img;
  const Box({
    Key? key,
    required this.text,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 600, maxHeight: 140),
      padding: EdgeInsets.symmetric(vertical: 27),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: FIRSTITEMSCOLOR),
      child: Row(children: [
        Expanded(child: SvgPicture.asset(img)),
        Expanded(
          child: Text(text, style: textTheme().displayLarge),
        )
      ]),
    );
  }
}

// class Box2 extends StatelessWidget {
//   final String text;
//   final String img;
//   const Box({
//     Key? key,
//     required this.text,
//     required this.img,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width > 700
//           ? (MediaQuery.of(context).size.width) / 2.8
//           : (MediaQuery.of(context).size.width - 90) / 2,
//       padding: EdgeInsets.symmetric(vertical: 35, horizontal: 15),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50), color: FIRSTITEMSCOLOR),
//       child: Column(children: [
//         SvgPicture.asset(
//           img,
//         ),
//         SizedBox(height: 10),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         )
//       ]),
//     );
//   }
// }
