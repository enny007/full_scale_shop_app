import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/auth/repository/auth_repository.dart';
import 'package:full_scale_shop_app/src/routing/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String shippingAddress,
    required String fullName,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authRepository.createUserWithEmailAndPassword(
      email: email,
      password: password,
      uid: _ref.watch(authProvider).currentUser?.uid ?? '',
      shippingAddress: shippingAddress,
      fullname: fullName,
    );
    state = false;
    res.fold(
      (l) => GlobalMethods.errorDialog(
        subtitle: l.message,
        context: context,
      ),
      (r) {
        showSnackBar(context, 'Registration Successful!');
        Future.delayed(const Duration(seconds: 1), () {
          return context.router.push(
            const AppScaffoldRoute(),
          );
        });
      },
    );
  }

  void signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, 'Successfully Logged in');
        context.router.push(
          const AppScaffoldRoute(),
        );
      },
    );
  }

  void signInWithGoogle(
    BuildContext context,
  ) async {
    // state = true;
    final user = await _authRepository.signInWithGoogle();
    // state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        // showSnackBar(context, 'Successfully Logged in');
        context.router.push(
          const AppScaffoldRoute(),
        );
      },
    );
  }

  void userForgotPassword(
      {required String email, required BuildContext context}) async {
    state = true;
    final res = await _authRepository.userForgotPassword(email: email);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) => showSnackBar(context, 'An email has been sent to your address'),
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void signOut() async {
    _authRepository.signOut();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  );
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});
