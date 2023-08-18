import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayServices {
  static final _instance = Razorpay();
  static Future<void> checkoutOrder(
    OrderModel orderModel, {
      //
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    //check flutter docs for razorpay reference for more detail
    var options = {
      'key': 'rzp_test_MtOWm78nWeSseD',
      'name': "Thorat Brother's E-Commerce App",
      'description': '${orderModel.sId}',
      'prefill': {
        'contact': '${orderModel.user?.phoneNumber}',
        'email': '${orderModel.user?.email}'
      }
    };
    _instance.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      onSuccess(response);
      _instance.clear();
    });

    _instance.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      onFailure(response);
      _instance.clear();
    });

    _instance.open(options);
  }
}
