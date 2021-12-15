import 'package:flutter/material.dart';
import 'package:application1/databaseConnection.dart';
import 'login_page.dart';

main() {
  /*Connecting to Database while opening App*/
  MYSQL.connect();
  /*Starting App*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}