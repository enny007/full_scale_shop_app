// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.fct,
    required this.label,
    this.primary = Colors.white38,
  }) : super(key: key);
  final VoidCallback fct;
  final String label;
  final Color primary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: fct,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
        ),
        child: TextWidget(
          text: label,
          color: Colors.white,
          textSize: 18,
        ),
      ),
    );
  }
}
