import 'package:medora/features/payment_gateways/paymob/transaction_process_states/data/models/paymob_transaction_data_result_model.dart'
    show PaymobTransactionDataResultModel;

extension TransactionDisplay on PaymobTransactionDataResultModel {
  bool get _isWallet => sourceSubType == 'wallet';

  String get displaySourceIdentifier {
    if (sourceDataPan == null || sourceDataPan!.isEmpty) {
      return _isWallet ? '' : '**** **** **** ';
    }
    return _isWallet
        ? sourceDataPan!.maskAllButLast4()
        : '**** **** **** ${sourceDataPan!}';
  }
}

extension StringMasking on String {
  String maskAllButLast4({int visibleCount = 4}) {
    if (length <= visibleCount) return this;
    return '*' * (length - visibleCount) + substring(length - visibleCount);
  }
}
