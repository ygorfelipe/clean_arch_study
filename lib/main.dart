import 'package:estudo_clean_arch_nasa/container_injection.dart';
import 'package:estudo_clean_arch_nasa/presentation/pages/today_apod/apod_today_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await setUpContainer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astronomy Picture',
      home: ApodTodayPage(),
    );
  }
}
