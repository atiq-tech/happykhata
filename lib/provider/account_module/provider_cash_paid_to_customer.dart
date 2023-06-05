import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/sales_module/customer_payment_history_model.dart';

class GetCashPaidToCustomerProvider extends ChangeNotifier {
  List<CustomerPaymentHistoryModel> provideCashPaidToCustomerList = [];
  getCashPaidToCustomerData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashPaidToCustomerList = await AllApiImplement.FetchCustomerPaidPayment(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
