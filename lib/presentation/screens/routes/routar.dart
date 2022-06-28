import 'package:auto_route/auto_route.dart';
import 'package:todo/presentation/screens/home/home_screen.dart';
import 'package:todo/presentation/screens/signup/signup_screen.dart';
import 'package:todo/presentation/screens/splash/splash_screen.dart';
import 'package:todo/presentation/screens/todo_detail/todo_detail_screen.dart';

@MaterialAutoRouter(
    //Liste von Autoroutes
    routes: <AutoRoute>[
      AutoRoute(page: SplashScreen, initial: true),
      AutoRoute(page: SignUpScreen, initial: false),
      AutoRoute(page: HomePage, initial: false),
      AutoRoute(page: TodoDetailScreen, initial: false, fullscreenDialog: true)
    ])
// $ Hier soll was generiert werden
class $AppRouter {}
