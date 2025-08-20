import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';

class HomeScreen extends ConsumerWidget {
  static const name = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      body: Center(
        child: userData.isLoading
        ? const CircularProgressIndicator(strokeCap: StrokeCap.round)
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Nombre: ${userData.userEntity.name}'),
            Text('Edad: ${userData.userEntity.years}'),
          ],
        )
      ),
    );
  }
}