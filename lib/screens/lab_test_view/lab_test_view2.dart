import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../components/Loading.dart';
import '../../global/colors.dart';
import '../../models/test.dart';
import '../../services/lab_test_service/fetch_test_and_favorite.dart';
import '../../theme.dart';

// ignore: must_be_immutable
class LabTestView extends StatelessWidget {
  static const String routeName = '/LabTestView';

  final List<Map> detailsList = [
    {
      'section': 'التعريف',
      'index': 0,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'النموذج',
      'index': 1,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'الحفظ',
      'index': 2,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'طرق القياس',
      'index': 3,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'القيم المرجعية',
      'index': 4,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'تحويل الواحدات',
      'index': 5,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'يزيد',
      'index': 6,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'ينقص',
      'index': 7,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
    {
      'section': 'اختبارات ذات الصلة',
      'index': 8,
      'elementList': <Widget>[],
      'isOpen': false.obs
    },
  ];

  final List<TestOtherName> testOtherName = [];

  List<TestTube> testTubes = [];

  String arabicTitle = '';

  RxBool isOpen = false.obs;
  ScrollController _scrollController = ScrollController();
  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   testOtherName.clear();
  //   testTubes.clear();
  //   detailsList.map((e) => e['elementList'].clear()).toList();
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    final favProvider = FavoriteProvider.of(context, listen: false);
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => favProvider.toggleFavorite(args['id']),
              icon: Builder(builder: (context) {
                return Icon(FavoriteProvider.of(context).isExist(args['id'])
                    ? Icons.star
                    : Icons.star_border);
              }))
        ],
        title: Text(
          args['name'],
          style: textTheme().bodyMedium,
        ),
      ),
      body: InteractiveViewer(
        child: FutureBuilder(
          future: setElements(args['id']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: InfiniteRotation());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                controller: _scrollController,
                // physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // ClipPath(
                    //   clipper: WaveClipperOne(flip: true),
                    // child:
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 5, left: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              arabicTitle,
                              softWrap: true,
                              textDirection: TextDirection.rtl,
                              style: testBoldStyle.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // const Divider(thickness: 2, indent: 50, endIndent: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: testTubes
                                .map((e) => Text(
                                      e.tubeName!,
                                      style: textTheme().displaySmall!.copyWith(
                                          color: parseColor(e.colorName ?? '')),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    // ),

                    Accordion(
                      disableScrolling: true,
                      openAndCloseAnimation: true,
                      headerBorderRadius: 50.0,
                      // maxOpenSections: 10,
                      // headerBackgroundColorOpened: THIRDTITLECOLOR,
                      scaleWhenAnimating: false,
                      headerPadding: EdgeInsets.all(15),
                      contentBorderColor: SECONDTITLECOLOR,
                      headerBackgroundColor: SECONDTITLECOLOR,
                      children: [
                        AccordionSection(
                            contentBorderWidth: 3,
                            flipRightIconIfOpen: false,
                            onOpenSection: () async => isOpen.value = true,
                            onCloseSection: () {
                              isOpen.value = false;
                            },
                            leftIcon: Obx(
                              () => SvgPicture.asset(
                                  isOpen.value
                                      ? 'assets/images/down_arrow.svg'
                                      : 'assets/images/right_arrow.svg',
                                  width: 20),
                            ),
                            rightIcon: Text('المسميات الأخرى',
                                style: textTheme()
                                    .bodyMedium!
                                    .copyWith(color: Colors.black)),
                            header: SizedBox(),
                            content: Column(
                                children: getSortedTestOtherNames(testOtherName)
                                    .map((e) {
                              List<String> names = createDashSymbol(e.name!);
                              String lang = getLanguageById(e.languageId!);
                              return ListTile(
                                title: Text(
                                  '$lang:',
                                  style: textTheme()
                                      .bodyLarge!
                                      .copyWith(color: Colors.black),
                                ),
                                subtitle: Column(
                                  children: names.map((e2) {
                                    List<SingleChildRenderObjectWidget>
                                        rowChildren = [
                                      Baseline(
                                        baseline: 15,
                                        baselineType: TextBaseline.alphabetic,
                                        child: SvgPicture.asset(
                                            'assets/images/dash.svg'),
                                      ),
                                      const SizedBox(width: 5),
                                      Baseline(
                                        baseline: 20,
                                        baselineType: TextBaseline.alphabetic,
                                        child: Text(
                                          e2,
                                          textDirection: lang == 'Arabic'
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          style: testStyle.copyWith(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ];
                                    return Row(
                                      mainAxisAlignment: lang == 'Arabic'
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: lang == 'Arabic'
                                          ? rowChildren.reversed.toList()
                                          : rowChildren,
                                    );
                                  }).toList(),
                                ),
                              );
                            }).toList())),
                        ...detailsList.asMap().entries.map((element) {
                          var index = element.key;
                          var e = element.value;
                          return AccordionSection(
                              contentBorderWidth: 3,
                              onOpenSection: () async {
                                Orientation orientations =
                                    MediaQuery.of(context).orientation;
                                e['isOpen'].value = true;

                                await _scrollController.animateTo(
                                  orientations == Orientation.portrait
                                      ? index * 50
                                      : index * 100,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubicEmphasized,
                                );
                              },
                              onCloseSection: () async {
                                e['isOpen'].value = false;
                              },
                              leftIcon: Obx(
                                () => SvgPicture.asset(
                                    e['isOpen'].value
                                        ? 'assets/images/down_arrow.svg'
                                        : 'assets/images/right_arrow.svg',
                                    width: 20),
                              ),
                              flipRightIconIfOpen: false,
                              header: SizedBox(),
                              rightIcon: Text(e['section'],
                                  style: textTheme()
                                      .bodyMedium!
                                      .copyWith(color: Colors.black)),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: e['elementList'],
                                ),
                              ));
                        }).toList()
                      ],
                    ),

                    // ClipPath(
                    //   clipper: WaveClipperTwo(reverse: true),
                    //   child: Container(
                    //     height: 80,
                    //     width: double.infinity,
                    //     color: kPrimaryColr,
                    //   ),
                    // ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

// Text(
//                                             addSymbolAfterNewLine(e.name!, '-'),
//                                             textDirection: getLanguageById(
//                                                         e.languageId!) ==
//                                                     'Arabic'
//                                                 ? TextDirection.rtl
//                                                 : TextDirection.ltr,
//                                             style: testStyle.copyWith(
//                                                 color: Colors.black),
//                                           )

  Future<void> setElements(int id) async {
    testOtherName.clear();
    testTubes.clear();
    detailsList.map((e) => e['elementList'].clear()).toList();
    // Test test = await FavoriteProvider().readTest(id.toString());
    Test test = await FavoriteProvider().fetchTest(id);
    arabicTitle = test.titleAr!;
    testTubes = test.testTubes!;

    test.testOtherNames!.map((e) => testOtherName.add(e)).toList();

    test.details!.map((e) {
      Map section =
          detailsList.firstWhere((element) => element['section'] == e.title);
      if (e.inputType == 1) {
        section['elementList'].add(Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(e.content!,
                style: e.isBold == 0 ? testStyle : testBoldStyle)));
        if (e.children!.isNotEmpty) {
          e.children!.map((e2) {
            if (e2.inputType == 1) {
              section['elementList'].add(Container(
                child: Text(e2.content!,
                    style: e2.isBold == 0 ? testStyle : testBoldStyle),
                margin: const EdgeInsets.only(right: 15),
              ));
            } else if (e2.inputType == 2) {
              section['elementList'].add(Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: e2.content!.split('\n').map(
                      (e3) {
                        if (e3.startsWith('**')) {
                          return Text(e3.substring(2),
                              style:
                                  e2.isBold == 0 ? testStyle : testBoldStyle);
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Baseline(
                              baseline: 20,
                              baselineType: TextBaseline.alphabetic,
                              child: SvgPicture.asset(
                                  'assets/images/${getCertainIcon(e2.indentation!)}.svg'),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Baseline(
                                baseline: 20,
                                baselineType: TextBaseline
                                    .alphabetic, // Set the baseline type to match the textBaseline
                                child: Text(
                                  e3,
                                  style: e2.isBold == 0
                                      ? testStyle
                                      : testBoldStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList()),
                margin: const EdgeInsets.only(right: 15),
              ));
            } else if (e2.inputType == 3) {
              section['elementList'].add(Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ZoomableImage(imageUrl: e2.content!)));
            }
          }).toList();
        }
        // print(section);
      } else if (e.inputType == 2) {
        section['elementList'].add(
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: e.content!.split('\n').map(
                (e3) {
                  if (e3.startsWith('**')) {
                    return Text(e3.substring(2),
                        style: e.isBold == 0 ? testStyle : testBoldStyle);
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Baseline(
                          baseline: 20,
                          baselineType: TextBaseline.alphabetic,
                          child: SvgPicture.asset(
                              'assets/images/${getCertainIcon(e.indentation!)}.svg'),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Baseline(
                            baseline: 20,
                            baselineType: TextBaseline
                                .alphabetic, // Set the baseline type to match the textBaseline
                            child: Text(
                              e3,
                              style: e.isBold == 0 ? testStyle : testBoldStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList()),
        );

        if (e.children!.isNotEmpty) {
          e.children!.map((e2) {
            if (e2.inputType == 1) {
              section['elementList'].add(Container(
                child: Text(e2.content!,
                    style: e2.isBold == 0 ? testStyle : testBoldStyle),
                margin: const EdgeInsets.only(right: 15),
              ));
            } else if (e2.inputType == 2) {
              section['elementList'].add(Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: e2.content!.split('\n').map(
                      (e3) {
                        if (e3.startsWith('**')) {
                          return Text(e3.substring(2),
                              style:
                                  e2.isBold == 0 ? testStyle : testBoldStyle);
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Baseline(
                              baseline: 20,
                              baselineType: TextBaseline.alphabetic,
                              child: SvgPicture.asset(
                                  'assets/images/${getCertainIcon(e2.indentation!)}.svg'),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Baseline(
                                baseline: 20,
                                baselineType: TextBaseline
                                    .alphabetic, // Set the baseline type to match the textBaseline
                                child: Text(
                                  e3,
                                  style: e2.isBold == 0
                                      ? testStyle
                                      : testBoldStyle,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList()),
                //  Row(
                //   crossAxisAlignment: CrossAxisAlignment.baseline,
                //   textBaseline: TextBaseline.alphabetic,
                //   children: [
                //     Baseline(
                //       baseline: 20,
                //       baselineType: TextBaseline.alphabetic,
                //       child: SvgPicture.asset(
                //           'assets/images/${getCertainIcon(e2.indentation!)}.svg'),
                //     ),
                //     SizedBox(width: 10),
                //     Flexible(
                //       child: Baseline(
                //         baseline: 20,
                //         baselineType: TextBaseline
                //             .alphabetic, // Set the baseline type to match the textBaseline
                //         child: Text(
                //           e2.content!,
                //           style: checkPoint(e2.indentation!)
                //               ? testBoldStyle
                //               : testStyle,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                margin: const EdgeInsets.only(right: 15),
              ));
            } else if (e2.inputType == 3) {
              section['elementList'].add(Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ZoomableImage(imageUrl: e2.content!)));
            }
          }).toList();
        }
      } else if (e.inputType == 3) {
        section['elementList'].add(Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            constraints: BoxConstraints(maxHeight: 200),
            child: ZoomableImage(imageUrl: e.content!)));
        if (e.children!.isNotEmpty) {
          e.children!.map((e2) {
            if (e2.inputType == 1) {
              section['elementList'].add(Container(
                  child: Text(e2.content!,
                      style: e2.isBold == 0 ? testStyle : testBoldStyle),
                  margin: const EdgeInsets.only(right: 15)));
            } else if (e2.inputType == 2) {
              section['elementList'].add(Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: e2.content!.split('\n').map(
                        (e3) {
                          if (e3.startsWith('**')) {
                            return Text(e3.substring(2),
                                style:
                                    e2.isBold == 0 ? testStyle : testBoldStyle);
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Baseline(
                                baseline: 20,
                                baselineType: TextBaseline.alphabetic,
                                child: SvgPicture.asset(
                                    'assets/images/${getCertainIcon(e2.indentation!)}.svg'),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Baseline(
                                  baseline: 20,
                                  baselineType: TextBaseline
                                      .alphabetic, // Set the baseline type to match the textBaseline
                                  child: Text(
                                    e3,
                                    style: e2.isBold == 0
                                        ? testStyle
                                        : testBoldStyle,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList()),
                  margin: const EdgeInsets.only(right: 15)));
            } else if (e2.inputType == 3) {
              section['elementList'].add(Container(
                  constraints: BoxConstraints(maxHeight: 200),
                  child: ZoomableImage(imageUrl: e2.content!)));
            }
          }).toList();
        }
      } else if (e.inputType == 4) {
        section['elementList'].add(Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 247, 211, 1),
            border: Border.all(color: Color.fromRGBO(255, 202, 3, 1)),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '!ملاحظة:',
                style: textTheme()
                    .displayMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(e.content!, style: e.isBold == 1 ? testBoldStyle : testStyle)
            ],
          ),
        ));
      }
    }).toList();
  }

  String addSymbolAfterNewLine(String text, String symbol) {
    List<String> lines = text.split('\n');
    List<String> modifiedLines = lines.map((line) => "$symbol$line").toList();
    return modifiedLines.join('\n');
  }

  List<String> createDashSymbol(String text) {
    List<String> list = [];
    List<String> lines = text.split('\n');
    lines.map((e) => list.add(e)).toList();
    return list;
  }

  List<TestOtherName> getSortedTestOtherNames(List<TestOtherName> list) {
    int index = list.indexWhere((element) => element.languageId == 1);
    if (index == -1) {
      return list;
    }

    TestOtherName item = list[index];
    list.removeAt(index);
    list.add(item);
    return list;
  }

  String getLanguageById(int id) {
    late String word;
    switch (id) {
      case 1:
        word = 'Arabic';
        break;
      case 2:
        word = 'English';
        break;
      case 3:
        word = 'French';
        break;
      case 4:
        word = 'Deutsch';
        break;
    }
    return word;
  }

  String getCertainIcon(String indentation) {
    late String icon;
    if (indentation == '▽') {
      icon = 'dec';
    } else if (indentation == '∆') {
      icon = 'inc';
    } else if (indentation == '-') {
      icon = 'dash';
    } else if (indentation == '•') {
      icon = 'point';
    } else if (indentation == '∆ ∆') {
      icon = 'inc+';
    } else if (indentation == '▽ ▽') {
      icon = 'dec+';
    }
    return icon;
  }

  bool checkPoint(String indentation) {
    if (indentation == '•') {
      return true;
    }
    return false;
  }

  Color parseColor(String hexCode) {
    try {
      return hexCode.isEmpty
          ? Colors.black
          : Color(int.parse(hexCode.substring(1), radix: 16) + 0xFF000000);
    } catch (e) {
      return Color(0xFFCCCCCC);
    }
  }
}

class ZoomableImage extends StatefulWidget {
  final String imageUrl;

  ZoomableImage({required this.imageUrl});

  @override
  _ZoomableImageState createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  bool isZoomed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isZoomed = !isZoomed;

        if (isZoomed) {
          _openZoomedInImage(context);
        }
      },
      child: Center(
        child: Image.network(widget.imageUrl),
      ),
    );
  }

  void _openZoomedInImage(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme:
                  IconThemeData().copyWith(color: Colors.black, size: 30),
            ),
            body: Center(
              child: PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.white),
                imageProvider: NetworkImage(widget.imageUrl),
              ),
            ),
          );
        },
      ),
    );
  }
}
