import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pulso_vital/modules/dashboard/presentation/screens/dashboard_screens.dart';

// Routes
const homeScreenRoute = HomeScreen.name;

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: homeScreenRoute,
    routes: [
      _goRoute(homeScreenRoute, const HomeScreen()),
    ]
  );
});

/// Creates a [GoRoute] with the specified [path] and [page].
///
/// Returns a route that uses a custom page transition defined in
/// [pagesTransition].
/// 
/// - [path]: The path string for the route.
/// - [page]: The widget to be displayed for the route.
GoRoute _goRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return pagesTransition(page);
    },
  );
}

/// Creates a custom transition for a page.
///
/// The transition is a slide from the right of the screen to the
/// left, with an ease-in-out animation.
///
/// - [page]: The widget to be displayed with the transition.
CustomTransitionPage<dynamic> pagesTransition(Widget page) {
  return CustomTransitionPage(
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const beginOffset = Offset(1.0, 0.0);
      const endOffset = Offset.zero;
      var tween = Tween(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: Curves.easeInOut));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}