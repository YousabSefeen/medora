import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medora/core/app_settings/controller/cubit/app_settings_cubit.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/di/injection_container.dart';
import 'package:medora/core/enum/internet_state.dart';
import 'package:medora/core/services/overlay_notification_service.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/book_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/cancel_appointment_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/cancelled_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/completed_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/doctor_appointments_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/time_slot_cubit.dart';
import 'package:medora/features/appointments/presentation/controller/cubit/upcoming_appointments_cubit.dart';
import 'package:medora/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:medora/features/favorites/presentation/controller/cubit/favorites_cubit.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/features/patient/presentation/controllers/cubit/patient_cubit.dart';
import 'package:medora/features/search/presentation/controller/cubit/home_doctor_search_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'Core/payment_gateway_manager/stripe_payment/stripe_keys.dart';
import 'core/app_settings/controller/states/app_settings_states.dart';
import 'core/base/my_bloc_observer.dart';
import 'core/constants/app_routes/app_router.dart';
import 'core/constants/themes/app_colors.dart';
import 'core/constants/themes/app_light_theme.dart';
import 'features/doctor_list/presentation/controller/cubit/doctor_list_cubit.dart';
import 'features/specialties/presentation/controller/cubit/specialties_cubit.dart';
import 'features/reviews/presentation/controller/cubit/reviews_cubit.dart';
import 'features/user/presentation/controllers/cubit/user_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();

  final serviceLocator = ServiceLocator();
  await serviceLocator.init();

  if (!kIsWeb) {
    final tempDir = await getTemporaryDirectory();

    // يمكنك مسح الملفات القديمة عند بدء التشغيل
    try {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    } catch (e) {
      print('Error clearing temp: $e');
    }
  }

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Future.wait([
    initializeDateFormatting('en_US'),

    dotenv.load(fileName: '.env'),
  ]);
  Stripe.publishableKey = StripeKeys.publishableKey;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ReviewsCubit>()),
        BlocProvider(create: (_) => sl<UserCubit>()..getUserData()),
        BlocProvider(
          create: (_) => sl<SpecialtiesCubit>()..fetchTopSpecialties(),
        ),

        BlocProvider(create: (_) => sl<HomeDoctorSearchCubit>()),

        BlocProvider(create: (_) => sl<FavoritesCubit>()..fetchFavoriteIds()),

        BlocProvider(create: (_) => sl<BottomNavCubit>()),
        BlocProvider(create: (_) => sl<AuthCubit>()),

        BlocProvider(create: (_) => sl<DoctorListCubit>()),

        BlocProvider(create: (_) => sl<AppSettingsCubit>()),

        BlocProvider<DoctorAppointmentsCubit>(
          create: (context) => sl<DoctorAppointmentsCubit>(),
        ),
        BlocProvider<TimeSlotCubit>(create: (context) => sl<TimeSlotCubit>()),

        BlocProvider<BookAppointmentCubit>(
          create: (context) => sl<BookAppointmentCubit>(),
        ),

        BlocProvider<PatientCubit>(create: (context) => sl<PatientCubit>()),

        BlocProvider<CancelAppointmentCubit>(
          create: (context) => sl<CancelAppointmentCubit>(),
        ),

        BlocProvider<UpcomingAppointmentsCubit>(
          create: (context) => sl<UpcomingAppointmentsCubit>(),
        ),
        BlocProvider<CompletedAppointmentsCubit>(
          create: (context) => sl<CompletedAppointmentsCubit>(),
        ),
        BlocProvider<CancelledAppointmentsCubit>(
          create: (context) => sl<CancelledAppointmentsCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        // useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        routerConfig: AppRouter.router,
        // 🔥 تمرير الـ GoRouter
        title: 'Medora App',
        debugShowCheckedModeBanner: false,
        theme: AppLightTheme.theme,
        themeMode: ThemeMode.light,

        builder: (context, child) {
          return BlocListener<AppSettingsCubit, AppSettingsStates>(
            listenWhen: (previous, current) =>
                previous.internetState != current.internetState,
            listener: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _handleInternetStateChange(
                  AppRouter.router.routerDelegate.navigatorKey.currentContext!,
                  state.internetState,
                );
              });
            },
            child: child,
          );
        },
      ),
    );
  }

  void _handleInternetStateChange(
    BuildContext context,
    InternetState internetState,
  ) {
    if (internetState == InternetState.disconnected) {
      OverlayNotificationService.show(
        context: context,

        message: AppStrings.noInternetConnection,
        type: SnackBarType.error,
      );
    } else if (internetState == InternetState.connected) {
      OverlayNotificationService.show(
        context: context,

        message: AppStrings.internetConnected,
        type: SnackBarType.success,
      );
    }
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String? _selectedImagePath;

  // دالة اختيار الصورة من المعرض
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path; // تخزين المسار
      });
    }
  }

  Future<ui.Image?> generateLocalPreview(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);

      // استخدام Accurate Mode لمعالجة أدق
      final segmenter = SelfieSegmenter(
        mode: SegmenterMode.single,
        enableRawSizeMask:
            false, // تجعل الحجم متوافقاً مع أبعاد InputImage تلقائياً
      );

      final SegmentationMask? mask = await segmenter.processImage(inputImage);
      await segmenter.close();

      if (mask == null) {
        debugPrint('ML Kit Mask returned null');
        return null;
      }

      return await _applyMaskToImage(File(imagePath), mask);
    } catch (e, stackTrace) {
      // طباعة الاستثناء الحقيقي لنعرف السبب المباشر
      debugPrint('ML Kit Preview Error: $e');
      debugPrint('StackTrace: $stackTrace');
      return null;
    }
  }

  /*
  Future<ui.Image> _applyMaskToImage(File imageFile,
      SegmentationMask mask) async {
    // 1. تحميل الصورة الأصلية كـ ui.Image
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image originalImage = frameInfo.image;

    final int maskWidth = mask.width;
    final int maskHeight = mask.height;
    final List<double> confidences = mask.confidences;

    // 2. تحويل بيانات الـ Confidences إلى قناع بكسلات (Image Mask)
    final Uint8List maskPixels = Uint8List(maskWidth * maskHeight * 4);

    for (int i = 0; i < confidences.length; i++) {
      final double confidence = confidences[i];
      // تحديد درجة الشفافية بناءً على نسبة ثقة الخوارزمية في وجود الشخص (Confidence)
      final int alpha = (confidence * 255).clamp(0, 255).toInt();

      final int pixelIndex = i * 4;
      maskPixels[pixelIndex] = 255; // Red
      maskPixels[pixelIndex + 1] = 255; // Green
      maskPixels[pixelIndex + 2] = 255; // Blue
      maskPixels[pixelIndex + 3] = alpha; // Alpha (الشفافية)
    }

    // 3. إنتاج صورة القناع (Mask Image)
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
        maskPixels);
    final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: maskWidth,
      height: maskHeight,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final ui.Codec maskCodec = await descriptor.instantiateCodec();
    final ui.FrameInfo maskFrame = await maskCodec.getNextFrame();
    final ui.Image maskImage = maskFrame.image;

    // 4. دمج الصورة الأصلية مع القناع باستخدام BlendMode.dstIn
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint();

    final Rect rect = Rect.fromLTWH(
      0,
      0,
      originalImage.width.toDouble(),
      originalImage.height.toDouble(),
    );

    // رسم الصورة الأصلية
    canvas.drawImageRect(originalImage, rect, rect, paint);

    // تطبيق القناع لقص الخلفية فقط وإبقاء الشخص
    paint.blendMode = ui.BlendMode.dstIn;
    canvas.drawImageRect(
      maskImage,
      Rect.fromLTWH(0, 0, maskWidth.toDouble(), maskHeight.toDouble()),
      rect,
      paint,
    );

    // 5. استخراج الصورة الشفافة النهائية
    final ui.Image resultImage = await recorder.endRecording().toImage(
      originalImage.width,
      originalImage.height,
    );

    return resultImage;
  }*/
  Future<ui.Image> _applyMaskToImage(
    File imageFile,
    SegmentationMask mask,
  ) async {
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image originalImage = frameInfo.image;

    final int maskWidth = mask.width;
    final int maskHeight = mask.height;
    final List<double> confidences = mask.confidences;

    final Uint8List maskPixels = Uint8List(maskWidth * maskHeight * 4);

    for (int i = 0; i < confidences.length; i++) {
      final double confidence = confidences[i];

      // 💡 التحسين الأول: قطع الشفافية الضعيفة لمنع ظهور الهالة السوداء (Hard Cutoff)
      // أي بكسل نسبة ثقته أقل من 75% يعتبر خلفية كلياً (0)، وما فوق ذلك يعتبر جسماً (255)
      final int alpha = confidence > 0.75 ? 255 : 0;

      final int pixelIndex = i * 4;
      maskPixels[pixelIndex] = 255;
      maskPixels[pixelIndex + 1] = 255;
      maskPixels[pixelIndex + 2] = 255;
      maskPixels[pixelIndex + 3] = alpha;
    }

    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(
      maskPixels,
    );
    final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: maskWidth,
      height: maskHeight,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final ui.Codec maskCodec = await descriptor.instantiateCodec();
    final ui.FrameInfo maskFrame = await maskCodec.getNextFrame();
    final ui.Image maskImage = maskFrame.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // 💡 التحسين الثاني: إضافة Filter لتنعيم الحواف المشرشرة بسيطة
    final Paint maskPaint = Paint()
      ..imageFilter = ui.ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8);

    final Rect rect = Rect.fromLTWH(
      0,
      0,
      originalImage.width.toDouble(),
      originalImage.height.toDouble(),
    );

    // رسم الصورة الأصلية
    canvas.drawImageRect(originalImage, rect, rect, Paint());

    // تطبيق القناع المحسّن
    maskPaint.blendMode = ui.BlendMode.dstIn;
    canvas.drawImageRect(
      maskImage,
      Rect.fromLTWH(0, 0, maskWidth.toDouble(), maskHeight.toDouble()),
      rect,
      maskPaint,
    );

    return await recorder.endRecording().toImage(
      originalImage.width,
      originalImage.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://res.cloudinary.com/dfls3gdea/image/upload/v1787572054/yousab_sefeen_v4psqv.jpg';
    return Scaffold(
      appBar: AppBar(title: const Text('Test Screen')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('اختر صورة الطبيب'),
            ),
            const SizedBox(height: 20),

            // 2. التحقق من وجود مسار الصورة أولاً قبل استدعاء الدالة
            if (_selectedImagePath != null)
              FutureBuilder<ui.Image?>(
                // نمرر المتغير المعرّف هنا
                future: generateLocalPreview(_selectedImagePath!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      width: 200.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: AppColors.customWhite,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      // child: RawImage(
                      //
                      //   image: snapshot.data,
                      //   fit: BoxFit.cover,
                      //   height: double.infinity,
                      // ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        //  '${image.replaceAll('/upload/', '/upload/e_background_removal/').replaceAll('.jpg', '.png')}',
                        imageUrl
                            .replaceAll(
                              '/upload/',
                              '/upload/e_background_removal/',
                            )
                            .replaceAll('.jpg', '.png'),
                      ),
                    );
                  }

                  return const Text('تعذر إنتاج المعاينة');
                },
              ),
          ],
        ),
      ),
    );
  }
}
