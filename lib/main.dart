import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: const MyApp()
    )
  );
}

class MyApp extends ConsumerWidget  {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    
    return MaterialApp.router(
      routerConfig: appRouter,
      themeMode: ThemeMode.system,
      theme: AppTheme(primaryColor: Colors.purpleAccent).getLightTheme(),
      darkTheme: AppTheme(primaryColor: Colors.purpleAccent).getDarkTheme(),
    );
  }
}
