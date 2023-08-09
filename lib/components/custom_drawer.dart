import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/colors.dart';
import '../global/global.dart';
import '../screens/test_list_views/drawer_listview.dart';
import '../theme.dart';
import 'Loading.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> {
  bool isLoading = false;
  var profile;
  var name;
  @override
  void initState() {
    readProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.white,
      child: Builder(builder: (context) {
        return isLoading
            ? InfiniteRotation()
            : SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: kPrimaryColr,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 37,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Text(
                                  profile!,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColr),
                                ),
                              ),
                            ),
                            // Divider(
                            //   color: Color(0xFF2F8F9D),
                            // ),
                            SizedBox(height: 10),
                            Text(
                              name!,
                              style: textTheme().displayLarge,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      DrawerListview(),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  readProfileData() async {
    isLoading = true;
    // token = await storage.read(key: 'token');
    // email = await storage.read(key: 'email');

    name = await storage.read(key: 'name');
    profile = name![0];
    isLoading = false;
    setState(() {});
  }
}
