import 'package:aws_subscription/screens/subscription/subscribe_screen.dart';
import 'package:flutter/material.dart';
import 'package:aws_subscription/constants.dart';
import 'package:aws_subscription/size_config.dart';

// This is the best practice
import '../components/welcome_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> welcomeData = [
    {
      "text": "Welcome to Boldr Subscription!",
      "image": "assets/images/welcome_bro.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: welcomeData.length,
                itemBuilder: (context, index) => WelcomeContent(
                  image: welcomeData[index]["image"],
                  text: welcomeData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //     welcomeData.length,
                    //     (index) => buildDot(index: index),
                    //   ),
                    // ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AnimatedContainer buildDot({int? index}) {
  //   return AnimatedContainer(
  //     duration: kAnimationDuration,
  //     margin: EdgeInsets.only(right: 5),
  //     height: 6,
  //     width: currentPage == index ? 20 : 6,
  //     decoration: BoxDecoration(
  //       color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
  //       borderRadius: BorderRadius.circular(3),
  //     ),
  //   );
  // }
}
