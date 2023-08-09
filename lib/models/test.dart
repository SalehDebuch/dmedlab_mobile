class Test {
  int? id;
  String? titleAr;
  String? titleEn;
  String? titleFr;
  String? titleDe;
  String? key;
  int? isLocked;

  List<Detail>? details;
  List<TestTube>? testTubes;
  List<TestOtherName>? testOtherNames;
  List<RelatedTest>? relatedTests;

  Test({
    this.id,
    this.titleAr,
    this.titleEn,
    this.titleFr,
    this.titleDe,
    this.isLocked,
    this.key,
    this.details,
    this.testTubes,
    this.testOtherNames,
    this.relatedTests,
  });
  bool get isLockedBool => isLocked == 1;
  @override
  String toString() {
    return '{id: $id, nameAr: $titleAr, nameEn: $titleEn, nameFr: $titleFr, '
        'nameDe: $titleDe, isLocked: $isLocked, details: $details, testTubes: $testTubes, '
        'testOtherNames: $testOtherNames, relatedTests: $relatedTests, searchKeywords: $key}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name_ar': titleAr,
      'name_en': titleEn,
      'name_fr': titleFr,
      'name_de': titleDe,
      'search_keywords': key,
      'is_locked': isLocked,
      'details': details?.map((detail) => detail.toJson()).toList(),
      'test_tubes': testTubes?.map((testTube) => testTube.toJson()).toList(),
      'test_other_names': testOtherNames
          ?.map((testOtherName) => testOtherName.toJson())
          .toList(),
      'related_tests':
          relatedTests?.map((relatedTest) => relatedTest.toJson()).toList(),
    };
    return data;
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json['id'],
      titleAr: json['name_ar'],
      titleEn: json['name_en'],
      titleFr: json['name_fr'],
      titleDe: json['name_de'],
      key: json['search_keywords'],
      isLocked: json['is_locked'],
      details: (json['details'] as List<dynamic>?)
          ?.map((x) => Detail.fromJson(x))
          .toList(),
      testTubes: (json['test_tubes'] as List<dynamic>?)
          ?.map((x) => TestTube.fromJson(x))
          .toList(),
      testOtherNames: (json['test_other_names'] as List<dynamic>?)
          ?.map((x) => TestOtherName.fromJson(x))
          .toList(),
      relatedTests: (json['related_tests'] as List<dynamic>?)
          ?.map((x) => RelatedTest.fromJson(x))
          .toList(),
    );
  }
}

class Detail {
  int? id;
  int? testId;
  int? parentId;
  int? languageId;
  int? inputType;
  int? isBold;
  String? title;
  String? indentation;
  String? align;
  String? content;
  int? order;
  List<Detail>? children;

  Detail({
    this.id,
    this.testId,
    this.parentId,
    this.languageId,
    this.isBold,
    this.inputType,
    this.title,
    this.indentation,
    this.align,
    this.content,
    this.order,
    this.children,
  });

  @override
  String toString() {
    return '{id: $id, testId: $testId, parentId: $parentId, languageId: $languageId, '
        'inputType: $inputType,isBold:$isBold, title: $title, indentation: $indentation, align: $align, '
        'content: $content, children: $children, order: $order}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'test_id': testId,
      'parent_id': parentId,
      'language_id': languageId,
      'is_bold': isBold,
      'input_type': inputType,
      'title': title,
      'indentation': indentation,
      'align': align,
      'content': content,
      'order': order,
      'children': children?.map((detail) => detail.toJson()).toList(),
    };
    return data;
  }

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      testId: json['test_id'],
      parentId: json['parent_id'],
      languageId: json['language_id'],
      isBold: json['is_bold'],
      inputType: json['input_type'],
      title: json['title'],
      indentation: json['indentation'],
      align: json['align'],
      content: json['content'],
      order: json['order'],
      children: (json['children'] as List<dynamic>?)
          ?.map((x) => Detail.fromJson(x))
          .toList(),
    );
  }
}

class TestTube {
  int? id;
  int? testId;
  int? tubeId;
  String? colorName;
  String? tubeName;
  String? color;
  int? languageId;

  TestTube({
    this.id,
    this.testId,
    this.tubeId,
    this.colorName,
    this.tubeName,
    this.color,
    this.languageId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'test_id': testId,
      'tube_id': tubeId,
      'tube_color': colorName,
      'tube_name': tubeName,
      'color': color,
      'language_id': languageId,
    };
    return data;
  }

  factory TestTube.fromJson(Map<String, dynamic> json) {
    return TestTube(
      id: json['id'],
      testId: json['test_id'],
      tubeId: json['tube_id'],
      colorName: json['tube_color'],
      tubeName: json['tube_name'],
      color: json['color'],
      languageId: json['language_id'],
    );
  }
}

class TestOtherName {
  int? id;
  int? languageId;
  String? name;
  int? order;
  int? testId;

  TestOtherName({
    this.id,
    this.languageId,
    this.name,
    this.order,
    this.testId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'language_id': languageId,
      'name': name,
      'order': order,
      'test_id': testId,
    };
    return data;
  }

  factory TestOtherName.fromJson(Map<String, dynamic> json) {
    return TestOtherName(
      id: json['id'],
      languageId: json['language_id'],
      name: json['name'],
      order: json['order'],
      testId: json['test_id'],
    );
  }
}

class RelatedTest {
  RelatedTest.fromJson(Map<String, dynamic> json) {
    // Implement the JSON deserialization for the related test if available
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      // Add the properties to be serialized
      // Example: 'id': id, 'name': name, etc.
    };
    return data;
  }
}
