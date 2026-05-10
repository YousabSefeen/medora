import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as types;
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image_picker/image_picker.dart'
    show XFile, ImagePicker, ImageSource;
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/mappers/specialty_mapper.dart' show SpecialtyMapper;
import 'package:medora/core/utils/language_detector.dart' show LanguageDetector;
import 'package:medora/features/doctors_specialties/presentation/screens/specialty_doctors_screen.dart'
    show SpecialtyDoctorsScreen;
import 'package:medora/features/gemini/presentation/controllers/cubit/google_gemini_cubit.dart'
    show GoogleGeminiCubit;
import 'package:medora/features/gemini/presentation/widgets/custom_chat.dart';
import 'package:medora/features/gemini/presentation/widgets/gemini_chat_app_bar.dart'
    show GeminiChatAppBar;

class GeminiChatScreen extends StatefulWidget {
  const GeminiChatScreen({super.key});

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> {
  late final ImagePicker _picker;
  late final types.InMemoryChatController _chatController;

  static const String _myId = 'user1';
  static const String _geminiId = 'gemini_bot';

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _chatController = InMemoryChatController();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleGeminiCubit(),
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        appBar: const GeminiChatAppBar(),
        body: Builder(
          builder: (context) => CustomChat(
            chatController: _chatController,
            myId: _myId,
            geminiId: _geminiId,
            resolveUser: _resolveUser,
            onMessageSend: (text) => _onUserSubmit(context, text),
            onCameraTap: () => _pickImage(context, ImageSource.camera),
            onGalleryTap: () => _pickImage(context, ImageSource.gallery),
            onLinkTap: (href) => _handleSpecialtyNavigation(context, href),
          ),
        ),
      ),
    );
  }

  /// تقوم بجلب بيانات المستخدم بناءً على معرفه لتمييز الرسائل في واجهة المحادثة.
  Future<User> _resolveUser(UserID id) async {
    return id == _myId
        ? const User(id: _myId, name: 'يوساب')
        : const User(id: _geminiId, name: 'Gemini AI');
  }

  /// الدالة المسؤولة عن معالجة إرسال المستخدم، سواء كان نصاً فقط أو نصاً مع صورة،
  /// ثم تهيئة تدفق الرد من الذكاء الاصطناعي.
  void _onUserSubmit(BuildContext context, String text) {
    final cubit = context.read<GoogleGeminiCubit>();
    final imagePath = cubit.state.sourceImage;

    _displayUserContent(text, imagePath);
    _processGeminiResponse(context, text);
  }

  /// تعنى بإظهار محتوى المستخدم (نص/صورة) في قائمة المحادثة فور الإرسال،
  /// مع مراعاة لغة النص والوسائط المرفقة.
  void _displayUserContent(String text, String imagePath) {
    if (imagePath.isNotEmpty) {
      _insertImageMessage(imagePath);
    }

    if (text.trim().isNotEmpty) {
      _insertTextMessage(text, _myId);
    }
  }

  /// تدير عملية استقبال الرد من Gemini وتحديث رسالة الرد بشكل لحظي (Streaming)
  /// لضمان تجربة مستخدم سلسة وتفاعلية.
  void _processGeminiResponse(BuildContext context, String text) {
    String? responseMsgId;
    TextMessage? lastResponseMsg;

    context.read<GoogleGeminiCubit>().onActionSend(
      text: text,
      onUpdate: (fullText, isDone, lang) {
        if (responseMsgId == null) {
          responseMsgId = 'gemini_${DateTime.now().millisecondsSinceEpoch}';
          lastResponseMsg = _createTextMessage(
            fullText,
            _geminiId,
            responseMsgId!,
            lang.name,
          );
          _chatController.insertMessage(lastResponseMsg!);
        } else {
          final updatedMsg = lastResponseMsg!.copyWith(
            text: fullText,
            metadata: {'language': lang.name},
          );
          _chatController.updateMessage(lastResponseMsg!, updatedMsg);
          lastResponseMsg = updatedMsg;
        }
      },
    );
  }

  void _insertTextMessage(String text, String authorId) {
    final lang = LanguageDetector.detectLanguage(text);
    final id = 'msg_${DateTime.now().millisecondsSinceEpoch}';
    _chatController.insertMessage(
      _createTextMessage(text, authorId, id, lang.name),
    );
  }

  void _insertImageMessage(String path) => _chatController.insertMessage(
    ImageMessage(
      id: 'img_${DateTime.now().millisecondsSinceEpoch}',
      authorId: _myId,
      createdAt: DateTime.now(),
      source: path,
    ),
  );

  TextMessage _createTextMessage(
    String text,
    String authorId,
    String id,
    String langName,
  ) => TextMessage(
    id: id,
    authorId: authorId,
    text: text,
    createdAt: DateTime.now(),
    metadata: {'language': langName},
  );

  /// تتعامل مع اختيار الصور من الكاميرا أو الاستوديو وتخزين المسار في الحالة (State)
  /// لعرضها كمعاينة قبل الإرسال النهائي.
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (context.mounted && image != null) {
      context.read<GoogleGeminiCubit>().setSourceImage(image.path);
    }
  }

  // دالة المنطق بداخل GeminiChatScreen
  void _handleSpecialtyNavigation(BuildContext context, String? href) {
    if (href == null || !href.startsWith('specialty://')){
      log('Invalid specialty link: $href');
      return;
    }
    log(' Success specialty link: $href');

    final idString = href.replaceFirst('specialty://', '');
    final specialtyId = int.tryParse(idString);

    if (specialtyId != null && specialtyId > 0) {
      log('specialtyId: $specialtyId');
      final specialtyName = SpecialtyMapper.getEnglishName(specialtyId);
      log('specialtyName: $specialtyName');
      AppRouter.push(
        context,
        SpecialtyDoctorsScreen(specialtyName: specialtyName),
      );
      // هنا يمكنك وضع Navigator.push أو أي منطق أعمال آخر
    }
  }
}
