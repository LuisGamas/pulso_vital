// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// A widget that displays a message when the user is not registered.
///
/// This widget is intended to be used as part of a `CustomScrollView` and
/// provides a simple, encouraging message to prompt the user to create a
/// profile.
class NotRegisteredUserView extends StatelessWidget {
  /// Creates a [NotRegisteredUserView] instance.
  const NotRegisteredUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '¡Vaya! No hay mucho que hacer por aquí... ¿Qué tal si creas tu perfil para explorar ésta sección?',
          style: textStyles.titleSmall,
        ),
      ),
    );
  }
}
