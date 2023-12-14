import 'package:get/get.dart';
import 'package:login_demo/project/home/home_page.dart';
import 'package:login_demo/project/login/login_page.dart';
import 'package:login_demo/project/register/register_page.dart';
import 'package:login_demo/routes/getx_routes.dart';

abstract class GetXPages {
  static final pages = [
    GetPage(
        name: GetXRoutes.login,
        page: () => const LoginPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: GetXRoutes.register,
        page: () => const RegisterPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: GetXRoutes.home,
        page: () => const HomePage(),
        transition: Transition.fade),
  ];
}
