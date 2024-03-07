import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/description_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          );
        }
        if (settings.name == '/descriptionPage') {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                const DescriptionPage(),
          );
        }
        return null;
      },
      routes: {'/': (context) => const LoginPage()},
    );
  }
}
