import 'package:flutter/material.dart';
import '../../components/Loading.dart';
import '../../components/custom_drawer.dart';
import '../../models/abbreviation.dart';
import '../../services/lab_test_service/fetch_abbreviation.dart';
import '../../theme.dart';

import '../../global/colors.dart';
import '../../global/global.dart';
import '../../global/regExp.dart';

class AbbreviationScreen extends StatefulWidget {
  static const routeName = '/abbreviation-screen';
  const AbbreviationScreen({Key? key}) : super(key: key);

  @override
  State<AbbreviationScreen> createState() => _AbbreviationScreenState();
}

class _AbbreviationScreenState extends State<AbbreviationScreen> {
  var name;
  var profile;
  // late List<Abbrevaiton> abbrevaitons ;
  @override
  void initState() {
    readProfileData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'المختصرات الطبية',
          style: textTheme().displayLarge,
        ),
      ),
      endDrawer: CustomDrawer(),
      body: MyWidget(),
    );
  }

  readProfileData() async {
    // token = await storage.read(key: 'token');
    name = await storage.read(key: 'name');
    // email = await storage.read(key: 'email');

    profile = "name![0]";
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController searchController = TextEditingController();

  String search = '';
  ScrollController _scrollController = ScrollController();
  List<Abbrevaiton> _abbreviations = [];
  List<Abbrevaiton> _allAbbreviations = [];
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    _fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Fetch 50 items (replace with your actual fetch logic)
      List<Abbrevaiton> fetchedItems =
          await AbbreviationProvider().fetchAllAbbrevaitons();
      _allAbbreviations = fetchedItems;
      fetchedItems =
          await fetchAbbreviationsFromList(fetchedItems, _currentPage, 50);
      setState(() {
        _abbreviations.addAll(fetchedItems);
        _currentPage++;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child: Column(
        children: [
          TextFormField(
            onChanged: _onSearchFieldChanged,
            controller: searchController,
            style: textTheme().bodyLarge!.copyWith(color: TEXT_COLOR),
            decoration: InputDecoration(
              hintText: 'مختصر بالانكليزي',
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
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemCount: filteredList.length + 1,
              itemBuilder: (context, index) {
                if (index < filteredList.length) {
                  Abbrevaiton abbreviation = filteredList[index];

                  return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(1),
                    },
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                            color: abbreviation.id!.isOdd
                                ? Colors.white
                                : SECONDTITLECOLOR),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12,
                            ),
                            child: Text(
                              abbreviation.name!,
                              style: romanTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12,
                            ),
                            child: Text(
                              abbreviation.description!,
                              style: romanTextStyle,
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                } else if (_isLoading) {
                  return Center(child: InfiniteRotation());
                } else {
                  return Container(); // Placeholder for the end of the list
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchFieldChanged(String value) {
    setState(() {
      search = searchValidateRegExp(value);
    });
  }

  List get filteredList {
    if (search.isNotEmpty) {
      List list = _allAbbreviations
          .where(
              (item) => item.name!.toLowerCase().contains(search.toLowerCase()))
          .toList();

      return list;
    }
    return _abbreviations;
  }

  Future<List<Abbrevaiton>> fetchAbbreviationsFromList(
      List<Abbrevaiton> abbreviationList, int page, int pageSize) async {
    int startIndex = (page - 1) * pageSize;
    int endIndex = startIndex + pageSize;

    if (startIndex >= abbreviationList.length) {
      // Page is out of range
      return [];
    }

    if (endIndex > abbreviationList.length) {
      endIndex = abbreviationList.length;
    }

    return abbreviationList.sublist(startIndex, endIndex);
  }
}
