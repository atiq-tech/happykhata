import 'package:poss/Api_Integration/Api_Modelclass/sales_module/customer_payment_report.dart';

import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import 'package:flutter/material.dart';

class CustomerPaymentReportProvider extends ChangeNotifier {
  List<Payments> provideCustomerPaymentReportList = [];
  getCustomerPaymentData(
    context,
    String? customerId,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCustomerPaymentReportList = await AllApiImplement.FetchCustomerPaymentReport(
      context,
      customerId,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
