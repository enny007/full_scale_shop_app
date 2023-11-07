import 'package:flutter/material.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/widgets/dialog_extensions.dart';
import 'package:full_scale_shop_app/src/features/user/repository/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserController {
  final UserRepository _userRepository;
  final Ref _ref;
  UserController({
    required UserRepository userRepository,
    required Ref ref,
  })  : _userRepository = userRepository,
        _ref = ref;

  void updateShippingAddress(
      {required String address, required BuildContext context}) async {
    final updatedAddress = await _userRepository.updateShippingAddress(
      uid: _ref.watch(authProvider).currentUser?.uid ?? '',
      address: address,
    );
    updatedAddress.fold(
      (l) => showSnackBar(context, l.message),
      (r) => null,
    );
  }
}

final userControllerProvider = Provider<UserController>((ref) {
  return UserController(
    userRepository: ref.watch(userRepoProvider),
    ref: ref,
  );
});