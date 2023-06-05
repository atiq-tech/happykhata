import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_meterial_purchase_record_class.dart';
import 'package:poss/const_page.dart';

class ApiAllMeterialPurchaseRecord {
  static GetApiAllMeterialPurchaseRecord(
      context, String? supplier_id, String? dateFrom, String? dateTo) async {
    String Link = "${BaseUrl}api/v1/getMaterialPurchase";
    List<Purchases> allPurchaseslist = [];
    Purchases purchases;
    try {
      Response response = await Dio().post(Link,
          data: {
            "supplier_id": "$supplier_id",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
 
     // print("meterial purchase record=======meterial purchase record");

      var data = jsonDecode(response.data)["purchases"];
      // print("meterial purchase record===========meterial purchase record: ${data}");
      for (var i in data) {
        purchases = Purchases.fromJson(i);
        allPurchaseslist.add(purchases);
      }
      print("meterial purchase record===========meterial purchase record");
      print("${allPurchaseslist.length}");
    } catch (e) {
      print("Something is wrong all meterial purchase record=======:$e");
    }
    return allPurchaseslist;
  }
}
