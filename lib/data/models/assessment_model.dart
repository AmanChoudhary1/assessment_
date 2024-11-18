import 'dart:math';

class AssessmentModel {
  final String category;
  final String icon;
  final String quizzes;

  AssessmentModel(
      {required this.category, required this.icon, required this.quizzes});

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      category: json['category'],
      icon: json['icon'],
      quizzes: json['quizzes'],
    );
  }
}

class TopPickModel {
  final String title;
  final String subtitle;
  final String image;
  final String description;

  TopPickModel(
      {required this.title,
      required this.subtitle,
      required this.image,
      required this.description});

  factory TopPickModel.fromJson(Map<String, dynamic> json) {
    return TopPickModel(
      title: json['title'],
      subtitle: json['subtitle'],
      image: "${json['image']}${Random.secure().nextInt(1000)}",
      description: json['description'],
    );
  }
}

class RecentlyTakenModel {
  final String title;
  final String image;
  final String dateTaken;

  RecentlyTakenModel(
      {required this.title, required this.image, required this.dateTaken});

  factory RecentlyTakenModel.fromJson(Map<String, dynamic> json) {
    return RecentlyTakenModel(
      title: json['title'],
      image: "${json['image']}${Random.secure().nextInt(1000)}",
      dateTaken: json['date_taken'],
    );
  }
}
