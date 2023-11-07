import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/auth_button.dart';
import 'package:full_scale_shop_app/src/core/widgets/loader.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/auth/application/auth_controller.dart';
import 'package:full_scale_shop_app/src/features/auth/presentation/google_button.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final landingImages = ref.watch(imageLandingProvider);
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final showPassState = ref.watch(showObscureStateProvider);
    final isloading = ref.watch(authControllerProvider);
    Size size = Utils(context).screenSize;
    final emailTextController = useTextEditingController();
    final passwordController = useTextEditingController();
    final focusNode = useFocusNode();
    final formKey = GlobalKey<FormState>();

    void _submitFormOnLogin() {
      formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
            email: emailTextController.text.toLowerCase().trim(),
            password: passwordController.text.trim(),
            context: context,
          );
      // emailTextController.clear();
      // passwordController.clear();
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
                    height: size.height * 0.12,
                  ),
                  const TextWidget(
                    text: 'Welcome Back',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const Gap(8),
                  const TextWidget(
                    text: 'Sign in to continue',
                    color: Colors.white,
                    textSize: 18,
                    isTitle: false,
                  ),
                  const Gap(30),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailTextController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
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
                          ),
                        ),
                        const Gap(12),
                        //Password
                        TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOnLogin();
                          },
                          focusNode: focusNode,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: showPassState,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid password';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ref
                                    .read(showObscureStateProvider.notifier)
                                    .update(
                                      (state) => !state,
                                    );
                              },
                              icon: showPassState
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.router.push(
                          const ForgetPasswordRoute(),
                        );
                      },
                      child: const Text(
                        'Forget password?',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  isloading
                      ? const Loader()
                      : AuthButton(
                          label: 'Login',
                          fct: () => _submitFormOnLogin(),
                        ),
                  const Gap(10),
                  const GoogleButton(),
                  const Gap(10),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      const Gap(5),
                      TextWidget(
                        text: 'OR',
                        color: color,
                        textSize: 18,
                      ),
                      const Gap(5),
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  AuthButton(
                    label: 'Continue as a guest',
                    fct: () {
                      context.router.push(
                        const AppScaffoldRoute(),
                      );
                    },
                    primary: Colors.black,
                  ),
                  const Gap(10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.router.push(
                                const RegisterRoute(),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
