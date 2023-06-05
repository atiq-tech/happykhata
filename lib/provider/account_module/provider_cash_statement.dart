import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import 'package:flutter/material.dart';
import '../../Api_Integration/Api_Modelclass/account_module/cash_statement_model.dart';

class GetSaleProvider extends ChangeNotifier {
  List<Sales> provideSaleList = [];
  getSaleData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideSaleList = await AllApiImplement.FetchAllSalseData(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
