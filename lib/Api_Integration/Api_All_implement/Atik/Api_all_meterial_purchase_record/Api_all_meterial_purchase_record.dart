import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_meterial_purchase_record_class.dart';
import 'package:poss/const_page.dart';

class ApiAllMeterialPurchase {
  static GetApiAllMeterialPurchase(
      context, String? dateFrom, String? dateTo, String? supplier_id) async {
    String Link = "${BaseUrl}api/v1/getMaterialPurchase";
    List<Purchases> allPurchaseslist = [];
    Purchases purchases;
    double totalTotal = 0.0;
    String totalT;
    double totalPaid= 0.0;
    String totalP;
    double totalDue = 0.0;
    String totalD;
    try {
      Response response = await Dio().post(Link,
          data: {

            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "supplier_id": "$supplier_id"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var data = jsonDecode(response.data)["purchases"];
      print("meterial purchase ===========meterial purchase: ${data}");
      for (var i in data) {
        purchases = Purchases.fromJson(i);
        allPurchaseslist.add(purchases);
        //total
        totalTotal += double.parse(
            "${Purchases.fromJson(i).total}");
        totalT = totalTotal.toStringAsFixed(2);
        GetStorage().write("totalTotal", totalT);
        //Paid
        totalPaid += double.parse(
            "${Purchases.fromJson(i).paid}");
        totalP = totalPaid.toStringAsFixed(2);
        GetStorage().write("totalPaid", totalP);
        //Due
        totalDue += double.parse(
            "${Purchases.fromJson(i).due}");
        totalD = totalDue.toStringAsFixed(2);
        GetStorage().write("totalDue", totalD);
      }
      print("meterial purchase ==========meterial purchase ");
      print("${allPurchaseslist.length}");
    } catch (e) {
      print("Something is wrong all meterial purchase =======:$e");
    }
    return allPurchaseslist;
  }
}
