import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart'
    show Composer, SendButtonVisibilityMode;
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/gemini/presentation/controllers/cubit/google_gemini_cubit.dart'
    show GoogleGeminiCubit;
import 'package:medora/features/gemini/presentation/controllers/states/gemini_chat_state.dart'
    show GeminiChatState;

class GeminiChatComposer extends StatefulWidget {
  final BuildContext context;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const GeminiChatComposer({
    super.key,
    required this.context,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  State<GeminiChatComposer> createState() => _GeminiChatComposerState();
}

class _GeminiChatComposerState extends State<GeminiChatComposer> {
  late TextEditingController _textEditingController;

  // 1. تعريف متغير الحالة لاتجاه النص (الافتراضي حسب لغة جهازك أو تطبيقك)
  TextDirection _textDirection = TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();

    // 2. إضافة مستمع لتغيرات النص
    _textEditingController.addListener(_handleTextDirection);
  }

  // 3. دالة تحديد الاتجاه بناءً على أول حرف
  void _handleTextDirection() {
    if (_textEditingController.text.isEmpty ||
        _textEditingController.text.trim().isEmpty ||
        _textEditingController.text.trim().length > 1) {
      return;
    } else {
      // الحصول على أول حرف
      String firstChar = _textEditingController.text.trim().substring(0, 1);

      // فحص إذا كان الحرف يقع ضمن نطاق الحروف العربية
      final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);

      TextDirection newDirection = isArabic
          ? TextDirection.rtl
          : TextDirection.ltr;

      // تحديث الواجهة فقط إذا تغير الاتجاه لتوفير الأداء
      if (newDirection != _textDirection) {
        setState(() {
          _textDirection = newDirection;
        });
      }
    }
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_handleTextDirection);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _textDirection,
      child: BlocSelector<GoogleGeminiCubit, GeminiChatState, String>(
        selector: (state) => state.sourceImage,
        builder: (context, sourceImage) => Composer(
          sigmaY: 0,
          sigmaX: 0,
          left: 2,
          right: 0,
          attachmentGap: 0,

          backgroundColor: AppColors.white,
          allowEmptyMessage: sourceImage == '' ? false : true,

          sendButtonVisibilityMode: sourceImage == ''
              ? SendButtonVisibilityMode.disabled
              : SendButtonVisibilityMode.always,
          textEditingController: _textEditingController,
          inputFillColor: AppColors.customWhite,
          padding: const EdgeInsets.only(bottom: 10),
          sendIcon: Icon(Icons.send, size: 25.sp),
          topWidget: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 2),
            child: Align(
              alignment: _textDirection == TextDirection.rtl
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: _buildImageMessage(sourceImage),
            ),
          ),
          sendIconColor: AppColors.green,
          attachmentWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                // onPressed: widget.onCameraTap,
                onPressed: () {
                  print('sourceImage $sourceImage');
                },
                icon: FaIcon(FontAwesomeIcons.camera, size: 20.sp),
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                constraints: const BoxConstraints(),

                onPressed: widget.onGalleryTap,

                icon: FaIcon(FontAwesomeIcons.image, size: 20.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageMessage(String sourceImage) => sourceImage == ''
      ? const SizedBox()
      : Container(
          margin: const EdgeInsets.all(0),

          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: AppColors.customWhite,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.file(
                File(sourceImage),
                fit: BoxFit.fill,
                width: 50,
                height: 50,
              ),
              IconButton(
                constraints: const BoxConstraints(),
                iconSize: 20.sp,
                onPressed: () {
                  widget.context.read<GoogleGeminiCubit>().setSourceImage('');
                },
                icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
              ),
            ],
          ),
        );
}
