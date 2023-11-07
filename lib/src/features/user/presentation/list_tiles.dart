import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListTiles extends ConsumerWidget {
  const ListTiles({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onPressed,
    required this.color,
  });
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    return ListTile(
      title: TextWidget(
        color: color,
        text: title,
        textSize: 22,
        isTitle: true,
      ),
      subtitle: TextWidget(
        color: color,
        text: subtitle ?? '',
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
