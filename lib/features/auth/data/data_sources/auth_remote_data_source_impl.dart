import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medora/core/constants/firestore_constants/firestore_constants.dart';
import 'package:medora/core/enum/auth_provider_type.dart';
import 'package:medora/core/services/logger_service.dart';
import 'package:medora/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:medora/features/auth/domain/params/reset_password_and_sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_in_params.dart';
import 'package:medora/features/auth/domain/params/sign_up_params.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  AuthRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  }) : _firestore = firestore,
       _auth = auth,
       _googleSignIn = googleSignIn,
       _facebookAuth = facebookAuth;

  @override
  Future<void> signUp({required SignUpParams params}) async {
    switch (params.providerType) {
      case AuthProviderType.email:
        await _createUserWithEmailAndPassword(params);
        break;
      case AuthProviderType.google:
        await _signInWithGoogle(isSignIn: false);
        break;
      case AuthProviderType.facebook:
        await _authWithFacebook(isSignIn: false);
        break;
    }
  }

  Future<void> _createUserWithEmailAndPassword(SignUpParams params) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: params.email!,
          password: params.password!,
        );
  }

  @override
  Future<void> signIn({required SignInParams params}) async {
    switch (params.providerType) {
      case AuthProviderType.email:
        await _signInWithEmailAndPassword(params);
        break;
      case AuthProviderType.google:
        await _signInWithGoogle(isSignIn: true);
        break;
      case AuthProviderType.facebook:
        await _authWithFacebook(isSignIn: true);
        break;
    }
  }

  Future<void> _signInWithEmailAndPassword(SignInParams params) async {
    await _auth.signInWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
  }

  @override
  Future<void> signOut() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      final List<UserInfo> providerData = currentUser.providerData;

      for (var userInfo in providerData) {
        switch (userInfo.providerId) {
          case 'google.com':
            await _googleSignIn.signOut();
            break;
          case 'facebook.com':
            await _facebookAuth.logOut();
            break;
          case 'password':
            await _auth.signOut();
        }
      }
    }
  }

  Future<void> _signInWithGoogle({required bool isSignIn}) async {
    AppLogger.warning('_signInWithGoogle Open');
    await _googleSignIn.initialize(
      serverClientId:
          '973577617289-pqck6mh7arvvvrtff854qlot1qctdo83.apps.googleusercontent.com',
    );
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final String? idToken = googleAuth.idToken;

    final authClient = _googleSignIn.authorizationClient;

    var authorization = await authClient.authorizationForScopes(['email']);

    authorization ??= await authClient.authorizeScopes(['email']);
    final String accessToken = authorization.accessToken;

    if (idToken == null) {
      throw Exception('Failed to retrieve Google Authentication Tokens.');
    }

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    await _auth.signInWithCredential(
      credential,
    );
  }

  Future<void> _authWithFacebook({required bool isSignIn}) async {
    final LoginResult loginResult = await _facebookAuth.login();

    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      await _auth.signInWithCredential(
        facebookAuthCredential,
      );

      AppLogger.debug('🚀 Facebook Sign-In Successful!');
    } else {
      AppLogger.error(
        '⚠️ Facebook Login not successful: ${loginResult.status} - ${loginResult.message}',
      );
    }
  }

  @override
  Future<void> confirmPasswordReset({
    required ResetPasswordParams params,
  }) async {
    await _auth.confirmPasswordReset(
      code: params.oobCode,
      newPassword: params.newPassword,
    );
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String> fetchEmailFromCode({required String oobCode}) async {
    return await _auth.verifyPasswordResetCode(oobCode);
  }


  //NOTE: Not Use yet
  // ============================================================
  // ⚠️ OTP Functions for Password Reset
  // ============================================================
  // 📌 Status: Initial Code (Not Yet Tested)
  // 🔄 Required: Cloud Functions Activated + Full Stream Test
  // 📅 Activation Will Be Involved in Future Releases

  /// 📱 Step 1: Request an OTP and retrieve the phone number from the Firestore
  @override
  Future<void> verifyPhoneAndSendOtp({
    required String email,
    required Function(String verificationId) onCodeSent,
    required Function(String errorMessage) onVerificationFailed,
  }) async {
    final querySnapshot = await _firestore
        .collection(FirestoreConstants.usersCollection)
        .where('email', isEqualTo: email.trim())
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception(
        'This email address is not registered with us; you can create a new account.',
      );
    }

    final String userPhoneNumber = querySnapshot.docs.first.data()['phone'];
    await _auth.verifyPhoneNumber(
      phoneNumber: userPhoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException firebaseAuthException) {
        onVerificationFailed(
          firebaseAuthException.message ?? 'حدث خطأ أثناء إرسال الـ OTP',
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(
          verificationId,
        ); // Pass the ID to Cubit for use in the next step
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// 🔐 Step 2: Confirm OTP and update password
  @override
  Future<void> verifyOtpAndUpdatePassword({
    required String email,
    required String verificationId,
    required String smsCode,
    required String newPassword,
  }) async {
    // 1. Attempting to verify the OTP code via the Firebase server
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    // Temporary phone login as conclusive security proof of account ownership
    final UserCredential phoneUser = await _auth.signInWithCredential(
      credential,
    );

    ///...
  }
}
