import 'package:medora/features/payment_gateways/paypal/data/model/item_list_model.dart'
    show ItemListModel;
import 'package:medora/features/payment_gateways/paypal/data/model/item_model.dart'
    show ItemModel;
import 'package:medora/features/payment_gateways/paypal/data/model/paypal_payment_transaction_model.dart'
    show PaypalPaymentTransactionModel;

import '../../../features/payment_gateways/paypal/data/model/amount_model.dart'
    show AmountModel;
import '../../../features/payment_gateways/paypal/data/model/details_model.dart'
    show DetailsModel;

class PaypalDummyDataService {
  static PaypalPaymentTransactionModel get paypalPaymentTransactionModel =>
      PaypalPaymentTransactionModel(
        description: 'The payment transaction description.',
        amount: AmountModel(
          total: '100',
          currency: 'USD',
          details: DetailsModel(
            subtotal: '100',
            shipping: '0',
            shipping_discount: 0,
          ),
        ),
        itemList: ItemListModel(
          items: [
            ItemModel(name: 'Apple', quantity: 10, price: '5', currency: 'USD'),
            ItemModel(
              name: 'Pineapple',
              quantity: 10,
              price: '5',
              currency: 'USD',
            ),
          ],
        ),
      );
}
