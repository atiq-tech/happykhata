import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/account_module/bank_transaction_model.dart';

class GetBankDepositTransactionProvider extends ChangeNotifier {
  List<BankTransactionModel> provideBankDepositTransactionList = [];
  getBankDepositTransactionData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    provideBankDepositTransactionList = await AllApiImplement.FetchBankDepositTransaction(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
