import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aws_subscription/screens/subscription/components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/subscription";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Subscribe",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Body(),
    );
  }
}
