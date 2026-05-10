import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as types;
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart'
    show MarkdownBody;
import 'package:flutter_markdown_plus/src/style_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart'
    show AppTextStyles;
import 'package:medora/core/enum/languages.dart' show Languages;
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/core/mappers/specialty_mapper.dart' show SpecialtyMapper;
import 'package:medora/features/gemini/presentation/widgets/gemini_chat_composer.dart'
    show GeminiChatComposer;
import 'package:medora/generated/assets.dart' show Assets;

class CustomChat extends StatelessWidget {
  final types.InMemoryChatController chatController;
  final String myId;
  final String geminiId;
  final void Function(String)? onMessageSend;
  final void Function() onCameraTap;
  final void Function() onGalleryTap;
  final void Function(String? href) onLinkTap; // إضافة هذا الـ Callback
  final Future<User?> Function(String) resolveUser;

  const CustomChat({
    super.key,
    required this.chatController,
    required this.myId,
    required this.geminiId,
    required this.onMessageSend,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onLinkTap,
    required this.resolveUser,
  });

  @override
  Widget build(BuildContext context) {
    return Chat(
      chatController: chatController,
      currentUserId: myId,
      onMessageSend: onMessageSend,
      builders: Builders(
        emptyChatListBuilder: (ctx) => _buildEmptyChatListBuilder(context),
        composerBuilder: (ctx) => GeminiChatComposer(
          context: ctx,
          onCameraTap: onCameraTap,
          onGalleryTap: onGalleryTap,
        ),
        textMessageBuilder: _buildTextMessage,
        imageMessageBuilder:
            (
              BuildContext ctx,
              types.ImageMessage msg,
              int idx, {
              required bool isSentByMe,
              types.MessageGroupStatus? groupStatus,
            }) => _buildImageBubble(msg),
      ),
      resolveUser: resolveUser,
    );
  }

  Center _buildEmptyChatListBuilder(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.imagesFriendlyRobot, width: 0.6.sw),
          SizedBox(height: 20.h),
          Text(
            AppStrings.welcomeChatMessage,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.softBlue,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              AppStrings.medicalAssistantSubline,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.15),
        ],
      ),
    ),
  );

  /// Building a text message bubble with text direction handling and subject links.
  Widget _buildTextMessage(
    BuildContext context,
    TextMessage message,
    int index, {
    required bool isSentByMe,
    MessageGroupStatus? groupStatus,
  }) {
    final lang = _getMessageLanguage(message);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: _buildBubbleDecoration(isSentByMe),
      child: Directionality(
        textDirection: lang == Languages.english
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: MarkdownBody(
          data: _processMessageText(message, lang),
          onTapLink: (text, href, title) => onLinkTap(href), // تم تمريره للخارج
          selectable: true,
          styleSheet: _buildMarkdownStyle(context, isSentByMe),
        ),
      ),
    );
  }

  MarkdownStyleSheet _buildMarkdownStyle(
    BuildContext context,
    bool isSentByMe,
  ) {
    final textColor = isSentByMe ? AppColors.white : AppColors.black87;
    return MarkdownStyleSheet(
      a: context.textTheme.linkTextStyle,
      p: context.textTheme.arabicStyle.copyWith(color: textColor),
      pPadding: EdgeInsets.only(bottom: 8.h),
      listIndent: 16.w,
    );
  }

  BoxDecoration _buildBubbleDecoration(bool isSentByMe) {
    final backGroundColor = isSentByMe
        ? AppColors.softBlue
        : Colors.grey.shade100;
    return BoxDecoration(
      color: backGroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
        bottomLeft: Radius.circular(isSentByMe ? 16.r : 0),
        bottomRight: Radius.circular(isSentByMe ? 0 : 16.r),
      ),
    );
  }

  /// Processes raw message text by identifying specific codes (e.g., 555)
  /// and converting them into clickable Markdown links.
  String _processMessageText(types.TextMessage message, Languages lang) =>
      message.text.replaceAllMapped(
        RegExp(r'555\s+([a-zA-Z\s\-,]+?)\s+555', multiLine: true),
        (match) => _mapScientificNameToLink(match.group(1), lang),
      );

  /// Maps a specialty's scientific name to a Markdown link format
  /// using a custom scheme (specialty://id) for internal navigation.
  String _mapScientificNameToLink(String? rawName, Languages lang) {
    final scientificName = rawName?.trim() ?? '';
    final specialtyId = SpecialtyMapper.getSpecialtyId(scientificName);

    if (scientificName.toLowerCase() == 'none' || specialtyId == -1) return '';

    return lang == Languages.arabic
        ? 'تخصص [**${SpecialtyMapper.getArabicName(specialtyId)}**](specialty://$specialtyId)'
        : 'Specialty [**$scientificName**](specialty://$specialtyId)';
  }

  Languages _getMessageLanguage(TextMessage message) =>
      message.metadata?['language'] == 'arabic'
      ? Languages.arabic
      : Languages.english;

  Widget _buildImageBubble(ImageMessage message) => Container(
    margin: const EdgeInsets.all(8),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Image.file(
      File(message.source),
      fit: BoxFit.cover,
      width: 0.6.sw,
      height: 200.h,
    ),
  );
}
