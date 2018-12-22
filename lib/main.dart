import 'package:fake_nigerian_friends/ui/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var title = "Friends";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "$title",
      home: Home(
        header: "$title",
      ),

      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}