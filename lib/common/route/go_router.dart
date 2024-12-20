import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/main.dart';
import 'package:tdd/calendar/view/calendar_view.dart';
import 'package:tdd/main/view/main_view.dart';
import 'package:tdd/objective/view/objective_view.dart';
import 'package:tdd/search/view/friend_list_view.dart';
import 'package:tdd/user/view/profile_view.dart';

import '../../objective/view/create_view.dart';
import '../../user/view/setting_view.dart';

class AppTransitions {
  static CustomTransitionPage<void> horizontalSlide({
    required LocalKey key,
    required Widget child,
    Offset begin = const Offset(2.0, 0.0),
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static CustomTransitionPage<void> fade({
    required LocalKey key,
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/mainpage',
  routes: [
   /* GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MyHomePage(title: 'Flutter Demo Home Page'),
    ),*/
    GoRoute(
      path: '/mainpage',
      name: MainScreen.routeName,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/friendlistpage',
      name: FriendListScreen.routeName,
      builder: (context, state) => const FriendListScreen(),
    ),
    GoRoute(
      path: '/calendarpage',
      name: CalendarScreen.routeName,
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: '/profilepage',
      name: ProfileScreen.routeName,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settingpage',
      name: SettingScreen.routeName,
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/objectivepage',
      name: ObjectiveScreen.routeName,
      builder: (context, state) => const ObjectiveScreen(),
    ),
    GoRoute(
      path: '/createpage',
      name: CreateScreen.routeName,
      builder: (context, state) => const CreateScreen(),
    ),
  ],
);
