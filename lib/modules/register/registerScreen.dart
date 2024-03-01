import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/modules/login/loginScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constanys.dart';
import 'package:shopapp/shared/cubit/cubitLogin/cubit.dart';
import 'package:shopapp/shared/cubit/cubitRegister/cubit.dart';
import 'package:shopapp/shared/cubit/cubitRegister/states.dart';
import 'package:shopapp/shared/network/local/cacheHelper.dart';

class Register extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRgisterCubit(),
      child: BlocConsumer<ShopRgisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopAppRegisterSuccessState) {
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
                        "REGISTER",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "Register now to browse our hot offers",
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
                        textEditingController: nameController,
                        prefix: Icons.person,
                        type: TextInputType.name,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your name ";
                          }
                          return null;
                        },
                        label: "Name",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        textEditingController: phoneController,
                        prefix: Icons.phone,
                        type: TextInputType.number,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone ";
                          }
                          return null;
                        },
                        label: "Phone",
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        textEditingController: emailController,
                        prefix: Icons.email,
                        type: TextInputType.emailAddress,
                        validation: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your phone ";
                          }
                          return null;
                        },
                        label: "Emailabd",
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
                          ShopRgisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmitted: (value) {
                          // if (formKey.currentState!.validate()) {
                          //   ShopCubit.get(context).userLogin(
                          //     email: emailController.text,
                          //     password: passwordController.text,
                          //   );
                          // }
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
                        // condition: true,
                        condition: state is! ShopAppRegisterLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (context) => defaultButton(
                          text: "Register",
                          width: double.infinity,
                          back: HexColor("#FFBF2F"),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopRgisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
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
                            "your have an account ?",
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(
                                context,
                                LoginScreen(),
                              );
                            },
                            text: "Login",
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
