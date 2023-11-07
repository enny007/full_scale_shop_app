// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final imageOfferProvider = Provider<List<String>>((ref) {
  return [
    'assets/images/offers/Offer1.jpg',
    'assets/images/offers/Offer2.jpg',
    'assets/images/offers/Offer3.jpg',
    'assets/images/offers/Offer4.jpg',
  ];
});

final imageLandingProvider = Provider<List<String>>((ref) {
  return [
    'assets/images/landing/buy-on-laptop.jpg',
    'assets/images/landing/buy-through.png',
    'assets/images/landing/buyfood.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/store.jpg',
    'assets/images/landing/vegetable.jpg',
  ];
});

final showObscureStateProvider = StateProvider<bool>((ref) => true);

final fireStoreProvider = Provider(
  (ref) => FirebaseFirestore.instance,
);
final authProvider = Provider(
  (ref) => FirebaseAuth.instance,
);

// final storageProvider = Provider(
//   (ref) => FirebaseStorage.instance,
// );
final googleSignProvider = Provider(
  (ref) => GoogleSignIn(),
);

final userProvider = StateProvider<User?>((ref) {
  final auth = ref.watch(authProvider);
  return auth.currentUser;
});
