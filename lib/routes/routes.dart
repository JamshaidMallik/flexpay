import 'package:flexpay/view/home.dart';
import 'package:flexpay/view/login.dart';
import 'package:flexpay/view/splash.dart';
import 'package:get/get.dart';


class AppRoutes {
  static const splash = SplashScreen.routeName;
  static const home = HomeScreen.routeName;
  static const login = LoginScreen.routeName;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
  ];
}
