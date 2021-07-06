import 'package:flutter/material.dart';
import 'package:contacts/postContact.dart';
import 'package:contacts/getContact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostContact(),
      routes: <String, WidgetBuilder>{
        'Activity_one': (BuildContext context) => new PostContact(),
        'Activity_two': (BuildContext context) => new GetContact()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

