import 'package:daily_task/app/features/auth/sign_in.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.signIn;
  static const dashboard = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.signIn,
      page: () => const SignIn(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
