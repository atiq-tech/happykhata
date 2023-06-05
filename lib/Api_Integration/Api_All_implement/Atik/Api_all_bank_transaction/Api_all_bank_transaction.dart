import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_transaction_model_class.dart';
import 'package:poss/const_page.dart';

class ApiAllBankTransactions {
  //
  static GetApiAllBankTransactions(context,String ?accountId,String ?dateFrom,String ?dateTo,String ?transactionType) async {
    String Link = "${BaseUrl}api/v1/getAllBankTransactions";
    List<AllBankTransactionModelClass> allBankTransactionslist = [];
    AllBankTransactionModelClass allBankTransactionModelClass;
    try {
      Response response = await Dio().post(Link,
          data: {
           
             "accountId": "$accountId",             
              "dateFrom": "$dateFrom",
              "dateTo": "$dateTo",
              "transactionType":"$transactionType",
              },

          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));


      var data = jsonDecode(response.data);

      for (var i in data) {
        allBankTransactionModelClass = AllBankTransactionModelClass.fromJson(i);
        allBankTransactionslist.add(allBankTransactionModelClass);
      }
      print(
          "allBankTransactionslist===========================> ${allBankTransactionslist.length}  ");
      print("Bank Transactions length is ${allBankTransactionslist.length}");
    } catch (e) {
      print("Something is wrong all Bank Transactions list=======:$e");
    }
    return allBankTransactionslist;
  }
}
