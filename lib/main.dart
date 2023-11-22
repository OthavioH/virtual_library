import 'package:flutter/material.dart';
import 'package:virtual_library/features/home/home_page_view.dart';
import 'package:virtual_library/features/tab_navigation_bar/tab_navigation_bar_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Library',
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, primary: Colors.black),
        useMaterial3: true,
      ),
      home: const TabNavigationBar(),
    );
  }
}
