import 'package:about_me/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AboutMeApp());

class AboutMeApp extends StatelessWidget {
  const AboutMeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      home: HomePage(),
    );
  }
}

