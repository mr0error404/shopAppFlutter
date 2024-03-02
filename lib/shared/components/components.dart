import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/models/boardingModel.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/style/colors.dart';

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

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 35.0,
      ),
      child: Container(
        color: Colors.grey,
        width: double.infinity,
        height: 1.0,
      ),
    );

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    "${model!.image}",
                    // "https://www.ionos.com/digitalguide/fileadmin/DigitalGuide/Teaser/error-t.jpg",
                  ),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                  // fit: BoxFit.cover,
                ),
                if (model!.discount != 0 && isOldPrice)
                  // if (1 != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(
                      3.0,
                    ),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model!.name}",
                    // "ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 14.0,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${model!.price}",
                        // "298",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      // if (1 != 0)
                      if (model!.discount != 0 && isOldPrice)
                        Text(
                          // "450",
                          "${model!.oldPrice}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubitApp.get(context).changeFavorites(model!.id!);
                          // print(model.id);
                          // print(model.inFavorites);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubitApp.get(context).favorites[model!.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            // color: Colors.white,
                            Icons.favorite_border,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
