import 'package:flutter/material.dart';

class RecentlyTakenItem extends StatelessWidget {
  final String image;
  final String title;
  final String dateTaken;
  final Size screenSize;

  const RecentlyTakenItem(
      {super.key,
      required this.image,
      required this.title,
      required this.dateTaken,
      required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 45,
            backgroundColor: Colors.grey.shade100,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(image),
            ),
          ),
          SizedBox(height: screenSize.width * 0.04),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenSize.width * 0.02),
          FilledButton(
              style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(25, 25)),
                  backgroundColor: WidgetStateProperty.all(Colors.indigo)),
              onPressed: () {},
              child: const Text(
                "Result",
                style: TextStyle(fontSize: 12.0),
              )),
        ],
      ),
    );
  }
}
