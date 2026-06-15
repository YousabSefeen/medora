import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart'
    show FirestoreConstants;
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source.dart'
    show AuthRemoteDataSource;
import 'package:medora/features/auth/data/models/user_model.dart'
    show UserModel;

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _firestore = firestore,
       _auth = auth;

  @override
  Future<void> signUp({
    required UserModel userModel,
    required String password,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: userModel.email,
      password: password,
    );

    await _uploadUserData(userModel: userModel, uid: userCredential.user!.uid);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<String> getUserId() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user found in current session');
    }
    return user.uid;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _uploadUserData({
    required UserModel userModel,
    required String uid,
  }) async {
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(uid)
        .set({
          ...userModel.toJson(),
          FirestoreConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
        });
  }
}
