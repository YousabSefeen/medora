import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/transaction_display.dart';
import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;

import '../../../../../../../../../../../../generated/assets.dart';
import '../../../../../../Presentation/Views/widgets/custom _image_widget.dart';

class PaymobPaymentMethodInfo extends StatelessWidget {
  final PaymobTransactionDataResultModel transactionData;

  const PaymobPaymentMethodInfo({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.largeInterBold;
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
    if (transactionData.sourceSubType == 'wallet') {
      return const CustomImageWidget(image: Assets.imagesMobileWalletsLogo);
    } else {
      return const CustomImageWidget(image: Assets.imagesMasterCard);
    }
  }
}
