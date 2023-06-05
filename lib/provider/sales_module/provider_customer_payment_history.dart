import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import 'package:flutter/material.dart';
import '../../Api_Integration/Api_Modelclass/sales_module/customer_payment_history_model.dart';

class CustomerPaymentHistoryProvider extends ChangeNotifier {
  List<CustomerPaymentHistoryModel> provideCustomerPaymentHistoryList = [];
  getCustomerPaymentData(
    context,
    String? customerId,
    String? dateFrom,
    String? dateTo,
    String? paymentType,
  ) async {
    provideCustomerPaymentHistoryList = await AllApiImplement.FetchCustomerPaymentHistory(
      context,
      customerId,
      dateFrom,
      dateTo,
      paymentType,
    );
    notifyListeners();
  }
}
