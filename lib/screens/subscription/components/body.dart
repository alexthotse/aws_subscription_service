import 'dart:convert';
import 'dart:io';

import 'package:aws_subscription/providers/RegisterProvider.dart';
import 'package:aws_subscription/screens/login_success/login_success_screen.dart';
import 'package:aws_subscription/screens/subscription/components/subscribe_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aws_subscription/components/custom_suffix_icon.dart';
import 'package:aws_subscription/components/default_button.dart';
import 'package:aws_subscription/components/form_error.dart';
import 'package:aws_subscription/components/no_account_text.dart';
import 'package:aws_subscription/components/social_card.dart';
import 'package:aws_subscription/constants.dart';
// import 'package:aws_subscription/screens/forgot_password/forgot_password_screen.dart';
import 'package:aws_subscription/size_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Text(
                  "Welcome to Boldr",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Subscribe with your email\n or continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.1),
                SubscribeFormFillUp(),
                SizedBox(height: SizeConfig.screenHeight! * 0.1),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialCard(
                        icon: "assets/icons/google-brands.svg",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/icons/twitter-brands.svg",
                        press: () {},
                      ),
                      SocialCard(
                        icon: "assets/icons/github-brands.svg",
                        press: () {},
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                NoAccountText(),
                // Spacer(),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition.\n\nPLEASE DON\'T FILL IN REAL DETAILS\nDUMMY PROJECT',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                // SizedBox(height: SizeConfig.screenHeight! * 0.1),
                // Spacer(),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SubscribeForm extends StatefulWidget {
//   @override
//   _SubscribeForm createState() => _SubscribeFormState();
// }

class SubscribeFormFillUp extends StatefulWidget {
  // const SubscribeFormFillUp({Key? key}) : super(key: key);

  @override
  State<SubscribeFormFillUp> createState() => _SubscribeFormFillUpState();
}

class _SubscribeFormFillUpState extends State<SubscribeFormFillUp> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirm_password;
  bool remember = false;
  final List<String> errors = [];

  File? jsonFile;
  Directory? dir;
  String fileName = "users.json";
  bool fileExists = false;
  Map<String, String>? fileContent;

  @override
  void initState() {
    super.initState();
    /*to store files temporary we use getTemporaryDirectory() but we need
    permanent storage so we use getApplicationDocumentsDirectory() */
    // getApplicationDocumentsDirectory().then((Directory directory) {
    //   dir = directory;
    //   jsonFile = new File(dir!.path + "/" + fileName);
    //   fileExists = jsonFile!.existsSync();
    //   if (fileExists) this.setState(() => fileContent = jsonDecode(jsonFile!.readAsStringSync()));
    // });

    if (kIsWeb) {
      // Set web-specific directory Here
    } else {
      getApplicationDocumentsDirectory().then((Directory directory) {
        dir = directory;
        jsonFile = new File(dir!.path + "/" + fileName);
        fileExists = jsonFile!.existsSync();
        if (fileExists) this.setState(() => fileContent = jsonDecode(jsonFile!.readAsStringSync()));
      });
    }
  }
  void createFile(Map<String, String> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to file!");
    Map<String, String> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, String> jsonFileContent = json.decode(jsonFile!.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile!.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dir!, fileName);
    }
    fileContent = jsonDecode(jsonFile!.readAsStringSync());
    print(fileContent);
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var service = context.watch<RegisterProvider>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Center(
                child:
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, getProportionateScreenWidth(20),
                        getProportionateScreenWidth(20), getProportionateScreenWidth(20)),
                    child: SvgPicture.asset(
                      "assets/svg/email-campaign-amico.svg",
                      height: getProportionateScreenHeight(180),
                      width: getProportionateScreenWidth(180),
                    ),
                  ),
              )),

          buildEmailFormField(),
          // buildPasswordFormField(),
          // buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          // buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          // buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                // writeToFile("email", email!);
                // service.registerUser(email!);
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newConfirmedPasswordValue) =>
          confirm_password = newConfirmedPasswordValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSuffixIcon(svgIcon: "assets/icons/user-lock-solid.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newPasswordValue) => password = newPasswordValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSuffixIcon(svgIcon: "assets/icons/user-lock-solid.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newEmailValue) {
        email = newEmailValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
