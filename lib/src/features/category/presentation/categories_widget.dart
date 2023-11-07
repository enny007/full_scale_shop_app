import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({
    super.key,
    required this.imgPath,
    required this.categoryText,
    required this.passedColor,
  });
  final String imgPath, categoryText;
  final Color passedColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        context.router.push(
          InnerCatRoute(
            category: categoryText,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedColor.withOpacity(0.7),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            TextWidget(
              text: categoryText,
              color: color,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
