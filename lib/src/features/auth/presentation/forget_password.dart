import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/auth_button.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/core/widgets/loader.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/auth/application/auth_controller.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ForgetPasswordScreen extends HookConsumerWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    final landingImages = ref.watch(imageLandingProvider);
    Size size = Utils(context).screenSize;
    final emailController = useTextEditingController();

    void forgetPassWord() async {
      if (emailController.text.isEmpty || !emailController.text.contains('@')) {
        GlobalMethods.errorDialog(
          subtitle: 'Please enter a valid email address',
          context: context,
        );
      }
      ref.watch(authControllerProvider.notifier).userForgotPassword(
            email: emailController.text.trim(),
            context: context,
          );
    }

    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (context, index) {
              return Image.asset(
                landingImages[index],
                fit: BoxFit.fill,
              );
            },
            itemCount: landingImages.length,
            autoplay: true,
            autoplayDelay: 8000,
            duration: 800,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => context.popRoute(),
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  const TextWidget(
                    text: 'Forgot Password',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const Gap(40),
                  TextField(
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {},
                    keyboardType: TextInputType.name,
                    controller: emailController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  isLoading
                      ? const Loader()
                      : AuthButton(
                          fct: () => forgetPassWord(),
                          label: 'Reset now',
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
