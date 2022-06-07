import 'package:aws_subscription/screens/login_failed_404/login_failed_screen.dart';
import 'package:flutter/material.dart';
import 'package:aws_subscription/components/custom_suffix_icon.dart';
import 'package:aws_subscription/components/default_button.dart';
import 'package:aws_subscription/components/form_error.dart';
import 'package:aws_subscription/constants.dart';
// import 'package:aws_subscription/screens/forgot_password/forgot_password_screen.dart';
import 'package:aws_subscription/screens/login_success/login_success_screen.dart';
import 'package:aws_subscription/size_config.dart';
import 'package:provider/provider.dart';

import '../../../providers/RegisterProvider.dart';

class SubscribeForm extends StatefulWidget {
  static var email;
  static String regEmail = "";
  const SubscribeForm({Key? key}) : super(key: key);

  @override
  State<SubscribeForm> createState() => _SubscribeFormState();
}

class _SubscribeFormState extends State<SubscribeForm> with EmailController {
  final _formKey = GlobalKey<FormState>();
  // @override
  // EmailController newEmailValue;
  late String email;
  late String password;

  bool remember = false;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    var service = context.watch<RegisterProvider>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: remember,
          //       activeColor: kPrimaryColor,
          //       onChanged: (value) {
          //         setState(() {
          //           remember = value!;
          //         });
          //       },
          //     ),
          //     // Text("Remember Me"),
          //     Spacer(), //One spacer left
          //     // GestureDetector(
          //     //   onTap: () => Navigator.pushNamed(
          //     //       context, ForgotPasswordScreen.routeName),
          //     //   child: Text("Forgot Password",
          //     //       style: TextStyle(decoration: TextDecoration.underline)),
          //     // )
          //   ],
          // ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // If all is valid; then go to success screen
                try {
                  service.registerUser(email);
                }catch(e){
                  Navigator.pushNamed(context, LoginFailedScreen.routeName);
                }
                SubscribeForm.regEmail = email;
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // if you are using latest version of flutter then label text and hint text shown like this
        // if you are using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/user-lock-solid.svg",
        ),
      ),
    );
    FormError(errors: errors);
  }

  TextFormField buildEmailFormField() {
    String id = '';
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        email = newValue!;

        SubscribeForm.email = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // if you are using latest version of flutter then label text and hint text shown like this
        // if you are using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/envelope-regular.svg",
        ),
      ),
    );
  }
}

mixin EmailController {
  late String newEmailValue;
}
