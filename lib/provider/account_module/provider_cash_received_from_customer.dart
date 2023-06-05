import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/sales_module/customer_payment_history_model.dart';

class GetCashReceivedFromCustomerProvider extends ChangeNotifier {
  List<CustomerPaymentHistoryModel> provideCashReceivedFromCustomerList = [];
  getCashReceivedFromCustomerData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashReceivedFromCustomerList = await AllApiImplement.FetchCustomerReceivedPayment(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
