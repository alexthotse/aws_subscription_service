// import 'package:aws_subscription/screens/cart/cart_screen.dart';
// import 'package:aws_subscription/screens/chat/chat_screen.dart';
// import 'package:aws_subscription/screens/complete_profile/complete_profile_screen.dart';
// import 'package:aws_subscription/screens/credit_card/credit_card_screen.dart';
import 'package:aws_subscription/screens/details/details_screen.dart';
// import 'package:aws_subscription/screens/forgot_password/forgot_password_screen.dart';
import 'package:aws_subscription/screens/home/home_screen.dart';
import 'package:aws_subscription/screens/login_failed_404/login_failed_screen.dart';
import 'package:aws_subscription/screens/login_success/login_success_screen.dart';
import 'package:aws_subscription/screens/otp/otp_screen.dart';
// import 'package:aws_subscription/screens/profile/profile_screen.dart';
import 'package:aws_subscription/screens/subscription/components/subscribe_form.dart';
import 'package:aws_subscription/screens/subscription/subscribe_screen.dart';
// import 'package:aws_subscription/screens/sign_up/sign_up_screen.dart';
import 'package:aws_subscription/screens/welcome/welcome_screen.dart';
import 'package:flutter/widgets.dart';

// WE USE NAME ROUTES
// All our routes will be avaiable here
final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: ((context) => WelcomeScreen()),
  SignInScreen.routeName: (context) => SignInScreen(),
  // ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) =>
      LoginSuccessScreen(),
  LoginFailedScreen.routeName: (context) => LoginFailedScreen(),
  // SignUpScreen.routeName: (context) => SignInScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  // HomeScreen.routeName: (context) => HomeScreen(email: LoginSuccessScreen.email),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(email: SignForm.email),
  // ChatScreen.routeName: ((context) => ChatScreen()),
  // CreditCardScreen.routeName: (context) => CreditCardScreen(),
};
