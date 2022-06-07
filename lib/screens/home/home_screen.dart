import 'package:aws_subscription/screens/subscription/components/subscribe_form.dart';
import 'package:flutter/material.dart';
import 'package:aws_subscription/components/custom_bottom_nav_bar.dart';
import 'package:aws_subscription/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.email}) : super(key: key);

  static String routeName = "/home";

  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(email: email),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
        email: SubscribeForm.email, // type
      ),
    );
  }
}
