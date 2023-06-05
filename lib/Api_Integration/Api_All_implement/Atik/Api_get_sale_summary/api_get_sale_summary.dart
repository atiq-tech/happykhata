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
      print("===========++++++=============");
      print("getSaleSummarylist getSaleSummarylist getSaleSummarylist");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print("getSaleSummarylist===========getSaleSummarylist=======: ${data}");
      for (var i in data) {
        getSaleSummaryMClass = GetSaleSummaryMClass.fromJson(i);
        getSaleSummarylist.add(getSaleSummaryMClass);
      }
      print(
          "getSaleSummarylist getSaleSummarylist length is ${getSaleSummarylist.length}");
    } catch (e) {
      print("Something is wrong getSaleSummarylist=======:$e");
    }
    return getSaleSummarylist;
  }
}
