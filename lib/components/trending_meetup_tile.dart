import 'package:assign_promilo/utils/image_utils.dart';
import 'package:flutter/material.dart';

import '../utils/bottom_right_clipper.dart';

class TrendingMeetupTile extends StatelessWidget {
  final int index;
  const TrendingMeetupTile(
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.square(
        dimension: 200.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipPath(
              clipper: const BottomRightClipper(radius: 8.0),
              child: Hero(
                tag: 'descriptionHero$index',
                child: DecoratedBox(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  child: Image.asset(
                    'assets/stan_seed.jpeg',
                    fit: BoxFit.fill,
                    errorBuilder: ImageUtils().errorBuilder,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 5.0),
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
