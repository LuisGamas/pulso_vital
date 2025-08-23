// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget  {
  const MyApp({super.key});

  /// Builds the main application widget.
  ///
  /// This method retrieves the `goRouterProvider` from Riverpod and uses it
  /// to configure `MaterialApp.router`. It also sets the light and dark themes
  /// based on the `AppTheme` class, with the system's theme preference being
  /// the default.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the `goRouterProvider` to get the configured router instance.
    // This allows the app to respond to navigation changes.
    final appRouter = ref.watch(goRouterProvider);
    
    return MaterialApp.router(
      routerConfig: appRouter,
      // Uses the system's theme preference (light or dark).
      themeMode: ThemeMode.system,
      // Defines the light theme for the application.
      theme: AppTheme(primaryColor: const Color(0xFF8F3953)).getLightTheme(),
      // Defines the dark theme for the application.
      darkTheme: AppTheme(primaryColor: const Color(0xFF8F3953)).getDarkTheme(),
    );
  }
}
