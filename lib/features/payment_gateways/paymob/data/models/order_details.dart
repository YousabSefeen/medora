





import 'package:medora/features/payment_gateways/paymob/data/models/paymob_billing_data_model.dart' show PaymobBillingDataModel;
import 'package:medora/features/payment_gateways/paymob/data/models/paymob_order_request_model.dart' show ShippingData, OrderItem;

class OrderDetails {
  final double totalAmount;
  final ShippingData shippingData;
  final List<OrderItem> orderItems;
  final PaymobBillingDataModel? billingData;

  OrderDetails({
    required this.totalAmount,
    required this.shippingData,
    required this.orderItems,
    this.billingData,
  });
}
