import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../components/Loading.dart';
import '../../../global/colors.dart';
import '../../../global/global.dart';
import '../../../global/regExp.dart';
import '../../../models/test.dart';
import '../../../services/auth/auth_provider.dart';
import '../../../services/auth/check_user_auth.dart';
import '../../../services/general_services/check_internet_connectivity.dart';
import '../../../services/lab_test_service/fetch_test_and_favorite.dart';
import '../../../services/lab_test_service/filtered_test_service.dart';
import '../../../theme.dart';
import '../../favorite_test/favourite_screen.dart';
import '../../lab_test_view/lab_test_view2.dart';
import '../../profile/profile_screen.dart';
import '../drawer_listview.dart';
import 'bottomAppBar.dart';

class TestListView extends StatefulWidget {
  static FocusNode focusNode = FocusNode();
  static String routeName = '/Test_list';

  TestListView({Key? key}) : super(key: key);

  @override
  State<TestListView> createState() => _TestListViewState();
}

class _TestListViewState extends State<TestListView> {
  final _scrollController = ScrollController();

  RxBool isVisible = false.obs;
  final TextEditingController searchController = TextEditingController();
  String? token;

  String? name;

  String? email;
  String? search;
  String? profile;

  String? userId;
  bool _isLoading = false;
  List<String> _data = List.generate(50, (index) => 'Item $index');

  @override
  void initState() {
    print(profile);

    initilizeUSerData();
    _scrollController.addListener(_scrollListener);
    Provider.of<FavoriteProvider>(context, listen: false).initFavList(context);

    // Provider.of<ShowDialogProvider>(context, listen: false)
    //     .getisUpgradedAccountFromStorage();
    Future.delayed(Duration(milliseconds: 200));
    //getStoredTest();
    readToken(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  // void getStoredTest() async {
  //   email = await storage.read(key: 'email');

  //   await FavoriteProvider().readTests();
  // }

  Future<List<String>> getData() async {
    // Simulate a delay to fetch data from the server
    await Future.delayed(Duration(milliseconds: 200));
    return List.generate(30, (index) => 'Item ${_data.length + index}');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    // _nestedScrollController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible.value != false) {
        setState(() {
          isVisible.value = false;
        });
      }
    } else {
      if (isVisible.value != true) {
        setState(() {
          isVisible.value = true;
        });
      }
    }
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (_isLoading) return;
      _isLoading = true;
      getData().then((newData) {
        setState(() {
          _data.addAll(newData);
          _isLoading = false;
        });
      });
    }
  }

  void _onSearchFieldChanged(String value) {
    setState(() {
      search = searchValidateRegExp(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'التحاليل المخبرية الطبية',
          style: textTheme().displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: isVisible.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: isVisible.value ? double.maxFinite : 0,
                height: isVisible.value ? 100 : 0,
                child: TextFormField(
                  onChanged: _onSearchFieldChanged,
                  controller: searchController,
                  focusNode: TestListView.focusNode,
                  style: textTheme().bodyLarge!.copyWith(color: TEXT_COLOR),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن تحليل',
                    hintStyle:
                        textTheme().displaySmall!.copyWith(color: kPrimaryColr),
                    hintTextDirection: TextDirection.rtl,
                    suffixIcon: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: CircleAvatar(
                        backgroundColor: kPrimaryColr,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).copyWith(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20)),
                ),
              ),
            ),
            //const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                  future: readenFilteredTest(search),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("check your internet connection"));
                    } else if (snapshot.hasData) {
                      var list = snapshot.data as List<Test>;
                      return ListView.separated(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: filteredList.length < _data.length
                            ? filteredList.length
                            : _data.length + 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              LabTestView.routeName,
                              arguments: {
                                'id': list[index].id,
                                'name': list[index].titleEn,
                              }
                              //  TestViewModel(
                              //     testIndex, testName)
                              ,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      // IconButton(
                                      //   onPressed: () {},
                                      //   icon: Icon(Icons.lock),
                                      // ),
                                      SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          '${list[index].titleEn}',
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme()
                                              .bodyMedium!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child:
                                        Icon(Icons.arrow_forward_ios, size: 16))
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: InfiniteRotation());
                    }
                  }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      endDrawer: Drawer(
        width: 250,
        backgroundColor: Colors.white,
        child: Builder(
          builder: (context) {
            return SafeArea(
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
                                profile![0],
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
          },
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomBottomAppBar(
        onHomeTap: () {},
        onFavoriteTap: () {
          Navigator.pushNamed(context, FavoritesScreen.routeName);
        },
        onProfileTap: () {
          Navigator.pushNamed(context, ProfileScreen.routeName);
        },
        onBookmarkTap: () {},
        onSearchTap: () {
          if (isVisible.value != true) {
            setState(() {
              isVisible.value = true;
            });
            // FocusScope.of(context).requestFocus(TestListView.focusNode);
          }
        },
      ),
    );
  }

  readProfileData() async {
    token = await storage.read(key: 'token');
    name = await storage.read(key: 'name');
    email = await storage.read(key: 'email');

    profile = name![0];
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
}

class MyTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
