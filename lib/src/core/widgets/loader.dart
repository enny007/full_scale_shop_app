import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends ConsumerWidget {
  const Loader({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    return Center(
      child: SpinKitFadingFour(
        color: color,
        size: size ?? 0,
      ),
    );
  }
}
