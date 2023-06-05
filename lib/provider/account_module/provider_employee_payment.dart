import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/employee_payment_model.dart';

class GeEmployeePaymentProvider extends ChangeNotifier {
  List<EmployerPaymentModel> provideEmployeePaymentList = [];
  getEmployeePaymentData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideEmployeePaymentList = await AllApiImplement.FetchEmployeedPayment(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
