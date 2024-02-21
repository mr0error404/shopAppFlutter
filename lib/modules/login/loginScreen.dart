// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/modules/register/register.dart';
import 'package:shopapp/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "login now to browse our hot offers",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                /// The `defaultFormField` function is being called with several parameters to create a form
                /// field for entering an email address. Here is a breakdown of the parameters being passed:
                defaultFormField(
                  textEditingController: emailController,
                  prefix: Icons.email,
                  type: TextInputType.emailAddress,
                  validation: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter your email address";
                    }
                    return null;
                  },
                  label: "Email",
                ),
                const SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textEditingController: passwordController,
                  prefix: Icons.lock,
                  sufixs: Icons.visibility,
                  isPassword: true,
                  sufixFunction: () {},
                  type: TextInputType.emailAddress,
                  validation: (String? value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  label: "Password",
                ),
                const SizedBox(
                  height: 30.0,
                ),
                defaultButton(
                  text: "login",
                  width: double.infinity,
                  back: HexColor("#FFBF2F"),
                  function: () {},
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t have an account ?",
                    ),
                    defaultTextButton(
                      function: () {
                        navigateTo(
                          context,
                          Register(),
                        );
                      },
                      text: "register",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
