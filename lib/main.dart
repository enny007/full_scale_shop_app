// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_scale_shop_app/firebase_options.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/route/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'src/features/theme/theme_data_setup.dart/theme.dart';

Future<void> main() async {
  //To set the orientation to a deafault value.
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51OFvlPFuireUbcBPNso9kBd0bllIf5r0xJT49srEkcni5cmq0F0YRyc1E5ZhyVZLfPXGSp0i9RHTrEn2XMDSzNoP004PkF08Xx';
  Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: Themes.darkTheme(context),
      theme: Themes.lightTheme(context),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: ref.watch(routerProvider).config(),
    );
  }
}

