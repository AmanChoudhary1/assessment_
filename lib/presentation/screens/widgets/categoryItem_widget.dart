import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String icon;
  final String title;
  final String quizzes;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.quizzes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 120,
          child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(width: 0.5, color: Colors.black87),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              color: Colors.white,
              shadowColor: Colors.indigo,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.network(
                  icon,
                  height: 50,
                  width: 50,
                ),
              )),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        Text(quizzes,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
      ],
    );
  }
}
