import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Get_purchase_record_all.dart';
import 'package:poss/const_page.dart';

class ApiGetPurchaseRecordAll {
  static GetPurchaseRecordAll(context,String? dateFrom, String? dateTo,String? userFullName) async {
    String link = "${BaseUrl}api/v1/getPurchaseRecord";
    List<GetPurchaseRecord_ALL> getPurchaseRecordList = [];
     GetPurchaseRecord_ALL getPurchaseRecord_ALL;
    try {
      Response response = await Dio().post(link,
          data: {
            "dateFrom": "$dateFrom", 
            "dateTo": "$dateTo",
            "userFullName":"$userFullName"
            },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print(
          "GetPurchaseRecordList= ++++++++++++++++++++++++++++++++++++> ${response.data}");
             print("===========++++++=============");
      print("GetPurchaseRecordList =========== GetPurchaseRecordList");
      print("============++++++=========");
      var item = jsonDecode(response.data);
      for (var i in item) {
        getPurchaseRecord_ALL = GetPurchaseRecord_ALL.fromJson(i);
        getPurchaseRecordList.add(getPurchaseRecord_ALL);

      }
      // print(getPurchaseRecordList[0].purchaseDetails![0].productName);
      // for (int i = 0; i < getPurchaseRecordList.length; i++) {
      //   print(
      //       "GetPurchaseRecord ++++++++++++++++++++++++++++++++++++> ${getPurchaseRecordList.length}");
      //   print(getPurchaseRecordList[i].purchaseDetails![0].productName);
      // }
      print(
          "GetPurchaseRecordList= ++++++++++++++++++++++++++++++++++++> ${getPurchaseRecordList.length}  ");
    } catch (e) {
         print(
          "Something is wrong GetPurchaseRecord=======:$e");
    }
    return getPurchaseRecordList;
  }
}
