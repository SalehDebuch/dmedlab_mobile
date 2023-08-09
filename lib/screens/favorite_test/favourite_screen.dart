import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../components/custom_drawer.dart';
import '../../models/test.dart';
import 'package:provider/provider.dart';

import '../../global/colors.dart';
import '../../global/global.dart';
import '../../global/regExp.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/auth/check_user_auth.dart';
import '../../services/general_services/check_internet_connectivity.dart';
import '../../services/lab_test_service/fetch_test_and_favorite.dart';
import '../../theme.dart';
import '../lab_test_view/lab_test_view2.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorite-screen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var name;

  var profile;
  @override
  void initState() {
    super.initState();
    readProfileData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  // final storageServices = StorageServices();
  @override
  Widget build(BuildContext context) {
    final favProvider = FavoriteProvider.of(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'المفضلة',
            style: textTheme().displayLarge!,
          ),
        ),
        body: FutureBuilder(
          future: favProvider.favoriteTests(),
          builder: (context, snapshot) {
            Get.log(snapshot.data.toString());
            if (snapshot.hasData) {
              final favoritList = snapshot.data as List<Test>;
              if (favoritList.isEmpty) {
                return Center(
                    child: Text(
                  EmptyFavoriteTest,
                  style: textTheme().displayLarge!.copyWith(color: TEXT_COLOR),
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text(kInternetConnectionErrorr));
              }

              return FavorList(favoritList: favoritList);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        endDrawer: CustomDrawer());
  }

  readProfileData() async {
    // token = await storage.read(key: 'token');
    name = await storage.read(key: 'name');
    // email = await storage.read(key: 'email');

    profile = name![0];
  }
}

class FavorList extends StatefulWidget {
  final List<Test> favoritList;
  const FavorList({
    Key? key,
    required this.favoritList,
  }) : super(key: key);

  @override
  State<FavorList> createState() => _FavorListState();
}

class _FavorListState extends State<FavorList> {
  final _scrollController = ScrollController();

  bool isVisible = false;
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
    initilizeUSerData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _scrollController.addListener(_scrollListener);
    Provider.of<FavoriteProvider>(context, listen: false).initFavList(context);

    // Provider.of<ShowDialogProvider>(context, listen: false)
    //     .getisUpgradedAccountFromStorage();
    Future.delayed(Duration(milliseconds: 200));
    //getStoredTest();
    readToken(context);

    super.initState();
  }

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
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisible != false) {
        setState(() {
          isVisible = false;
        });
      }
    } else {
      if (isVisible != true) {
        setState(() {
          isVisible = true;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: isVisible ? double.maxFinite : 0,
              height: isVisible ? 100 : 0,
              child: TextFormField(
                onChanged: _onSearchFieldChanged,
                controller: searchController,
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
          const SizedBox(height: 20),
          Expanded(
              child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: widget.favoritList.length < _data.length
                ? widget.favoritList.length
                : _data.length + 1,
            // shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                Navigator.pushNamed(
                  context,
                  LabTestView.routeName,
                  arguments: {
                    'id': widget.favoritList[index].id,
                    'name': widget.favoritList[index].titleEn,
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
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.lock)),
                        Text(
                          '${widget.favoritList[index].titleEn}',
                          style: textTheme()
                              .bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.arrow_forward_ios, size: 16))
                  ],
                ),
              ),
            ),
          )),
          const SizedBox(height: 20),
        ],
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


// SALEH
// ListView.builder(
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: favoritList.length,
//                   itemBuilder: (context, index) {
//                     String testIndex = favoritList[index].id.toString();
//                     int? testId = favoritList[index].id;
//                     bool isUpgradedAccount = dialogProvider.isUpgradedAccount;

//                     bool isLocked = isUpgradedAccount == true
//                         ? false
//                         : favoritList[index].isLockedBool;

//                     bool isFavorite = favProvider.isExist(testId!);
//                     String? selectedLanguage = testProvider.selectedLanguage;

//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
//                       child: Container(
//                         child: Card(
//                           elevation: 3,
//                           child: Directionality(
//                             textDirection: selectedLanguage == 'ar'
//                                 ? TextDirection.rtl
//                                 : TextDirection.ltr,
//                             child: ListTile(
//                               title: GestureDetector(
//                                 onTap: () {
//                                   String testName =
//                                       favoritList[index].titleEn.toString();
//                                   if (isLocked == false) {
//                                     Navigator.pushNamed(
//                                       context,
//                                       LabTestView.routeName,
//                                       arguments:
//                                           TestViewModel(testIndex, testName),
//                                     );
//                                   } else {
//                                     dialogProvider
//                                         .showLockedTestDialog(context);
//                                   }
//                                 },
//                                 child: Text(
//                                   testProvider.getTestName(favoritList[index]),
//                                 ),
//                               ),
//                               leading: IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: () async {
//                                   favProvider
//                                       .toggleFavorite(int.parse(testIndex));
//                                   String? userId =
//                                       await storageServices.getUserID();
//                                   if (userId != null) {
//                                     await PostFavoriteTestService()
//                                         .postFavoriteTest(userId, testIndex,
//                                             !isFavorite, context);
//                                   }
//                                 },
//                               ),
//                               contentPadding:
//                                   EdgeInsets.only(left: 1.0, right: 10.0),
//                               trailing: isLocked == true
//                                   ? IconButton(
//                                       onPressed: () {
//                                         dialogProvider
//                                             .showLockedTestDialog(context);
//                                       },
//                                       icon: Icon(Icons.lock))
//                                   : SizedBox(width: 0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   });
            