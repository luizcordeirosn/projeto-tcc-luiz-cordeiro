import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_liga_master/app/modules/home/home_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeStateful(),);
  }
}