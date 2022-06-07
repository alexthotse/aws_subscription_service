import 'package:aws_subscription/providers/CardProvider.dart';
import 'package:aws_subscription/providers/ChatProvider.dart';
import 'package:aws_subscription/providers/RegisterProvider.dart';
import 'package:aws_subscription/routes.dart';
import 'package:aws_subscription/screens/welcome/welcome_screen.dart';
import 'package:aws_subscription/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CardProvider>(
          create: (context) => CardProvider(),
        ),

        ChangeNotifierProvider<RegisterProvider>(
          create: (context) => RegisterProvider(),
        ),
        //
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
        //
        // ChangeNotifierProvider<ViewSalePageController>(
        //   create: (context) => ViewSalePageController(),
        // ),

        // ChangeNotifierProvider<RegisterUserController>(
        //   create: (context) => RegisterUserController(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Boldr Subscription',
        theme: theme(),
        initialRoute: WelcomeScreen.routeName,
        routes: routes,
      ),
    );
  }
}
