import 'package:flutter/material.dart';

class BottomRightClipper extends CustomClipper<Path> {
  const BottomRightClipper({required this.radius});
  final double radius;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(Offset(size.width, radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width, size.height / 3 * 2 - radius);
    path.arcToPoint(Offset(size.width - radius, size.height / 3 * 2),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(size.width / 3 * 2 + radius, size.height / 3 * 2);
    path.arcToPoint(Offset(size.width / 3 * 2, size.height / 3 * 2 + radius),
        radius: Radius.circular(radius), clockwise: false);
    path.lineTo(size.width / 3 * 2, size.height - radius);
    path.arcToPoint(Offset(size.width / 3 * 2 - radius, size.height),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(radius, size.height);
    path.arcToPoint(Offset(0, size.height - radius),
        clockwise: true, radius: Radius.circular(radius));
    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0),
        clockwise: true, radius: Radius.circular(radius));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
