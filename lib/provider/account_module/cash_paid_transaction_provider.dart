import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/cash_transaction_model.dart';

class GetCashPaidTransactionProvider extends ChangeNotifier {
  List<CashTransactionModel> provideCashTransactionPaidList = [];
  getCashPaidTransactionData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideCashTransactionPaidList = await AllApiImplement.FetchCashTransactionPaid(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
