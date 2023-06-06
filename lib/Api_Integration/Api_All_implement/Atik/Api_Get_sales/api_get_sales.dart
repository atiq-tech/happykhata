import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/cash_statement_model.dart';

import '../../../../const_page.dart';

class ApiGetSales {
  static GetApiGetSales(
      context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String Link = "${BaseUrl}api/v1/getSales";
    List<Sales> getSaleslist = [];
    Sales sales;
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
            "customerId": "$customerId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("getSaleslist===::===getSaleslist:${response.data}");
      print("===========++++++=============");
      print("getSaleslist getSaleslist getSaleslist");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print("getSaleslist===========getSaleslist=======: ${data}");
      for (var i in data["sales"]) {
        sales = Sales.fromJson(i);
        getSaleslist.add(sales);

        totalSalesSubtotal += double.parse(
            "${Sales.fromJson(i).saleMasterSubTotalAmount}");
        totalSalesSt = totalSalesSubtotal.toStringAsFixed(2);
        GetStorage().write("totalSalesSubtotal", totalSalesSt);
        //vat
        totalVat += double.parse(
            "${Sales.fromJson(i).saleMasterTaxAmount}");
        totalVt = totalVat.toStringAsFixed(2);
        GetStorage().write("totalVat", totalVt);
        //discount
        totalDiscount += double.parse(
            "${Sales.fromJson(i).saleMasterTotalDiscountAmount}");
        totalDiscnt = totalDiscount.toStringAsFixed(2);
        GetStorage().write("totalDiscount", totalDiscnt);
        //TransCost
        totalTransCost += double.parse(
            "${Sales.fromJson(i).saleMasterFreight}");
        totalTC = totalTransCost.toStringAsFixed(2);
        GetStorage().write("totalTransCost", totalTC);
        //Total
        totalTotal += double.parse(
            "${Sales.fromJson(i).saleMasterTotalSaleAmount}");
        totalT = totalTotal.toStringAsFixed(2);
        GetStorage().write("totalTotal", totalT);
        //Paid
        totalPaid += double.parse(
            "${Sales.fromJson(i).saleMasterPaidAmount}");
        totalPd = totalPaid.toStringAsFixed(2);
        GetStorage().write("totalPaid", totalPd);
        //Due
        totalDue += double.parse(
            "${Sales.fromJson(i).saleMasterDueAmount}");
        totalD = totalDue.toStringAsFixed(2);
        GetStorage().write("totalDue", totalD);

      }
      print("getSaleslist getSaleslist length is ${getSaleslist.length}");
    } catch (e) {
      print("Something is wrong getSaleslist=======:$e");
    }
    return getSaleslist;
  }
}
