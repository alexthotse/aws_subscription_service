import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aws_subscription/screens/login_success/components/body.dart';

import '../subscription/components/subscribe_form.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  // final String email;

  static String email = SubscribeForm.regEmail;
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(),
        title: Text("Login Success"),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Body(email: SubscribeForm.regEmail),
    );
  }
}
