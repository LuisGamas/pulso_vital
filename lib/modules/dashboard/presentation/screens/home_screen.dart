// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

// 🌎 Project imports:
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/dashboard/presentation/views/dashboard_views.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

/// The main screen of the application.
///
/// `HomeScreen` is a `ConsumerWidget` that serves as the entry point for the
/// user's main experience. It uses Riverpod to watch the user's data and
/// conditionally displays different views based on whether the user is
/// registered or not. It also handles the display of a registration dialog
/// on first launch if the user is not yet registered.
class HomeScreen extends ConsumerWidget {
  /// The route name for this screen.
  static const name = '/home-screen';

  /// Constructs a `HomeScreen` instance.
  const HomeScreen({super.key});

  /// Builds the main UI for the home screen.
  ///
  /// This method watches the `userDataProvider` to get the current state of
  /// the user's profile. It also uses a `ref.listen` to show a dialog for
  /// user registration if the user is not registered and the loading process
  /// is complete.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the `userDataProvider` to get the current user's state.
    final userData = ref.watch(userDataProvider);

    // Listen to changes in the `userDataProvider` state.
    ref.listen(userDataProvider, (previous, next) {
      // Check if the loading process has finished.
      if (!next.isLoading) {
        // Schedule a post-frame callback to show the dialog.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // If the user is not registered, show the registration dialog.
          if (!next.isRegistered) {
            showDialog(
              context: context,
              builder: (_) => const RequestRegistrationDialog(),
            );
          }
        });
      }
    });

    return Scaffold(
      // The floating action button changes its functionality based on user registration.
      floatingActionButton: _CustomExtendedFAB(
        isRegistered: userData.isRegistered,
      ),
      // The main body of the screen, using a `CustomScrollView` for a flexible layout.
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // A custom SliverAppBar to display the app title and user info.
          _CustomSliverAppBar(userName: userData.userEntity.name),
          // Conditionally render the appropriate view based on user registration.
          userData.isRegistered ? const RegisteredUserView() : const NotRegisteredUserView(),
        ],
      ),
    );
  }
}

/// A custom widget for the SliverAppBar.
///
/// This widget provides a custom app bar with a flexible space that contains
/// the app title, a subtitle, a user profile picture, and a welcome message.
class _CustomSliverAppBar extends StatelessWidget {
  /// The name of the user to be displayed.
  final String userName;

  /// Creates an instance of `_CustomSliverAppBar`.
  const _CustomSliverAppBar({
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.sizeOf(context);
    final textStyles = Theme.of(context).textTheme;

    return SliverAppBar(
      backgroundColor: colors.primary,
      expandedHeight: 120,
      pinned: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: colors.primary),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10),
                Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // User Profile Picture
                    CircleAvatar(
                      backgroundColor: colors.surfaceContainer,
                      backgroundImage: const AssetImage(
                        Constants.imageProfile1,
                      ),
                    ),
                    // App Title and Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pulso Vital',
                          style: textStyles.headlineSmall!.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                        Text(
                          'Lleva tu bienestar al día',
                          style: textStyles.bodyMedium!.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(10),
                // Welcome Message to the user
                Text(
                  'Bienvenido: $userName',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textStyles.titleLarge!.copyWith(
                    color: colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A custom floating action button widget.
///
/// This widget's text and icon change based on whether the user is
/// registered. It shows the appropriate dialog (for registration or
/// logging vital signs) when pressed.
class _CustomExtendedFAB extends StatelessWidget {
  /// A boolean indicating if the user is registered.
  final bool isRegistered;

  /// Creates an instance of `_CustomExtendedFAB`.
  const _CustomExtendedFAB({
    required this.isRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // The text label of the button, which changes based on the registration state.
      label: Text(isRegistered ? 'Añadir Signos Vitales' : 'Crear Perfil de Usuario'),
      // The icon of the button, which also changes based on the registration state.
      icon: Icon(
        isRegistered ? RippleIcons.editOutline : RippleIcons.userPlusOutline,
        size: 32,
      ),
      onPressed: () {
        // Show the appropriate dialog based on the registration status.
        showDialog(
          context: context,
          builder: (_) => isRegistered
              ? const VitalSignsLogDialog()
              : const RequestRegistrationDialog(),
        );
      },
    );
  }
}
