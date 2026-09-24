import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as types;
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../controllers/cubit/gemini_cubit.dart';
import '../helpers/chat_message_factory.dart';
import '../helpers/specialty_link_handler.dart';
import '../widgets/custom_chat.dart';
import '../widgets/gemini_chat_app_bar.dart';

class GeminiChatScreen extends StatelessWidget {
  const GeminiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GeminiCubit>(),

      child: const Scaffold(
        backgroundColor: AppColors.customWhite,
        appBar: GeminiChatAppBar(),
        body: GeminiChatBody(),
      ),
    );
  }
}

class GeminiChatBody extends StatefulWidget {
  const GeminiChatBody({super.key});

  @override
  State<GeminiChatBody> createState() => _GeminiChatBodyState();
}

class _GeminiChatBodyState extends State<GeminiChatBody> {
  late final ImagePicker _imagePicker;
  late final types.InMemoryChatController _chatController;

  static const String _userId = 'user1';
  static const String _geminiId = 'gemini_bot';

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _chatController = types.InMemoryChatController();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomChat(
      chatController: _chatController,
      myId: _userId,
      geminiId: _geminiId,
      resolveUser: _resolveUser,
      onMessageSend: (text) => _handleUserSubmit(context, text),
      onCameraTap: () => _pickAndSetImage(context, ImageSource.camera),
      onGalleryTap: () => _pickAndSetImage(context, ImageSource.gallery),
      onLinkTap: (href) => SpecialtyLinkHandler.handleNavigation(context, href),
    );
  }

  // Resolves user metadata based on ID for chat avatar and display labels.
  Future<types.User> _resolveUser(types.UserID id) async {
    return id == _userId
        ? const types.User(id: _userId, name: 'Yousab')
        : const types.User(id: _geminiId, name: 'Gemini AI');
  }

  // Main handler for user submissions, dispatching user messages and initiating AI response streaming.
  void _handleUserSubmit(BuildContext context, String text) {
    final cubit = context.read<GeminiCubit>();
    final imagePath = cubit.state.sourceImage;

    _renderUserMessages(text: text, imagePath: imagePath);
    _streamGeminiResponse(context, text);
  }

  // Renders both local user media and text messages to the chat controller UI.
  void _renderUserMessages({required String text, required String imagePath}) {
    if (imagePath.isNotEmpty) {
      final imageMessage = ChatMessageFactory.createImageMessage(
        imagePath: imagePath,
        authorId: _userId,
      );
      _chatController.insertMessage(imageMessage);
    }

    if (text.trim().isNotEmpty) {
      final textMessage = ChatMessageFactory.createTextMessage(
        text: text,
        authorId: _userId,
      );
      _chatController.insertMessage(textMessage);
    }
  }

  // Subscribes to Gemini streaming responses and performs dynamic message creation/updates.
  void _streamGeminiResponse(BuildContext context, String text) {
    String? responseMsgId;
    types.TextMessage? lastResponseMsg;

    context.read<GeminiCubit>().onActionSend(
      text: text,
      onUpdate: (fullText, isDone, lang) {
        if (responseMsgId == null) {
          responseMsgId = 'gemini_${DateTime.now().millisecondsSinceEpoch}';
          lastResponseMsg = ChatMessageFactory.createTextMessage(
            text: fullText,
            authorId: _geminiId,
            customId: responseMsgId,
            language: lang.name,
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

  // Handles media capture/selection and passes the asset path to the Cubit state.
  Future<void> _pickAndSetImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final XFile? image = await _imagePicker.pickImage(source: source);
    if (context.mounted && image != null) {
      context.read<GeminiCubit>().setSourceImage(image.path);
    }
  }
}
