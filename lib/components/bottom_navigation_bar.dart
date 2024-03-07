import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: {
          'home': Icons.home_outlined,
          'Prolet': Icons.apps_outlined,
          'Meetup': Icons.handshake,
          'Explore': Icons.search,
          'Account': Icons.person_outline
        }
            .entries
            .map((e) => BottomNavigationBarItem(
                icon: Icon(
                  e.value,
                ),
                label: e.key))
            .toList());
  }
}
