import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/common_widgets/pop_scope_for_payment_gateways.dart';

import '../widgets/error_indicator_avatar.dart';
import '../widgets/retry_payment_button.dart';
import '../widgets/use_a_different_card_button.dart';

class PaymentFailedScreen extends StatelessWidget {
  final String paymentMethod;
  final String? errorMessage;

  const PaymentFailedScreen({super.key,   this.errorMessage, required this.paymentMethod});

  final title = 'Oops! Invalid Card Number';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return PopScopeForPaymentGateways(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: deviceSize.width * .9,
                child: Card(
                  elevation: 4,
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                    top: Radius.circular(15.r),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40.h),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 18.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20.r)),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            paymentMethod == 'paymob'
                                ?   _PaymobErrorMessage(errorMessage:errorMessage )
                                : _paymentErrorMessage(errorMessage!),
                            SizedBox(height: 25.h),
                            const RetryPaymentButton(),
                            SizedBox(height: 15.h),
                            const UseADifferentCardButton(),
                            SizedBox(height: 15.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -27,
                left: deviceSize.width * .36,
                child: const ErrorIndicatorAvatar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _paymentErrorMessage(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        error,
        style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.5),
        textAlign: TextAlign.center,

      ),
    );
  }
}


class _PaymobErrorMessage extends StatelessWidget {
  final String? errorMessage;
  const _PaymobErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        textAlign: TextAlign.center,
        //  text:  _buildHighlightedText(invalidCardMessage ,),
        text: _buildHighlightedText(
          text:
         errorMessage?? 'Null',
        ),
      ),
    );
  }

  TextSpan _buildHighlightedText({required String text}) {
    final TextStyle generalTextStyle = TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
        height: 1.5);
    final TextStyle boldWordsTextStyle = GoogleFonts.roboto(
        textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: .5));
    final List<String> boldWords = [
      'Card Number',
      'Number',
      'Expiration Date',
      'CVV'
    ];
    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in RegExp(boldWords.join("|")).allMatches(text)) {
      // إضافة النص العادي قبل الكلمة المحددة
      if (match.start > lastIndex) {
        spans.add(TextSpan(
            text: text.substring(lastIndex, match.start),
            style: generalTextStyle));
      }

      // إضافة الكلمة بخط سميك
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: boldWordsTextStyle,
      ));

      lastIndex = match.end;
    }

    // إضافة أي نص متبقي بعد آخر كلمة مميزة
    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: generalTextStyle,
      ));
    }

    return TextSpan(
      children: spans,
    );
  }
}