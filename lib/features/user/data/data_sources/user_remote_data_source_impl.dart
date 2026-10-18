import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/core/services/logger_service.dart';

import '../../../../core/constants/firestore_constants/firestore_constants.dart';
import '../../domain/value_objects/add_user_params.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRemoteDataSourceImpl({required this._firestore, required this._auth});

  @override
  Future<void> addUser({required AddUserParams params}) async {
    UserModel userProfileModel = _userProfileModel(params);
    await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(_auth.currentUser!.uid)
        .set({
          ...userProfileModel.toJson(),
          FirestoreConstants.fieldCreatedAt: FieldValue.serverTimestamp(),
        });
    AppLogger.warning('userProfileModel: $userProfileModel');
  }

  UserModel _userProfileModel(AddUserParams params) {
    switch (params.authProviderType) {
      case AuthProviderType.email:
        return UserModel(
          authProviderType: params.authProviderType.name,
          name: params.name!,
          imageUrl: params.imageUrl!,
          phone: params.phone!,
          email: params.email!,
        );
      case AuthProviderType.google:
        return UserModel(
          authProviderType: params.authProviderType.name,
          name: _auth.currentUser?.displayName ?? '',
          imageUrl: _auth.currentUser?.photoURL ?? '',
          phone: _auth.currentUser?.phoneNumber ?? '',
          email: _auth.currentUser?.email ?? '',
        );
      case AuthProviderType.facebook:
        return UserModel(
          authProviderType: params.authProviderType.name,
          name: _auth.currentUser?.displayName ?? '',
          imageUrl: _auth.currentUser?.photoURL ?? '',
          phone: _auth.currentUser?.phoneNumber ?? '',
          email: _auth.currentUser?.email ?? '',
        );
    }
  }

  @override
  Future<UserModel> getUserData() async {
    final currentUser = _auth.currentUser;

    final String userId = currentUser!.uid;

    final userDocumentSnapshot = await _firestore
        .collection(FirestoreConstants.usersCollection)
        .doc(userId)
        .get();

    final userMapData = userDocumentSnapshot.data();

    final Map<String, dynamic> rawUserData = {
      'id': userDocumentSnapshot.id,
      ...?userMapData,
    };

    final userProfile = UserModel.fromJson(rawUserData);

    AppLogger.info(
      'Successfully fetched user profile for ID: ${userProfile.id}',
    );
    return userProfile;
  }
}
