// ignore_for_file: prefer_const_constructors, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:naheed_rider/pages/authentication/login_screen.dart';
import 'package:naheed_rider/pages/loadsheet/load_sheet.dart';
import 'package:naheed_rider/pages/main/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: hasData ? HomePage() : LoginPage(),
    );
  }

  Future<void> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    print("token: $token");
    if (token != null) {
      setState(() {
        hasData = true;
      });
    }
  }
}

