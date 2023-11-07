// ignore_for_file: unnecessary_null_comparison

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/auth/application/auth_controller.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/features/user/application/user_controller.dart';
import 'package:full_scale_shop_app/src/features/user/presentation/list_tiles.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class UserScreen extends HookConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(themeNotifierProvider);
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    final name = useState<String?>(null);
    final email = useState<String?>(null);
    final address = useState<String?>(null);
    final textDialogController = useTextEditingController(text: '');
    //call the getUserProvider and use the data
    if (user != null) {
      ref.watch(getUserDataProvider(user.uid)).whenData((value) {
        name.value = value.get('name');
        email.value = value.get('email');
        address.value = value.get('shipping-address');
        textDialogController.text = value.get('shipping-address');
      });
    } else {
      // Handle the case where user is null, for example, show an error message or perform some other action.
      
    }

    Future<void> showAddressDialog({
      required BuildContext context,
    }) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              controller: textDialogController,
              maxLines: 5,
              onChanged: (value) {
                textDialogController.text;
              },
              decoration: const InputDecoration(hintText: 'Your address'),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Future.microtask(() {
                    ref.watch(userControllerProvider).updateShippingAddress(
                          address: textDialogController.text,
                          context: context,
                        );
                    context.router.pop();
                  });
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hi,  ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: name.value ?? 'user',
                          style: TextStyle(
                            color: color,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //
                            }),
                    ],
                  ),
                ),
                const Gap(5),
                TextWidget(
                  color: color,
                  text: email.value ?? 'Email',
                  textSize: 18,
                ),
                const Gap(20),
                const Divider(
                  thickness: 2,
                ),
                const Gap(20),
                ListTiles(
                  title: 'Address',
                  color: color,
                  subtitle: address.value ?? '',
                  icon: IconlyLight.activity,
                  onPressed: () async {
                    await showAddressDialog(
                      context: context,
                    );
                  },
                ),
                ListTiles(
                  title: 'Orders',
                  icon: IconlyLight.bag,
                  onPressed: () {
                    context.router.push(
                      const OrderRoute(),
                    );
                  },
                  color: color,
                ),
                ListTiles(
                  title: 'Wishlist',
                  icon: IconlyLight.activity,
                  onPressed: () {
                    context.router.push(
                      const WishListRoute(),
                    );
                  },
                  color: color,
                ),
                ListTiles(
                  title: 'Viewed',
                  icon: IconlyBold.show,
                  onPressed: () {
                    context.router.push(
                      const ViewedRecentlyRoute(),
                    );
                  },
                  color: color,
                ),
                ListTiles(
                  title: 'Forgot password',
                  icon: IconlyBold.unlock,
                  onPressed: () {
                    context.router.push(
                      const ForgetPasswordRoute(),
                    );
                  },
                  color: color,
                ),
                SwitchListTile(
                  value: darkMode,
                  title: TextWidget(
                    text: 'Theme',
                    color: color,
                    textSize: 22,
                  ),
                  activeColor: Colors.lightBlue.shade200,
                  secondary: darkMode
                      ? const Icon(Icons.dark_mode_outlined)
                      : const Icon(Icons.light_mode_outlined),
                  onChanged: (value) {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  },
                ),
                ListTiles(
                  title: user == null ? 'Login' : 'Logout',
                  icon: user == null ? IconlyLight.login : IconlyBold.logout,
                  onPressed: () {
                    if (user == null) {
                      context.router.push(
                        const LoginRoute(),
                      );
                      return;
                    }
                    GlobalMethods.warningDialog(
                      context: context,
                      title: 'Sign out',
                      subtitle: 'Do you want to Sign out',
                      fct: () {
                        ref.read(authControllerProvider.notifier).signOut();
                        context.router.replaceAll([
                          const LoginRoute(),
                        ]);
                      },
                    );
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
