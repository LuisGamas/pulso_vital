import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/dashboard/presentation/views/dashboard_views.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

class HomeScreen extends ConsumerWidget {
  /// The route name for this screen. 
  static const name = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    ref.listen(userDataProvider, (previous, next) {
      if (!next.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          if (!next.isRegistered) {
            // Show the registration dialog if the user is not registered.
            showDialog(
              context: context,
              builder: (_) => const RequestRegistrationDialog(),
            );
          }
        });
      }
    });

    return Scaffold(
      // Floating Action Button for adding new records
      floatingActionButton: _CustomExtendedFAB(
        isRegistered: userData.isRegistered,
      ),
      // The body of the screen
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar
          _CustomSliverAppBar(userName: userData.userEntity.name),

          // Conditionally display the content view based on user registration status.
          userData.isRegistered
          ? const RegisteredUserView()
          : const NotRegisteredUserView(),          
        ],
      ),
    );
  }
}

// * Custom Sliver AppBar Widget
class _CustomSliverAppBar extends StatelessWidget {
  final String userName;

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

                    // const Spacer(),
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

// * FAB widget
class _CustomExtendedFAB extends StatelessWidget {
  /// A boolean indicating if the user is registered.
  final bool isRegistered;

  const _CustomExtendedFAB({
    required this.isRegistered,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // The text label of the button, which changes based on the registration state.
      label: Text(
        isRegistered
        ? 'Añadir Signos Vitales'
        : 'Crear Perfil de Usuario'
      ),
      // The icon of the button, which also changes based on the registration state.
      icon: Icon(
        isRegistered 
        ? RippleIcons.editOutline
        : RippleIcons.userPlusOutline,
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
