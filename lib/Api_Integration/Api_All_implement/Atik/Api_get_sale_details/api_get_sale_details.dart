import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_sale_details_MClass.dart';
import 'package:poss/const_page.dart';

class ApiGetSaleDetails {
  static GetApiGetSaleDetails(
      context, String? categoryId, String? customerId, String? dateFrom, String? dateTo,String? productId) async {
    String Link = "${BaseUrl}api/v1/getSaleDetails";
    List<GetSaleDetailsMClass> getSaleDetailslist = [];
    GetSaleDetailsMClass getSaleDetailsMClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "categoryId":"$categoryId",
            "customerId":"$customerId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "productId":"$productId",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("GetSaleDetails===::===GetSaleDetails:${response.data}");
      print("GetSaleDetails GetSaleDetails GetSaleDetails");
      print("GGG============SS+++sss+++SS=========DDD");
      var data = jsonDecode(response.data);
      print(
          "GetSaleDetails===========GetSaleDetails=======: ${data}");
      for (var i in data) {
        getSaleDetailsMClass = GetSaleDetailsMClass.fromJson(i);
        getSaleDetailslist.add(getSaleDetailsMClass);
      }

      print(
          "GetSaleDetails GetSaleDetails length is ${getSaleDetailslist.length}");
    } catch (e) {
      print(
          "Something is wrong GetSaleDetails=======:$e");
    }
    return getSaleDetailslist;
  }
}
