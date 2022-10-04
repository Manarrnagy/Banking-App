import 'package:banking_app/splash_screen.dart';
import 'package:banking_app/transfers_list.dart';
import 'package:banking_app/user_profile.dart';
import 'package:banking_app/users_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
      routes: {
        "userslist": (context) => UsersList(),
        "userprofile": (context) => UserProfile(),
        "transferslist": (context) => TransfersList()
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
  );
}
