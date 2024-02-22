// ignore_for_file: unnecessary_const, deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login/loginScreen.dart';
import 'package:shopapp/modules/onBording/onBoardingScreen.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/myBlocObserver.dart';
import 'package:shopapp/shared/network/remote/dioHelper.dart';
import 'package:shopapp/shared/style/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init(); 
  // DioHelper.init();
  // await CacheHelper.init();
  // bool? isDark = CacheHelper.getData(key: "isDark");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key, required this.isDark});
  // final bool isDark;
  // MyApp(this.isDark);
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      // ..changeAppMode(
      //   fromShared: isDark,
      // ),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var cubit = ShopCubit.get(context);
          return MaterialApp(
            theme: lightMode,
            darkTheme: darkTheme,
            // themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            themeMode: ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: LoginScreen(),
            ),
          );
        },
      ),
    );
  }
}
