// standard.dart
class Standard {
  int? standardId;
  String name;

  Standard({this.standardId, required this.name});

  factory Standard.fromJson(Map<String, dynamic> json) {
    return Standard(
      standardId: json['standardId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'standardId': standardId,
      'name': name,
    };
  }
}
