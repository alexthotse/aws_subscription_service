import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aws_subscription/screens/login_failed_404//components/body.dart';

class LoginFailedScreen extends StatelessWidget {
  const LoginFailedScreen({Key? key}) : super(key: key);

  static String routeName = "/login_failed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(),
        title: Text("Login Timeout"),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Body(),
    );
  }
}
