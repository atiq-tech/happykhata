import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_sale_summaryMClass.dart';
import 'package:poss/const_page.dart';

class ApiGetSaleSummary {
  static GetApiGetSaleSummary(
    context,
    String? dateFrom,
    String? dateTo,
    String? productId,
  ) async {
    String Link = "${BaseUrl}api/v1/getSaleSummary";
    List<GetSaleSummaryMClass> getSaleSummarylist = [];
    GetSaleSummaryMClass getSaleSummaryMClass;
    double totalQuantity=0.0;
    String totalQty;
    double totalTotal=0.0;
    String totalT;
    try {
      Response response = await Dio().post(Link,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "productId": "$productId",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("getSaleSummarylist===::===getSaleSummarylist:${response.data}");
      var data = jsonDecode(response.data);
      print("getSaleSummarylist===========getSaleSummarylist=======: ${data}");
      for (var i in data) {
        getSaleSummaryMClass = GetSaleSummaryMClass.fromJson(i);
        getSaleSummarylist.add(getSaleSummaryMClass);
        //Quantity
        totalQuantity += double.parse(
            "${GetSaleSummaryMClass.fromJson(i).totalSaleQty}");
        totalQty = totalQuantity.toStringAsFixed(2);
        GetStorage().write("totalQuantity", totalQty);
        //Total
        totalTotal += double.parse(
            "${GetSaleSummaryMClass.fromJson(i).totalSaleAmount}");
        totalT = totalTotal.toStringAsFixed(2);
        GetStorage().write("totalTotal", totalT);
      }
      print(
          "getSaleSummarylist getSaleSummarylist length is ${getSaleSummarylist.length}");
    } catch (e) {
      print("Something is wrong getSaleSummarylist=======:$e");
    }
    return getSaleSummarylist;
  }
}
