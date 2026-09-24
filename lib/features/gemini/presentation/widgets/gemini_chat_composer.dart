import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/features/gemini/presentation/controllers/cubit/gemini_cubit.dart';
import 'package:medora/features/gemini/presentation/controllers/states/gemini_state.dart';

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

  TextDirection _textDirection = TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();

    _textEditingController.addListener(_handleTextDirection);
  }

  //   Function to determine direction based on the first letter
  void _handleTextDirection() {
    if (_textEditingController.text.isEmpty ||
        _textEditingController.text.trim().isEmpty ||
        _textEditingController.text.trim().length > 1) {
      return;
    } else {
      // Get the first character
      String firstChar = _textEditingController.text.trim().substring(0, 1);

      // Check if the character falls within the range of Arabic characters
      final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(firstChar);

      TextDirection newDirection = isArabic
          ? TextDirection.rtl
          : TextDirection.ltr;

      // Update the interface only if the orientation changes to optimize performance.
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
      child: BlocSelector<GeminiCubit, GeminiState, String>(
        selector: (state) => state.sourceImage,
        builder: (context, sourceImage) => Composer(
          sigmaY: 0,
          sigmaX: 0,
          left: 2,
          right: 0,

          backgroundColor: AppColors.white,
          allowEmptyMessage: sourceImage == '' ? false : true,

          sendButtonVisibilityMode: sourceImage == ''
              ? SendButtonVisibilityMode.disabled
              : SendButtonVisibilityMode.always,
          textEditingController: _textEditingController,
          inputFillColor: AppColors.customWhite,
          padding: const EdgeInsets.only(bottom: 10),
          sendIcon: Icon(Icons.send, size: 25.sp),
          gap: 5,
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
          attachmentIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: IconButton(
                  constraints: const BoxConstraints(),
                  onPressed: widget.onCameraTap,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: const CircleBorder(),
                  ),

                  icon: FaIcon(FontAwesomeIcons.camera, size: 20.r),
                ),
              ),
              Expanded(
                child: IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  constraints: const BoxConstraints(),

                  onPressed: widget.onGalleryTap,

                  icon: FaIcon(FontAwesomeIcons.image, size: 20.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageMessage(String sourceImage) => sourceImage == ''
      ? const SizedBox()
      : Material(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(15),

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
                iconSize: 20.r,
                onPressed: () =>
                    widget.context.read<GeminiCubit>().clearSourceImage( ),
                icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
              ),
            ],
          ),
        );
}
