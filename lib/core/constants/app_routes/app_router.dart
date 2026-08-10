import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/enum/navigation_source.dart';
import 'package:medora/core/enum/payment_gateways_types.dart';
import 'package:medora/features/appointments/domain/entities/client_appointments_entity.dart';
import 'package:medora/features/appointments/presentation/screens/appointment_cancellation_screen.dart';
import 'package:medora/features/appointments/presentation/screens/appointment_details_screen.dart';
import 'package:medora/features/appointments/presentation/screens/booked_appointments_screen.dart';
import 'package:medora/features/appointments/presentation/screens/create_appointment_screen.dart';
import 'package:medora/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:medora/features/auth/presentation/screens/phone_forgot_password_screen.dart';
import 'package:medora/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:medora/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:medora/features/doctor_profile/presentation/screens/doctor_profile_screen.dart';
import 'package:medora/features/doctors_specialties/presentation/screens/medical_specialties_screen.dart';
import 'package:medora/features/doctors_specialties/presentation/screens/specialty_doctors_screen.dart';
import 'package:medora/features/gemini/presentation/screens/gemini_chat_screen.dart';
import 'package:medora/features/home/presentation/screens/bottom_nav_screen.dart';
import 'package:medora/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:medora/features/patient/presentation/screens/patient_details_screen.dart';
import 'package:medora/features/payment_gateways/paymob/presentation/view/screens/paymob_payment_screen.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart';
import 'package:medora/features/payment_gateways/paypal/presentation/views/screens/paypal_payment_screen.dart';
import 'package:medora/features/payment_gateways/stripe/presentation/View/Screens/stripe_payment_screen.dart';
import 'package:medora/features/payment_gateways/transaction_process_states/payment_success/screens/payment_success_screen.dart';
import 'package:medora/features/shared/domain/entities/doctor_entity.dart';
import 'package:medora/main.dart';

class AppRouter {
  //final stableContext = AppRouter.router.routerDelegate.navigatorKey.currentContext;
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,

