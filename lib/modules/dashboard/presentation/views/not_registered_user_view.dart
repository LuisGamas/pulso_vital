import 'package:flutter/material.dart';

class NotRegisteredUserView extends StatelessWidget {
  const NotRegisteredUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SliverPadding(
      padding: const EdgeInsetsGeometry.all(16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '¡Vaya! No hay mucho que hacer por aquí... ¿Qué tal si inicias sesión para explorar ésta sección?',
          style: textStyles.titleSmall,
        ),
      ),
    );
  }
}