import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/supplier_payment_model.dart';

class GetCashReceivedFromSupplierProvider extends ChangeNotifier {
  List<SupplierPaymentModel> provideCashReceivedFromSupplierList = [];
  getCashReceivedFromSupplierData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashReceivedFromSupplierList = await AllApiImplement.FetchSupplierReceivedPayment(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
