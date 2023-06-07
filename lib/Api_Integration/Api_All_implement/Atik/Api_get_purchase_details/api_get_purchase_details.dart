import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_customer_payment_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_purchase_details.dart';
import 'package:poss/const_page.dart';
//
class ApiGetPurchaseDetails {
  static GetApiGetPurchaseDetails(
      context, String? categoryId, String? dateFrom, String? dateTo,String? productId, String? supplierId) async {
    String Link = "${BaseUrl}api/v1/getPurchaseDetails";
    List<GetPurchaseDetailsModelClass> getPurchaseDetailslist = [];
    GetPurchaseDetailsModelClass getPurchaseDetailsModelClass;
    double totalQuantity = 0.0;
    String totalQty;
    try {
      Response response = await Dio().post(Link,
          data: {
            "categoryId":"$categoryId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "productId":"$productId",
            "supplierId":"$supplierId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("GetPurchaseDetails===::===GetPurchaseDetails:${response.data}");
      print("===========++++++=============");
      print("GetPurchaseDetails GetPurchaseDetails GetPurchaseDetails");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print(
          "GetPurchaseDetails===========GetPurchaseDetails=======: ${data}");
      for (var i in data) {
        getPurchaseDetailsModelClass = GetPurchaseDetailsModelClass.fromJson(i);
        getPurchaseDetailslist.add(getPurchaseDetailsModelClass);
        totalQuantity += double.parse(
            "${GetPurchaseDetailsModelClass.fromJson(i).purchaseDetailsTotalQuantity}");
        totalQty = totalQuantity.toStringAsFixed(2);
        GetStorage().write("totalQuantity", totalQty);
      }
      print(
          "GetPurchaseDetails GetPurchaseDetails length is ${getPurchaseDetailslist.length}");
    } catch (e) {
      print(
          "Something is wrong GetPurchaseDetails=======:$e");
    }
    return getPurchaseDetailslist;
  }
}
