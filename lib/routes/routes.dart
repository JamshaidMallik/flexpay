import 'package:flexpay/view/addUser.dart';
import 'package:flexpay/view/dashboard.dart';
import 'package:flexpay/view/login.dart';
import 'package:flexpay/view/splash.dart';
import 'package:flexpay/view/userProfile.dart';
import 'package:get/get.dart';


class AppRoutes {
  static const splash = SplashScreen.routeName;
  static const home = DashBoard.routeName;
  static const login = LoginScreen.routeName;
  static const addUser = AddUserScreen.routeName;
  static var userprofile = UserProfile.routeName;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const DashBoard()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: addUser, page: () => const AddUserScreen()),
    GetPage(name: userprofile, page: () =>   const UserProfile(), transition: Transition.leftToRight),
  ];
}
