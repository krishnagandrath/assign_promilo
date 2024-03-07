import 'package:assign_promilo/utils/image_utils.dart';
import 'package:flutter/material.dart';

class MeetupTabView extends StatelessWidget {
  final String image;
  final String label;
  const MeetupTabView({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: ImageUtils().errorBuilder,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black.withAlpha(150),
              Colors.black.withAlpha(100),
              Colors.black.withAlpha(50),
              Colors.transparent,
              Colors.transparent
            ])),
            child: const SizedBox.expand(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
