import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import 'package:flutter/material.dart';
import '../../Api_Integration/Api_Modelclass/purchase_module/supplier_payment_report_model.dart';

class SupplierPaymentReportProvider extends ChangeNotifier {
  List<Payments> provideSupplierPaymentReportList = [];
  getSupplierPaymentData(
    context,
    String? supplierId,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideSupplierPaymentReportList = await AllApiImplement.FetchSupplierPaymentReport(
      context,
      supplierId,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
