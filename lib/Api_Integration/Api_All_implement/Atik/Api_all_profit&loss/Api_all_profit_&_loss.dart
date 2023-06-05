import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_Profit_Loss_class.dart';
import 'package:poss/const_page.dart';

class ApiAllProfitLoss {
  static GetApiAllProfitLoss(context,String ?customer ,String ?dateFrom,String ?dateTo) async {
    String Link = "${BaseUrl}api/v1/getProfitLoss";
    List<AllProfitLossClass> allProfitLosslist = [];
    AllProfitLossClass allProfitLossClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "customer": "$customer",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      // print("Profit=====================Loss:::${response.data}");
      // print("===========++++++=============");
      // print("++++++++++++++++++++++++++");
      // print("============++++++=========");

      var data = jsonDecode(response.data);
      // print("ProfitLoss===========ProfitLoss=======ProfitLoss: ${data}");
      for (var i in data) {
        allProfitLossClass = AllProfitLossClass.fromJson(i);
        allProfitLosslist.add(allProfitLossClass);
      }
      print("ProfitLoss===========ProfitLoss=======ProfitLoss");
      print("${allProfitLosslist.length}");
    } catch (e) {
      print("Something is wrong all Customers list=======:$e");
    }
    return allProfitLosslist;
  }
}