    // initialLocation: FirebaseAuth.instance.currentUser?.uid != null
    //     ? AppRouterNames.bottomNav
    //     : AppRouterNames.signIn,
    initialLocation: AppRouterNames.screenOne,
    routes: [
      GoRoute(
        path: AppRouterNames.screenOne,

        pageBuilder: (context, state) =>
            _buildAnimatedPage(state: state, child: const NextScreen()),
      ),   GoRoute(
        path: AppRouterNames.signIn,

        pageBuilder: (context, state) =>
            _buildAnimatedPage(state: state, child: const SignInScreen()),
      ),
      GoRoute(
        path: AppRouterNames.signUp,

        pageBuilder: (context, state) =>
            _buildAnimatedPage(state: state, child: const SignUpScreen()),
      ),
      GoRoute(
        path: AppRouterNames.geminiChat,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const GeminiChatScreen(),
          isFadeRoute: false, // هنا نستخدم الـ Scale الترددي كما حددت سابقاً
        ),
      ),
      GoRoute(
        path: AppRouterNames.doctorProfile,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const DoctorProfileScreen(),
          isFadeRoute: false,
        ),
      ),

      GoRoute(
        path: AppRouterNames.bookedAppointments,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const BookedAppointmentsScreen(),
          isFadeRoute: false,
        ),
      ),
      GoRoute(
        path: AppRouterNames.bottomNav,
        pageBuilder: (context, state) =>
            _buildAnimatedPage(state: state, child: const BottomNavScreen()),
      ),
      GoRoute(
        path: AppRouterNames.medicalSpecialties,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const MedicalSpecialtiesScreen(),
          isFadeRoute: false,
        ),
      ),

      GoRoute(
        path: AppRouterNames.patientDetails,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const PatientDetailsScreen(),
          isFadeRoute: false,
        ),
      ),
      GoRoute(
        path: AppRouterNames.notifications,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const NotificationsScreen(),
          isFadeRoute: false,
        ),
      ),
      GoRoute(
        path: AppRouterNames.appointmentCancellation,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, String>;

          return _buildAnimatedPage(
            state: state,
            child: AppointmentCancellationScreen(
              doctorId: data['doctorId']!,
              appointmentId: data['appointmentId']!,
            ),
          );
        },
      ),
      //vvvvvvvvvvvvv
      GoRoute(
        path: AppRouterNames.appointmentDetails,
        pageBuilder: (context, state) {
          final appointment = state.extra as ClientAppointmentsEntity;

          return _buildAnimatedPage(
            state: state,
            child: AppointmentDetailsScreen(appointment: appointment),
          );
        },
      ),

      GoRoute(
        path: AppRouterNames.stripePayment,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const StripePaymentScreen(),
        ),
      ),

      GoRoute(
        path: AppRouterNames.paypalPayment,
        pageBuilder: (context, state) => _buildAnimatedPage(
          state: state,
          child: const PaypalPaymentScreen(),
        ),
      ),
      GoRoute(
        path: AppRouterNames.paymobPayment,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return _buildAnimatedPage(
            state: state,
            child: PaymobPaymentScreen(
              selectedPaymentMethod:
                  data['selectedPaymentMethod'] as PaymentGatewaysTypes,
              phoneNumber: data['phoneNumber'] as String,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRouterNames.paymentSuccess,
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return _buildAnimatedPage(
            state: state,
            child: PaymentSuccessScreen(
              paymentMethod: data['paymentMethod'] as PaymentGatewaysTypes,
              paymobResponse:
                  data['paymobResponse'] as PaymobTransactionDataResultModel?,
              paypalEmail: data['paypalResponse'] as String?,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRouterNames.createAppointment,
        builder: (BuildContext context, GoRouterState state) {
          final data = state.extra as Map<String, dynamic>;
          return CreateAppointmentScreen(
            doctor: data['doctor'] as DoctorEntity,
            navigationSource: data['navigationSource'] as NavigationSource,
          );
        },
      ),
      GoRoute(
        path: AppRouterNames.specialtyDoctors,
        pageBuilder: (context, state) {
          final specialtyName = state.extra as String;

          return _buildAnimatedPage(
            state: state,
            child: SpecialtyDoctorsScreen(specialtyName: specialtyName),
          );
        },
      ),

      GoRoute(
        path: AppRouterNames.forgetPassword,
        name: 'forgotPasswordScreen',
        pageBuilder: (context, state) {
          /// Extracts the out-of-band code (oobCode) from the email deep link
          /// query parameters and forwards it to the reset password screen.

          final String? oobCode = state.uri.queryParameters['oobCode'];

          final data = state.extra as Map<String, dynamic>?;

          final email = data?['email'];

          return _buildAnimatedPage(
            state: state,
            isFadeRoute: false,
            child: ForgotPasswordScreen(email: email, oobCode: oobCode),
          );
        },
      ),
      GoRoute(
        path: AppRouterNames.phoneForgotPassword,

        pageBuilder: (context, state) {
          return _buildAnimatedPage(
            state: state,
            child: const PhoneForgotPasswordScreen(),
          );
        },
      ),
    ],
  );

  static Page<dynamic> _buildAnimatedPage({
    required GoRouterState state,
    required Widget child,
    bool isFadeRoute = true,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      arguments: state.extra,
      // تمرير البيانات (Arguments) في go_router يتم عبر extra
      transitionDuration: AppDurations.milliseconds_400,
      reverseTransitionDuration: AppDurations.milliseconds_400,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (isFadeRoute) {
          // أنيميشن الـ Slide (من الأسفل للأعلى) كما في كودك القديم
          final position = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
          return SlideTransition(position: position, child: child);
        } else {
          // أنيميشن الـ Scale (الزوم اللطيف من المنتصف)
          final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
          );
          return ScaleTransition(scale: scale, child: child);
        }
      },
    );
  }
}
