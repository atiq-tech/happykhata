import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/cash_transaction_model.dart';

class GetCashReceivedTransactionProvider extends ChangeNotifier {
  List<CashTransactionModel> provideCashTransactionReceivedList = [];
  getCashReceivedTransactionData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashTransactionReceivedList = await AllApiImplement.FetchCashTransactionReceived(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
