import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/lab_test_service/fetch_test_and_favorite.dart';
import '../../services/dialog_service/show_upgrade_dialog.dart';
import '../../components/Loading.dart';
import '../../global/regExp.dart';
import '../../models/test.dart';
import '../../services/auth/check_user_auth.dart';
import '../../services/lab_test_service/switch_test_title_provider.dart';
import '../../services/lab_test_service/filtered_test_service.dart';
import '../../services/lab_test_service/post_favorite_test.dart';
import '../../services/storage_service/storage_service.dart';
import '../lab_test_view/lab_test_view2.dart';
import 'custom_search_field.dart';

class LabTestList extends StatefulWidget {
  static FocusNode focusNode = FocusNode();
  @override
  _LabTestListState createState() => _LabTestListState();
}

class _LabTestListState extends State<LabTestList> {
  final _scrollController = ScrollController();
  final _nestedScrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  String? search;
  String? userId;

  bool _isLoading = false;
  List<String> _data = List.generate(50, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<FavoriteProvider>(context, listen: false).initFavList(context);

    // Provider.of<ShowDialogProvider>(context, listen: false)
    //     .getisUpgradedAccountFromStorage();
    Future.delayed(Duration(milliseconds: 200));
    //getStoredTest();
    readToken(context);
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
    _nestedScrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
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

  // void getStoredTest() async {
  //   email = await storage.read(key: 'email');

  //   await FavoriteProvider().readTests();
  // }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = FavoriteProvider.of(context);
    final testProvider = TestListProvider.of(context);
    final dialogprovider = ShowDialogProvider.of(context);
    return Container(
      child: Column(
        children: [
          CustomSearchField(
            controller: searchController,
            onChanged: _onSearchFieldChanged,
            focusNode: LabTestList.focusNode,
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 2,
          ),
          FutureBuilder(
            future: readenFilteredTest(search),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(child: InfiniteRotation());
              } else if (data.hasError) {
                return Center(child: Text("check your internet connection"));
              } else if (data.hasData) {
                filteredList = data.data as List<Test>;

                return Expanded(
                  child: Scrollbar(
                    controller: _scrollController,
                    radius: Radius.circular(10),
                    thumbVisibility: false,
                    thickness: 5,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredList.length < _data.length
                          ? filteredList.length
                          : _data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _data.length) {
                          return _buildLoadingIndicator();
                        }

                        String testName =
                            filteredList[index].titleEn.toString();
                        String testIndex = filteredList[index].id.toString();
                        int? testId = filteredList[index].id;

                        final showDialogProvider = ShowDialogProvider();
                        bool isUpgradedAccount =
                            dialogprovider.isUpgradedAccount;

                        bool isLocked = isUpgradedAccount == false
                            ? false
                            : filteredList[index].isLockedBool;

                        bool isFavorite = favProvider.isExist(testId!);
                        String? selectedLanguage =
                            TestListProvider.of(context).selectedLanguage;

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
                          child: Container(
                            child: Card(
                              elevation: 3,
                              child: Directionality(
                                textDirection: selectedLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: ListTile(
                                  title: InkWell(
                                    onTap: () async {
                                      if (isLocked == false) {
                                        Navigator.pushNamed(
                                          context,
                                          LabTestView.routeName,
                                          arguments: {
                                            'id': testId,
                                            'name': testName,
                                          }
                                          //  TestViewModel(
                                          //     testIndex, testName)
                                          ,
                                        );
                                      } else {
                                        showDialogProvider
                                            .showLockedTestDialog(context);
                                      }
                                    },
                                    child: Text(
                                      (testProvider
                                          .getTestName(filteredList[index])),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  leading: IconButton(
                                    icon: favProvider
                                            .isExist(int.parse(testIndex))
                                        ? Icon(Icons.favorite,
                                            color: Colors.red)
                                        : Icon(Icons.favorite_border),
                                    onPressed: () async {
                                      favProvider
                                          .toggleFavorite(int.parse(testIndex));
                                      String? userId =
                                          await StorageServices().getUserID();
                                      if (userId != null) {
                                        await PostFavoriteTestService()
                                            .postFavoriteTest(userId, testIndex,
                                                !isFavorite, context);
                                      }
                                    },
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 1.0, right: 10.0),
                                  trailing: isLocked == true
                                      ? IconButton(
                                          onPressed: () {
                                            showDialogProvider
                                                .showLockedTestDialog(context);
                                          },
                                          icon: Icon(Icons.lock),
                                        )
                                      : SizedBox(width: 0),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
