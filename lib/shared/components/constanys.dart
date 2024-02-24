import 'package:shopapp/modules/login/loginScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cacheHelper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
          // OnBordingScreen(),
        );
      }
    },
  );
}

String token = ""??"";
