// ignore_for_file: must_be_immutable
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:full_scale_shop_app/src/features/category/presentation/categories_widget.dart';
import 'package:full_scale_shop_app/src/features/theme/notifier_controller/theme_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class CategoriesScreen extends ConsumerWidget {
  CategoriesScreen({super.key});

  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/categories/fruits.png',
      'categoryText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/categories/veg.png',
      'categoryText': 'Vegetables',
    },
    {
      'imgPath': 'assets/images/categories/Spinach.png',
      'categoryText': 'Herbs',
    },
    {
      'imgPath': 'assets/images/categories/nuts.png',
      'categoryText': 'Nuts',
    },
    {
      'imgPath': 'assets/images/categories/spices.png',
      'categoryText': 'Spices',
    },
    {
      'imgPath': 'assets/images/categories/grains.png',
      'categoryText': 'Grains',
    },
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color =
        ref.watch(themeNotifierProvider) ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Categories',
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 130 / 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index) {
            return CategoriesWidget(
              categoryText: catInfo[index]['categoryText'],
              imgPath: catInfo[index]['imgPath'],
              passedColor: gridColors[index],
            );
          }),
        ),
      ),
    );
  }
}
