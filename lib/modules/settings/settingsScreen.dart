import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constanys.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp, ShopStatesApp>(
        listener: (BuildContext context, ShopStatesApp state) {
      // if (state is ShopSuccessUserDataState){
      //   nameController.text = state.loginModel!.data!.name!;
      //   emailController.text = state.loginModel!.data!.email!;
      //   phoneController.text = state.loginModel!.data!.phone!;
      // }
    }, builder: (context, state) {
      var model = ShopCubitApp.get(context).userModel;

      nameController.text = model!.data!.name!;
      emailController.text = model!.data!.email!;
      phoneController.text = model!.data!.phone!;

      return ConditionalBuilder(
        condition: ShopCubitApp.get(context).userModel != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textEditingController: nameController,
                  prefix: Icons.person,
                  type: TextInputType.text,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "Name must not be empty ";
                    }
                    return null;
                  },
                  label: "Name",
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textEditingController: emailController,
                  prefix: Icons.email,
                  type: TextInputType.emailAddress,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "email must not be empty ";
                    }
                    return null;
                  },
                  label: "Email",
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textEditingController: phoneController,
                  prefix: Icons.phone,
                  type: TextInputType.number,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return "Phone must not be empty ";
                    }
                    return null;
                  },
                  label: "Phone",
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: "UPDATE",
                  width: double.infinity,
                  back: defaultColor,
                  function: () {    
                    if (formKey.currentState!.validate()) {
                      ShopCubitApp.get(context).UpdateUserData(
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultButton(
                  text: "Logout",
                  width: double.infinity,
                  back: defaultColor,
                  function: () {
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
