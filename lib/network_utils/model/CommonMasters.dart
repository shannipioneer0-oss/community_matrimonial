

class Commonmasters {
  final int success;
  final List<CommonmastersGroup> data;

  Commonmasters({required this.success, required this.data});

  factory Commonmasters.fromJson(Map<String, dynamic> json) {
    return Commonmasters(
      success: json['success'],
      data: (json['data'] as List<dynamic>)
          .map((e) => CommonmastersGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class CommonmastersGroup {
  final List<DietOption> items;

  CommonmastersGroup({required this.items});

  factory CommonmastersGroup.fromJson(Map<String, dynamic> json) {
    return CommonmastersGroup(
      items: json.values
          .map((item) => DietOption.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DietOption {

  final int id;
  final dynamic value;
  final String label;
  final String communityId;

  DietOption({
    required this.id,
    required this.value,
    required this.label,
    required this.communityId,
  });

  factory DietOption.fromJson(Map<String, dynamic> json) {
    return DietOption(
      id: json['id'] ?? 0,
      value: json['value'],
      label: json['label'],
      communityId: json['communityId'] ?? "",
    );
  }

}