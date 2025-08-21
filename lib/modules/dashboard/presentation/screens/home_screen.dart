import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pulso_vital/config/config.dart';
import 'package:pulso_vital/modules/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:pulso_vital/modules/shared/widgets/shared_widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const name = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    ref.listen(userDataProvider, (previous, next) {
      if (!next.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          if (!next.isRegistered) {
            showDialog(
              context: context,
              builder: (context) => const _RequestRegistrationDialog(),
            );
          }
        });
      }
    });

    return Scaffold(
      // Floating Action Button for adding new records
      floatingActionButton: const _CustomExtendedFAB(),
      // The body of the screen
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // AppBar
          _CustomSliverAppBar(userName: userData.userEntity.name),
          
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
  const _CustomExtendedFAB();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('Agregar nuevo registro'),
      icon: const Icon(RippleIcons.editOutline),
      onPressed: () { },
    );
  }
}

// * Custom Dialog
class _RequestRegistrationDialog extends ConsumerWidget {
  const _RequestRegistrationDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final userRegistrationForm = ref.watch(userRegistrationFormProvider);
    final appRouter = ref.watch(goRouterProvider);

    return AlertDialog(
      scrollable: true,
      backgroundColor: colors.surfaceContainer,
      title: const Text('¡Regístrate para continuar!'),
      titleTextStyle: textStyles.titleLarge,
      actions: [
        FilledButton(
          onPressed: () {
            ref.read(userRegistrationFormProvider.notifier).onFormSubmit();
            appRouter.pop();
          },
          child: const Text('Registrar')
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Text(
            'Parece que aún no estás registrado. Por favor, completa tu registro para acceder a todas las funciones.',
            style: textStyles.bodySmall,
          ),
          // Nombre
          CustomFormField(
            label: 'Ingresa tu nombre',
            hint: 'Ej. Luis Donaldo Gamas',
            leftIcon: RippleIcons.userOutline,
            onChanged: ref.read(userRegistrationFormProvider.notifier).onNameChanged,
            errorMessage: userRegistrationForm.isFormPosted
              ? userRegistrationForm.name.errorMessage
              : null,
          ),
          // Edad
          CustomFormField(
            label: 'Ingresa tu edad',
            hint: 'Ej. 30',
            leftIcon: RippleIcons.userOutline,
            onChanged: ref.read(userRegistrationFormProvider.notifier).onYearsChanged,
            errorMessage: userRegistrationForm.isFormPosted
              ? userRegistrationForm.years.errorMessage
              : null,
          ),
        ],
      ),
    );
  }
}