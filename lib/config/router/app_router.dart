// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
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
/// This helper function simplifies route creation by automatically applying a
/// custom page transition defined in [pagesTransition].
///
/// - [path]: The unique path string for this route (e.g., '/home').
/// - [page]: The widget to be displayed when navigating to this route.
GoRoute _goRoute(String path, Widget page) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      // Returns the page with the custom transition applied.
      return pagesTransition(page);
    },
  );
}

/// Creates a custom slide transition for a page.
///
/// This function generates a `CustomTransitionPage` that makes a new screen
/// slide in from the right of the screen to the left. It uses an
/// `easeInOut` curve for a smooth animation effect.
///
/// - [page]: The widget that the transition will be applied to.
CustomTransitionPage<dynamic> pagesTransition(Widget page) {
  return CustomTransitionPage(
    // The widget to be shown.
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define the starting and ending positions for the slide animation.
      const beginOffset = Offset(1.0, 0.0); // Starts off-screen to the right.
      const endOffset = Offset.zero; // Ends at the default position.

      // Create a tween that combines the slide and the animation curve.
      var tween = Tween(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: Curves.easeInOut));

      // Use a `SlideTransition` to apply the animation to the child widget.
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
