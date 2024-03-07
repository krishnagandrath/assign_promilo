import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  const SectionHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
            color: Color.fromARGB(255, 1, 11, 27),
            fontSize: 16.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

class TabIndexView extends StatelessWidget {
  const TabIndexView({
    super.key,
    required this.tabChangeNotifier,
    required this.onChange,
  });

  final ValueNotifier<int> tabChangeNotifier;
  final void Function(int index) onChange;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: tabChangeNotifier,
        child: const SizedBox.square(dimension: 8.0),
        builder: (context, value, child) {
          return SizedBox(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [0, 1, 2]
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: InkWell(
                          onTap: () => onChange(e),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tabChangeNotifier.value == e
                                  ? Colors.grey
                                  : Colors.grey.withAlpha(100),
                            ),
                            child: child,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
        });
  }
}
