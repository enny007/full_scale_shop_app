import 'package:auto_route/auto_route.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/utils.dart';
import 'package:full_scale_shop_app/src/core/widgets/auth_button.dart';
import 'package:full_scale_shop_app/src/core/widgets/loader.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/auth/application/auth_controller.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/route/app_router.gr.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final landingImages = ref.watch(imageLandingProvider);
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    final showPassState = ref.watch(showObscureStateProvider);
    final isloading = ref.watch(authControllerProvider);
    final auth = ref.watch(authProvider);
    final user = auth.currentUser;
    Size size = Utils(context).screenSize;
    final formKey = GlobalKey<FormState>();
    final fullNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final addressController = useTextEditingController();
    final passFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final addressFocusNode = useFocusNode();

    void submitFormOnRegister() {
      formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      ref.read(authControllerProvider.notifier).createUserWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim(),
            context: context,
            shippingAddress: addressController.text,
            fullName: fullNameController.text,
          );
      fullNameController.clear();
      emailController.clear();
      passwordController.clear();
      addressController.clear();
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
                    child: Icon(
                      IconlyLight.arrowLeft2,
                      color: color,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  const TextWidget(
                    text: 'Welcome',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const Gap(8),
                  const TextWidget(
                    text: 'Sign up to continue',
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                          keyboardType: TextInputType.name,
                          controller: fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is missing";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Full name',
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
                        const Gap(10),
                        TextFormField(
                          focusNode: emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passFocusNode),
                          keyboardType: TextInputType.name,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return "Please enter a valid email address";
                            } else {
                              return null;
                            }
                          },
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
                        const Gap(10),
                        TextFormField(
                          focusNode: passFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(addressFocusNode),
                          keyboardType: TextInputType.name,
                          obscureText: showPassState,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return "Please eneter a valid password";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
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
                        const Gap(10),
                        TextFormField(
                          focusNode: addressFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {},
                          keyboardType: TextInputType.name,
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter a valid address";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Shipping address',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
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
                                label: 'Sign up',
                                fct: () => submitFormOnRegister(),
                              ),
                        const Gap(10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Already a user?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.router.push(
                                        const LoginRoute(),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
