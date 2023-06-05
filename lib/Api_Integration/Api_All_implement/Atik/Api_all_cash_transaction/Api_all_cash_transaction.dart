import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_cash_transaction_class.dart';

import 'package:poss/const_page.dart';

class ApiAllCashTransactions {
  static GetApiAllCashTransactions(context, String? transactionType,
      String? accountId, String? dateFrom, String? dateTo) async {
    String Link = "${BaseUrl}api/v1/getCashTransactions";
    List<AllCashTransactionsClass> allCashTransactionslist = [];
    AllCashTransactionsClass allCashTransactionsClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "transactionType": "$transactionType",
            "accountId": "$accountId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);

      for (var i in data) {
        allCashTransactionsClass = AllCashTransactionsClass.fromJson(i);
        allCashTransactionslist.add(allCashTransactionsClass);
      }
      print(
          "allCashTransactionslist===========================> ${allCashTransactionslist.length}  ");
      print("CashTransactions length is ${allCashTransactionslist.length}");
    } catch (e) {
      print("Something is wrong all CashTransactions list=======:$e");
    }
    return allCashTransactionslist;
  }
}
