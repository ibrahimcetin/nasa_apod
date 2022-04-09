class ApodModel {
  String title;
  String explanation;
  String imageUrlHD;
  String imageUrl;
  String date;
  String copyright;

  ApodModel({
    required this.title,
    required this.explanation,
    required this.imageUrlHD,
    required this.imageUrl,
    required this.date,
    required this.copyright,
  });

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      title: json["title"],
      explanation: json["explanation"],
      imageUrlHD: json["hdurl"],
      imageUrl: json["url"],
      date: json["date"],
      copyright: json["copyright"] ?? 'Public Domain',
    );
  }
}
