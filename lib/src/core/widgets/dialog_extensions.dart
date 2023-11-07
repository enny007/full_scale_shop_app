import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';
import 'package:gap/gap.dart';

class GlobalMethods {
  static Future<void> warningDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required VoidCallback fct,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const Gap(8),
              Text(title),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (context.router.canPop()) {
                  context.router.pop();
                }
              },
              child: const TextWidget(
                text: 'Cancel',
                color: Colors.cyan,
                textSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                fct();
                if (context.router.canPop()) {
                  context.router.pop();
                }
              },
              child: const TextWidget(
                text: 'Ok',
                color: Colors.red,
                textSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('An Error occured'),
            ]),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const TextWidget(
                  color: Colors.cyan,
                  text: 'Ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
}
