import 'package:flutter/material.dart';
import '../../components/custom_drawer.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/general_services/unfocus_service.dart';
import '../../theme.dart';
import '../../global/global.dart';
import '../../services/general_services/check_internet_connectivity.dart';
import '../../services/general_services/on_will_pop_service/onWillPop.dart';
import '../../services/lab_test_service/switch_test_title_provider.dart';
import '../favorite_test/favourite_screen.dart';
import '../profile/profile_screen.dart';
import 'components/bottomAppBar.dart';
import 'body.dart';

class TestsLists extends StatefulWidget {
  static String routeName = '/Test_list';

  @override
  State<TestsLists> createState() => _TestsListsState();
}

class _TestsListsState extends State<TestsLists> {
  String? token;
  String? name;
  String? email;
  String? profile;

  bool isConnect = false;
  @override
  void initState() {
    initilizeUSerData();
    super.initState();
  }

  Widget build(BuildContext context) {
    final testProvider = TestListProvider.of(context);

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: GestureDetector(
        onTap: () => unfocus(context),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            child: PopupMenuButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              tooltip: 'Languages',
              offset: Offset(-35, -200),
              icon: Icon(Icons.language),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('En'),
                  onTap: () => testProvider.setSelectedLanguage('en'),
                ),
                PopupMenuItem(
                  child: const Text('Ar'),
                  onTap: () => testProvider.setSelectedLanguage('ar'),
                ),
                PopupMenuItem(
                  child: const Text('Fr'),
                  onTap: () => testProvider.setSelectedLanguage('fr'),
                ),
                PopupMenuItem(
                  child: const Text('De'),
                  onTap: () => testProvider.setSelectedLanguage('de'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              title: Container(
                width: 200,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'التحاليل المخبرية الطبية',
                        style: textTheme().displayLarge,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true),
          endDrawer: CustomDrawer(),
          bottomNavigationBar: SafeArea(
            child: CustomBottomAppBar(
              onHomeTap: () {},
              onFavoriteTap: () {
                Navigator.pushNamed(context, FavoritesScreen.routeName);
              },
              onProfileTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              onBookmarkTap: () {},
              onSearchTap: () {
                FocusScope.of(context).requestFocus(LabTestList.focusNode);
              },
            ),
          ),
          body: LabTestList(),
        ),
      ),
    );
  }

  void initilizeUSerData() async {
    readProfileData();
    checkAndShowInternetConnection(context);
    try {
      await AuthProvider().getUser(token);
      readProfileData();
    } catch (e) {
      //  errorSnackBar(context, SessionExperiedAlert);
      // await AuthProvider().logout();
      //  Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    }
  }

  readProfileData() async {
    token = await storage.read(key: 'token');
    name = await storage.read(key: 'name');
    email = await storage.read(key: 'email');

    profile = "name![0]";
  }
}
