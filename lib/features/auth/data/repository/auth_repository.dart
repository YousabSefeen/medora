import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/features/auth/data/models/user_model.dart' show UserModel;

import '../../../../core/error/failure.dart';
import '../../../../core/utils/date_time_formatter.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _uploadUserData(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          phone: phone,
          role: role);
      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }

  Future<void> _uploadUserData({
    required String uid,
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(UserModel(
            name: name,
            phone: phone,
            email: email,
            role: role,
            createdAt: DateTimeFormatter.dateAndTimeNowS(),
          ).toJson());
    } catch (e) {
      print('_saveUserDataToFirestore $e');
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignIn google = GoogleSignIn();

      google.disconnect();

      return right(null);
    } catch (e) {
      return left(ServerFailure(catchError: e));
    }
  }
}
/*
  Future  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
      return ;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
 */
