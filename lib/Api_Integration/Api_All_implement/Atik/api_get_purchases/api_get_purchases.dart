import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_purchase_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/cash_statement_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_purchases_mclass.dart';

import '../../../../const_page.dart';

class ApiGetPurchases {
  static GetApiGetPurchases(
      context,
      String? dateFrom,
      String? dateTo,
      String? userFullName) async {
    String Link = "${BaseUrl}api/v1/getPurchases";
    List<Purchasess> getPurchasesslist = [];
    Purchasess purchasess;
    double totalSalesSubtotal = 0.0;
    String totalSalesSt;
    double totalVat = 0.0;
    String totalVt;
    double totalDiscount = 0.0;
    String totalDiscnt;
    double totalTransCost = 0.0;
    String totalTC;
    double totalTotal = 0.0;
    String totalT;
    double totalPaid = 0.0;
    String totalPd;
    double totalDue = 0.0;
    String totalD;
    try {
      Response response = await Dio().post(Link,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("getPurchaseslist===::===getPurchaseslist:${response.data}");
      print("===========++++++=============");
      print("getPurchaseslist getPurchaseslist getPurchaseslist");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print("getPurchaseslist===========getPurchaseslist=======: ${data}");
      for (var i in data["purchases"]) {
        purchasess = Purchasess.fromJson(i);
        getPurchasesslist.add(purchasess);

        totalSalesSubtotal += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterSubTotalAmount}");
        totalSalesSt = totalSalesSubtotal.toStringAsFixed(2);
        GetStorage().write("totalSalesSubtotal", totalSalesSt);
        //vat
        totalVat += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterTax}");
        totalVt = totalVat.toStringAsFixed(2);
        GetStorage().write("totalVat", totalVt);
        //discount
        totalDiscount += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterDiscountAmount}");
        totalDiscnt = totalDiscount.toStringAsFixed(2);
        GetStorage().write("totalDiscount", totalDiscnt);
        //TransCost
        totalTransCost += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterFreight}");
        totalTC = totalTransCost.toStringAsFixed(2);
        GetStorage().write("totalTransCost", totalTC);
        //Total
        totalTotal += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterTotalAmount}");
        totalT = totalTotal.toStringAsFixed(2);
        GetStorage().write("totalTotal", totalT);
        //Paid
        totalPaid += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterPaidAmount}");
        totalPd = totalPaid.toStringAsFixed(2);
        GetStorage().write("totalPaid", totalPd);
        //Due
        totalDue += double.parse(
            "${Purchasess.fromJson(i).purchaseMasterDueAmount}");
        totalD = totalDue.toStringAsFixed(2);
        GetStorage().write("totalDue", totalD);

      }
      print("getPurchaseslist getPurchaseslist length is ${getPurchasesslist.length}");
    } catch (e) {
      print("Something is wrong getPurchaseslist=======:$e");
    }
    return getPurchasesslist;
  }
}
