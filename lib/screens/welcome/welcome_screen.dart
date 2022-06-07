import 'package:flutter/material.dart';
import 'package:aws_subscription/screens/welcome/components/body.dart';
import 'package:aws_subscription/size_config.dart';

class WelcomeScreen extends StatelessWidget {
  static String routeName = "/welcome";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
