import 'package:flutter/material.dart';
import 'package:smarthaven/register.dart';
import 'package:smarthaven/user/aboutus.dart';
import 'package:smarthaven/user/auth.dart';
import 'package:smarthaven/user/familymembers.dart';
import 'package:smarthaven/user/help.dart';
import 'package:smarthaven/user/homepage.dart';
import 'package:smarthaven/user/myhomescreen.dart';
import 'package:smarthaven/user/privacy.dart';
import 'package:smarthaven/user/profilescreen.dart';
import 'package:smarthaven/user/userprofilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartHaven',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE8BC8A)),
      ),

      home: ProfileScreen(),
    );
  }
}
