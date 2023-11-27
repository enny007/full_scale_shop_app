// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/cart/repo/cart_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartController {
  final CartRepository _cartRepository;

  CartController({
    required CartRepository cartRepository,
  }) : _cartRepository = cartRepository;

  Future<void> addToCart({
    required WidgetRef ref,
    required String productId,
    required int quantity,
  }) async {
    final result = await _cartRepository.addToCart(
      productId: productId,
      quantity: quantity,
      ref: ref,
    );
    result.fold(
      (l) => null,
      (r) => Fluttertoast.showToast(
        msg: "Item has been added to your cart",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      ),
    );
  }

  Future<void> initpayment({
    required String email,
    required double amount,
    required WidgetRef ref,
  }) async {
    try {
      Dio dio = Dio();
      //Create a payment intent
      final result = await dio.post(
          'https://us-central1-e-commerce-app-2dc5d.cloudfunctions.net/stripePaymentIntentRequest',
          data: {
            'email': email,
            'amount': amount.toString(),
          });
      final jsonResponse = result.data as Map<String, dynamic>;
      log(
        jsonResponse.toString(),
      );
      if (jsonResponse['success'] == false) {
        GlobalMethods.errorDialog(
          subtitle: jsonResponse['error'],
          context: ref.context,
        );
      }
      // initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Fruit shop app',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      showSnackBar(
        ref.context,
        'Payment is successful',
      );
      //The lowest amount is 0.50 cent
    } catch (err) {
      if (err is StripeException) {
        showSnackBar(
          ref.context,
          'An error occurred ${err.error.localizedMessage}',
        );
        log(
          err.error.localizedMessage.toString(),
        );
      } else {
        showSnackBar(
          ref.context,
          'An error occurred $err',
        );
        log(
          err.toString(),
        );
      }
    }
  }
}

final cartControllerProvider = Provider<CartController>((ref) {
  return CartController(
    cartRepository: ref.read(cartRepoProvider),
  );
});
