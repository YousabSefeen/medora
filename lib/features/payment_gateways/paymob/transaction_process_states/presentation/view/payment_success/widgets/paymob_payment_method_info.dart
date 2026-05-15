import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart'
    show ThemeExtension;
import 'package:medora/core/extensions/transaction_display.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;

import '../../../../../../../../../../../../generated/assets.dart';
import '../../../../../../presentation/views/widgets/payment_method_icon.dart' show PaymentMethodIcon;


class PaymobPaymentMethodInfo extends StatelessWidget {
  final PaymobTransactionDataResultModel transactionData;

  const PaymobPaymentMethodInfo({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.largeInterBold;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        children: [
          Expanded(child: _getPaymentMethodIcon()),

          Expanded(
            flex: 3,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${transactionData.sourceSubType!.toUpperCase()}\n',
                    style: textStyle,
                  ),
                  TextSpan(
                    text: transactionData.displaySourceIdentifier,
                    style: textStyle.copyWith(
                      letterSpacing: 1,
                      color: Colors.black54,
                      wordSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPaymentMethodIcon() {
    // 1. تحديد الصورة بناءً على الشرط
    final isWallet = transactionData.sourceSubType == 'wallet';
    final imageProvider = isWallet
        ? Assets.images.mobileWalletsLogo.provider()
        : Assets.images.masterCard.provider();

    // 2. إرجاع الـ Widget الموحدة
    return PaymentMethodIcon(imageProvider: imageProvider);
  }
}
