class TrailerModel {
  String? name;
  String? key;
  String? site;
  String? type;
  bool? official;

  TrailerModel({
    this.name,
    this.key,
    this.site,
    this.type,
    this.official,
  });

  factory TrailerModel.fromJSON(Map<String, dynamic> map) {
    return TrailerModel(
      name: map['name'],
      key: map['key'],
      site: map['site'],
      type: map['type'],
      official: map['official'],
    );
  }
}