class FAQModel {

  List<Map<String, FAQItem>> data = [];

  FAQModel({required this.data});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    List<Map<String, FAQItem>> parsedData = [];

    for (var outerList in json['data']) {        // data → list
      for (var innerMap in outerList) {          // inner list → map
        Map<String, FAQItem> faqMap = {};
        innerMap.forEach((key, value) {
          faqMap[key] = FAQItem.fromJson(value);
        });
        parsedData.add(faqMap);
      }
    }

    return FAQModel(data: parsedData);
  }

}

class FAQItem {
  int id;
  String question;
  String answer;
  String communityId;

  FAQItem({
    required this.id,
    required this.question,
    required this.answer,
    required this.communityId,
  });

  factory FAQItem.fromJson(Map<String, dynamic> json) {

    return FAQItem(
      id: json["Id"] ?? 0,
      question: json["question"] ?? "",
      answer: json["answer"] ?? "",
      communityId: json["communityId"] ?? "",
    );

  }

}
