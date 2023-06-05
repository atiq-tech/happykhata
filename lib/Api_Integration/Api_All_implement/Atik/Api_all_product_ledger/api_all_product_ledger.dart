import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_product_ledger_class.dart';
import 'package:poss/const_page.dart';

class ApiAllProductLedger {
  static GetApiAllProductLedger(
      context, String? productId, String? dateFrom, String? dateTo) async {
    String Link = "${BaseUrl}api/v1/getProductLedger";
    List<Ledger> allProductLedgerlist = [];
    Ledger allProductLedgerClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "productId": "$productId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
   

      var data = jsonDecode(response.data)["ledger"];
      // print("ProductLedgerr===========ProductLedgerr: ${data}");
      for (var i in data) {
        allProductLedgerClass = Ledger.fromJson(i);
        allProductLedgerlist.add(allProductLedgerClass);
      }
      print("ProductLedgerr===========ProductLedgerr=======ProductLedgerr");
      print("${allProductLedgerlist.length}");
    } catch (e) {
      print("Something is wrong all Customers list=======:$e");
    }
    return allProductLedgerlist;
  }
}
