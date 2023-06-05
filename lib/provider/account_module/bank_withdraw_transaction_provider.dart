import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/bank_transaction_model.dart';

class GetBankWithdrawTransactionProvider extends ChangeNotifier {
  List<BankTransactionModel> provideBankWithdrawTransactionList = [];
  getBankWithdrawTransactionData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideBankWithdrawTransactionList = await AllApiImplement.FetchBankWithdrawTransaction(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
