import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

import '../../../../core/animations/animated_fade_transition.dart';

class DeveloperNoteDialog extends StatelessWidget {
  const DeveloperNoteDialog({super.key});

  final String developerNote =
      '''   في هذا الجزء من الكود، قمت بتهيئة عملية التقاط صورة المستخدم سواء من الكاميرا أو المعرض باستخدام ImagePicker.
  بعد التقاط الصورة، يتم حفظها في المتغير _image، ولكن لا يتم رفعها إلى Firebase Cloud Storage فعليًا في الوقت الحالي.

  السبب: يتطلب تفعيل Cloud Storage بشكل كامل ربط وسيلة دفع (بطاقة بنكية)، وهو غير متاح لي حاليًا، 
  كما أنه ليس ضمن متطلبات المهمة الحالية حسب المطلوب.

  كبديل، قمت بإضافة صورة وهمية (fake doctor image) يتم عرضها بعد التقاط الصورة الحقيقية، 
  وذلك بهدف توضيح كيف سيكون الشكل النهائي للتطبيق عند تفعيل ميزة رفع الصور.

  هذا الأسلوب يعكس فهمي لكيفية التكامل مع Firebase Storage، وتحضير الكود ليكون جاهزًا للتنفيذ الفعلي بمجرد تفعيل الخدمة.

  شكراً لتفهمكم.''';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedFadeTransition(
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              _dialogHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      developerNote,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
                backgroundColor: WidgetStatePropertyAll(AppColors.green),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('تم'),
            ),
          ],
        ),
      ),
    );
  }

  Container _dialogHeader() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r), topLeft: Radius.circular(12.r)),
        ),
        child: Text(
          ' ملاحظة للمقيّم',
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      );
}
