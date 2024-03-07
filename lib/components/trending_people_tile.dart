import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingData {
  final String icon;
  final String author;
  final int meetups;

  TrendingData(
      {required this.icon, required this.author, required this.meetups});
}

class TrendingPeopleTile extends StatelessWidget {
  final TrendingData data;
  const TrendingPeopleTile({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color.fromARGB(183, 158, 158, 158),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 14, 43, 86))),
                    child: SizedBox.square(
                      dimension: 45.0,
                      child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(
                              'assets/icons/${data.icon}.svg')),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.author,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 14, 43, 86),
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              '${data.meetups} Meetups',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(227, 158, 158, 158)
                                          .withAlpha(160),
                                  fontSize: 12.0),
                            )
                          ]))
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Divider(
                      color: const Color.fromARGB(255, 158, 158, 158)
                          .withAlpha(100),
                      thickness: 1.0),
                ),
                Row(
                  children: [1, 2, 3, 4, 5]
                      .map((e) => Transform.translate(
                            offset: e != 1
                                ? Offset((-5 * e).toDouble(), 0)
                                : Offset.zero,
                            child: ClipOval(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2.0,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                    )),
                                child: Center(
                                  child: SizedBox.square(
                                    dimension: 35.0,
                                    child: Image.asset(
                                      'assets/meetup_${(e % 3) + 1}.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  width: 300.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                            color: const Color.fromARGB(255, 29, 64, 93),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0)),
                            onPressed: () {},
                            child: const Text(
                              "See more",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.0),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
