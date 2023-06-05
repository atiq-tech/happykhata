import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/supplier_payment_model.dart';

class GetCashPaidToSupplierProvider extends ChangeNotifier {
  List<SupplierPaymentModel> provideCashPaidToSupplierList = [];
  getCashPaidToSupplierData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashPaidToSupplierList = await AllApiImplement.FetchSupplierPaidPayment(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
