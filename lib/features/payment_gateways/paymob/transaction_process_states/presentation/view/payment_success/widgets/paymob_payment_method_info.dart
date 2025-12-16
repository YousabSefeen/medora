import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;

import '../../../../../../../../../../../../generated/assets.dart';
import '../../../../../../Presentation/Views/widgets/custom _image_widget.dart';

class PaymobPaymentMethodInfo extends StatelessWidget {
  final PaymobTransactionDataResultModel transactionData;

  const PaymobPaymentMethodInfo({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        children: [
          _getPaymentMethodIcon(),
          const SizedBox(width: 23),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${transactionData.sourceSubType!.toUpperCase()}\n', //
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextSpan(
                  text: transactionData.sourceSubType == 'wallet'
                      ? transactionData.sourceDataPan
                      : '**** **** **** ${transactionData.sourceDataPan}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPaymentMethodIcon() {
    if (transactionData.sourceSubType == 'MasterCard') {
      return const CustomImageWidget(image: Assets.imagesMasterCard);
    } else if (transactionData.sourceSubType == 'wallet') {
      return const CustomImageWidget(image: Assets.imagesMobileWalletsLogo);
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: AppColors.softBlue,
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: FaIcon(
          FontAwesomeIcons.ccVisa,
          color: Colors.white,
          size: 35.sp,
        ),
      );
    }
  }
}
