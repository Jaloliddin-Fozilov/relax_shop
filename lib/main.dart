import 'package:flutter/material.dart';

import './styles/relax_app_style.dart';

import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = RelaxAppStyle().theme;
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
