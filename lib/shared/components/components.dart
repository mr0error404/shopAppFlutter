import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/models/boardingModel.dart';

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultFormField({
  required TextEditingController textEditingController,
  required IconData prefix,
  required TextInputType type,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  bool isEnabeld = true,
  Function()? onTap,
  required String? Function(String?)? validation,
  required String label,
  bool isPassword = false,
  IconData? sufixs,
  Function()? sufixFunction,
  double circular = 30.0,
}) =>
    TextFormField(
      // cursorColor: HexColor("#FFBF2F"),
      validator: validation,
      controller: textEditingController,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // focusColor: HexColor("#FFBF2F"),
        // hoverColor: HexColor("#FFBF2F"),
        // fillColor: HexColor("#FFBF2F"),

        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: sufixs != null
            ? IconButton(
                icon: Icon(sufixs),
                onPressed: sufixFunction,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(circular),
        ),
      ),
      obscureText: isPassword,
      onTap: onTap,
      enabled: isEnabeld,
    );

Widget defaultButton({
  double rid = 20.0,
  Color colorText = Colors.white,
  bool uperCase = true,
  required String text,
  required double width,
  required Color back,
  required Function() function,
  double height = 40.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rid),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          uperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: colorText,
          ),
        ),
        color: back,
      ),
    );
Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text),
    );

void ShowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
