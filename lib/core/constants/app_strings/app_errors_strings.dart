class AppErrorsStrings {
  static const String invalidCredentials =
      'Invalid login credentials. Please check your email and password.';
  static const String invalidCredentialsAr =
      'بيانات تسجيل الدخول غير صحيحة. يرجى التحقق من البريد الإلكتروني وكلمة المرور.';

  static const String userNotFound = 'No account found for this email address.';
  static const String userNotFoundAr =
      'لا يوجد حساب مرتبط بهذا البريد الإلكتروني.';

  static const String wrongPassword = 'The password you entered is incorrect.';
  static const String wrongPasswordAr = 'كلمة المرور التي أدخلتها غير صحيحة.';

  static const String userDisabled = 'This user account has been disabled.';
  static const String userDisabledAr = 'تم تعطيل هذا الحساب من قبل الإدارة.';

  static const String tooManyRequests =
      'Too many attempts. Please try again later.';
  static const String tooManyRequestsAr =
      'محاولات كثيرة جداً. يرجى المحاولة مرة أخرى لاحقاً.';

  static const String emailAlreadyInUse =
      'This email address is already registered. Please sign in or use a different email.';
  static const String emailAlreadyInUseAr =
      'هذا البريد الإلكتروني مسجل بالفعل. يرجى تسجيل الدخول أو استخدام بريد إلكتروني آخر.';

  static const String invalidEmail =
      'The email address format is invalid. Please enter a valid email.';
  static const String invalidEmailAr =
      'صيغة البريد الإلكتروني غير صالحة. يرجى إدخال بريد إلكتروني صحيح.';

  static const String operationNotAllowed =
      'This operation is not allowed. Please contact support.';
  static const String operationNotAllowedAr =
      'هذه العملية غير مسموحة. يرجى الاتصال بالدعم الفني.';

  static const String weakPassword =
      'The password is too weak. Please use at least 6 characters.';
  static const String weakPasswordAr =
      'كلمة المرور ضعيفة جداً. يرجى استخدام 6 أحرف على الأقل.';

  static const String networkRequestFailed =
      'Network error. Please check your internet connection and try again.';
  static const String networkRequestFailedAr =
      'خطأ في الشبكة. يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';

  static const String internalError =
      'An internal error occurred. Please try again later.';
  static const String internalErrorAr =
      'حدث خطأ داخلي. يرجى المحاولة مرة أخرى لاحقاً.';

  static const String missingEmail = 'Email address is required.';
  static const String missingEmailAr = 'البريد الإلكتروني مطلوب.';

  static const String missingPassword = 'Password is required.';
  static const String missingPasswordAr = 'كلمة المرور مطلوبة.';

  static const String invalidApiKey =
      'Invalid API key. Please check your Firebase configuration.';
  static const String invalidApiKeyAr =
      'مفتاح API غير صالح. يرجى التحقق من إعدادات Firebase.';

  static const String accountExistsWithDifferentCredential =
      'This email is already associated with another sign-in method. '
      'Please sign in using your original method (e.g., email, Google, or Facebook) '
      'to link your account and continue.';
  static const String accountExistsWithDifferentCredentialAr =
      'هذا البريد الإلكتروني مرتبط بطريقة تسجيل دخول أخرى. '
      'يرجى تسجيل الدخول باستخدام طريقتك الأصلية (مثل البريد الإلكتروني أو Google أو Facebook) '
      'لربط حسابك والمتابعة.';

  // ============================================================
  // 🔄 Password Reset Errors (أخطاء إعادة تعيين كلمة المرور)
  // ============================================================
  static const String expiredActionCode =
      'The password reset link has expired. Please request a new one.';
  static const String expiredActionCodeAr =
      'انتهت صلاحية رابط إعادة تعيين كلمة المرور. يرجى طلب رابط جديد.';

  static const String invalidActionCode =
      'This password reset link is invalid or has already been used. '
      'Please request a new one.';
  static const String invalidActionCodeAr =
      'رابط إعادة تعيين كلمة المرور غير صالح أو تم استخدامه مسبقاً. '
      'يرجى طلب رابط جديد.';

  // ============================================================
  // ❓ Default Error (الخطأ الافتراضي)
  // ============================================================
  static const String unexpectedError =
      'An unexpected error occurred. Please try again later.';
  static const String unexpectedErrorAr =
      'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً.';

  // ============================================================
  // 🔵 Google Sign-In Errors (أخطاء تسجيل الدخول عبر Google)
  // ============================================================

  /// خطأ غير معروف في Google Sign-In
  static const String googleUnknownError =
      'An unknown error occurred during Google sign-in. Please try again later.';

  /// تم إلغاء تسجيل الدخول عبر Google من قبل المستخدم
  static const String googleCanceled =
      'Google sign-in was canceled. Please try again if you wish to continue.';

  /// تم مقاطعة عملية تسجيل الدخول عبر Google
  static const String googleInterrupted =
      'The Google sign-in process was interrupted. Please try again.';

  /// خطأ في تكوين العميل (Client ID غير صحيح)
  static const String googleClientConfigurationError =
      'Google sign-in configuration error. Please check your app settings.';

  /// خطأ في تكوين المزود (Google Cloud Console)
  static const String googleProviderConfigurationError =
      'Google service configuration error. Please contact support.';

  /// واجهة المستخدم غير متاحة (خدمات Google Play غير محدثة)
  static const String googleUiUnavailable =
      'Google sign-in is unavailable. Please update Google Play Services.';

  /// عدم تطابق المستخدم (المستخدم المسجل مختلف عن المستخدم الحالي)
  static const String googleUserMismatch =
      'User mismatch. Please sign out and try again with the correct account.';

  // ============================================================
  // 💳   Payment Errors (أخطاء الدفع عبر Stripe)
  // ============================================================
  // ============================================================
  // 📦 core/constants/app_errors_strings.dart
  // ============================================================

  /// فشل عملية الدفع بشكل عام
  static const String stripePaymentFailed =
      'Payment failed. Please try again later or use a different payment method.';

  /// تم إلغاء عملية الدفع من قبل المستخدم
  static const String paymentCanceled =
      'Payment was canceled. You can try again whenever you\'re ready.';

  /// انتهت مهلة عملية الدفع
  static const String stripePaymentTimeout =
      'Payment request timed out. Please check your internet connection and try again.';

  /// خطأ غير معروف في عملية الدفع
  static const String stripePaymentUnknown =
      'An unknown error occurred during payment. Please try again later.';

  /// تم رفض البطاقة
  static const String stripeCardDeclined =
      'Your card was declined. Please try a different payment method or contact your bank.';

  /// البطاقة منتهية الصلاحية
  static const String stripeCardExpired =
      'Your card has expired. Please update your card information.';

  /// رمز CVC غير صحيح
  static const String stripeIncorrectCvc =
      'Invalid security code (CVC). Please check and try again.';

  /// خطأ في معالجة الدفع
  static const String stripeProcessingError =
      'Payment processing error. Please try again later.';

  /// محاولات دفع كثيرة جداً
  static const String stripeRateLimit =
      'Too many payment attempts. Please wait a few minutes and try again.';

  /// رصيد غير كافٍ
  static const String stripeInsufficientFunds =
      'Insufficient funds. Please check your balance or use a different payment method.';

  /// بطاقة غير مدعومة
  static const String stripeCardNotSupported =
      'This card type is not supported. Please use a different card.';

  /// عنوان الفوترة غير صحيح
  static const String stripeInvalidBillingAddress =
      'Invalid billing address. Please check your address and try again.';

  /// رمز التأكيد غير صحيح
  static const String stripeInvalidVerificationCode =
      'Invalid verification code. Please check and try again.';
  static const String paymentFailedError = 'Payment failed. Please try again.';
  static const String paymentFailedDescription =
      "We couldn't process your payment. Please:\n"
      '• Check your payment details\n'
      '• Try another payment method\n'
      '• Ensure sufficient balance';
}
