import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../../data/models/assessment_model.dart';

class TopPickItem extends StatelessWidget {
  final List<TopPickModel> topPicks;
  final Size screenSize;
  const TopPickItem(
      {super.key, required this.topPicks, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel.builder(
      options: FlutterCarouselOptions(
          showIndicator: true,
          slideIndicator: SequentialFillIndicator(
              slideIndicatorOptions: const SlideIndicatorOptions(
                  currentIndicatorColor: Colors.indigo,
                  itemSpacing: 30,
                  enableAnimation: true)),
          viewportFraction: 1,
          floatingIndicator: false,
          aspectRatio: 16 / 8.5),
      itemCount: topPicks.length,
      itemBuilder: (context, index, realIndex) {
        TopPickModel topPickModel = topPicks[index];
        return SizedBox(
          width: screenSize.width,
          child: Card(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: 0.8, color: Colors.black54),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Card(
                  margin: const EdgeInsets.only(left: 20),
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0)),
                      child: Image.network(
                        topPickModel.image,
                        height: 90,
                        width: 90,
                        errorBuilder: (e, i, s) => const SizedBox(),
                      )),
                ),
                SizedBox(
                  width: screenSize.width * 0.05,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        topPickModel.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: Colors.black),
                      ),
                      Text(
                        topPickModel.subtitle,
                        style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: screenSize.width * 0.01,
                      ),
                      Text(
                        topPickModel.description,
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.05,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
