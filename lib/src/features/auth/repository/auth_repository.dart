import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:full_scale_shop_app/src/core/shared/failure.dart';
import 'package:full_scale_shop_app/src/core/shared/provider.dart';
import 'package:full_scale_shop_app/src/core/shared/typedef.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn,
        _firestore = firestore;

  FutureEither<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String uid,
    required String fullname,
    required String shippingAddress,
  }) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //create user instance in firestore
      await _firestore.collection('users').doc(userCredentials.user!.uid).set({
        'id': userCredentials.user!.uid,
        'name': fullname,
        'email': email,
        'shipping-address': shippingAddress,
        'userWish': [],
        'userCart': [],
        'createdAt': Timestamp.now(),
      });
      return right(userCredentials.user);
    } on FirebaseException catch (e) {
      return left(
        Failure(e.message!),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userCredentials.user);
    } on FirebaseException catch (e) {
      return left(
        Failure(e.message!),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credentials);
      return right(userCredential.user);
    } on FirebaseException catch (e) {
      return left(
        Failure(e.message!),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureVoid userForgotPassword({
    required String email,
  }) async {
    try {
      return right(
        await _auth.sendPasswordResetEmail(email: email),
      );
    } on FirebaseException catch (e) {
      return left(
        Failure(e.message!),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  //Get user data from documentsnapshot
 Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) {
    final snapshot = _firestore.collection('users').doc(uid).snapshots();
    return snapshot;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    firestore: ref.watch(fireStoreProvider),
    auth: ref.watch(authProvider),
    googleSignIn: ref.watch(googleSignProvider),
  );
});
