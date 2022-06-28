// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../../domain/entities/todo/todo.dart' as _i7;
import '../home/home_screen.dart' as _i3;
import '../signup/signup_screen.dart' as _i2;
import '../splash/splash_screen.dart' as _i1;
import '../todo_detail/todo_detail_screen.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    SignUpScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SignUpScreen());
    },
    HomePageRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    TodoDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TodoDetailScreenRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.TodoDetailScreen(key: args.key, todo: args.todo),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i5.RouteConfig(SignUpScreenRoute.name, path: '/sign-up-screen'),
        _i5.RouteConfig(HomePageRoute.name, path: '/home-page'),
        _i5.RouteConfig(TodoDetailScreenRoute.name, path: '/todo-detail-screen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpScreenRoute extends _i5.PageRouteInfo<void> {
  const SignUpScreenRoute()
      : super(SignUpScreenRoute.name, path: '/sign-up-screen');

  static const String name = 'SignUpScreenRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i5.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/home-page');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.TodoDetailScreen]
class TodoDetailScreenRoute
    extends _i5.PageRouteInfo<TodoDetailScreenRouteArgs> {
  TodoDetailScreenRoute({_i6.Key? key, required _i7.Todo? todo})
      : super(TodoDetailScreenRoute.name,
            path: '/todo-detail-screen',
            args: TodoDetailScreenRouteArgs(key: key, todo: todo));

  static const String name = 'TodoDetailScreenRoute';
}

class TodoDetailScreenRouteArgs {
  const TodoDetailScreenRouteArgs({this.key, required this.todo});

  final _i6.Key? key;

  final _i7.Todo? todo;

  @override
  String toString() {
    return 'TodoDetailScreenRouteArgs{key: $key, todo: $todo}';
  }
}
