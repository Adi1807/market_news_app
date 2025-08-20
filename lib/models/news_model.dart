class NewsModel {
  String id;
  String title;
  String desc;
  String dateTimeString;
  String category;
  String timeTextString;
  late DateTime dateTime;

  NewsModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.dateTimeString,
    required this.category,
    required this.timeTextString,
  }) {
    dateTime = DateTime.parse(dateTimeString);
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['guid'],
      title: map['title'],
      desc: map['desc'],
      dateTimeString: map['date'],
      category: map['category'],
      timeTextString: map['timeText'],
    );
  }
}
