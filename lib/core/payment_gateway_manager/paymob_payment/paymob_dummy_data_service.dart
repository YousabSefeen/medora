import 'package:medora/features/payment_gateways/paymob/data/models/order_details.dart'
    show OrderDetails;
import 'package:medora/features/payment_gateways/paymob/data/models/paymob_billing_data_model.dart'
    show PaymobBillingDataModel;
import 'package:medora/features/payment_gateways/paymob/data/models/paymob_order_request_model.dart'
    show ShippingData, OrderItem;

class PaymobDummyDataService {
  //Dummy data
  static ShippingData get shippingData => ShippingData(
    firstName: 'Test',
    lastName: 'Account',
    phoneNumber: '01010101010',
    email: 'test@account.com',
  );

  static List<OrderItem> get orderItems => [
    OrderItem(
      name: 'Product 1',
      amountCents: 3000 * 100, //60 جنيه
      quantity: 2,
      description: 'Product 1 description',
    ),
    OrderItem(
      name: 'Product 2',
      amountCents: 5000 * 100, // 50 جنيه
      quantity: 1,
      description: 'Product 2 description',
    ),
  ];

  static PaymobBillingDataModel get billingData => PaymobBillingDataModel(
    apartment: 'NA',
    first_name: 'Yousab888',
    last_name: 'Sefeen88',
    street: 'Marwan Estate',
    building: 'NA',
    phone_number: '0122715559',
    city: 'Esna',
    country: 'Cairo',
    email: 'yoousab@gmail.com',
    state: 'Single',
    floor: 'Null',
    shipping_method: 'Null',
    postal_code: 'Null',
  );

  final orderDetails = OrderDetails(
    billingData: billingData,
    totalAmount: 11000 * 100,
    shippingData: shippingData,
    orderItems: orderItems,
  );
}
