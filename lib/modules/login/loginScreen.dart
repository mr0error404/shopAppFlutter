// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/modules/register/registerScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constanys.dart';
import 'package:shopapp/shared/cubit/cubitLogin/cubit.dart';
import 'package:shopapp/shared/cubit/cubitLogin/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapp/shared/network/local/cacheHelper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
        if (state is ShopAppSuccessState) {
          if (state.loginModel?.status ?? false) {
            print(state.loginModel?.message);
            print(state.loginModel?.data?.token);
            CacheHelper.saveDate(
                    key: "token", value: state.loginModel?.data?.token)
                .then((value) {
                  token = state.loginModel!.data!.token!;
              navigateAndFinish(
                context,
                ShopLayout(),
              );
            });
            ShowToast(
              text: state.loginModel!.message ?? "",
              state: ToastStates.SUCCESS,
            );
          } else {
            print(state.loginModel?.message);
            ShowToast(
              text: state.loginModel!.message ?? "",
              state: ToastStates.ERROR,
            );
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
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
                        sufixs: ShopCubit.get(context).suffix,
                        isPassword: ShopCubit.get(context).isPasswordShow,
                        sufixFunction: () {
                          ShopCubit.get(context).changePasswordVisibility();
                        },
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
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
                      ConditionalBuilder(
                        condition: state is! ShopAppLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => defaultButton(
                          text: "login",
                          width: double.infinity,
                          back: HexColor("#FFBF2F"),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
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
          ),
        );
      }),
    );
  }
}
