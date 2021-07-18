import 'package:flutter/material.dart';

import 'login_view.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chucky Norris',
        home: LoginPage()); // define it once at root level.
  }
}
