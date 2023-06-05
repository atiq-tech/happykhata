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
      }

      print("getSaleslist getSaleslist length is ${getSaleslist.length}");
    } catch (e) {
      print("Something is wrong getSaleslist=======:$e");
    }
    return getSaleslist;
  }

  //
  //  static FetchAllSalseData(
  //   context,
  //   String? dateFrom,
  //   String? dateTo,
  // ) async {
  //   String link = "${BaseUrl}api/v1/getSales";
  //   List<Sales> salesList = [];
  //   double totalSales = 0.0;
  //   String totalSaless;

  //   Sales item;
  //   try {
  //     Response response = await Dio().post(link,
  //         data: {
  //           "dateFrom": "$dateFrom",
  //           "dateTo": "$dateTo",
  //         },
  //         options: Options(headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${GetStorage().read("token")}",
  //         }));
  //     // print(response.data);
  //     var data = jsonDecode(response.data);
  //     //   print(item);
  //     for (var i in data['sales']) {
  //       item = Sales.fromJson(i);
  //       salesList.add(item);
  //       totalSales += double.parse("${item.saleMasterPaidAmount}");
  //       totalSaless = totalSales.toStringAsFixed(2);
  //       GetStorage().write("totalSales", totalSaless);
  //       // print(sales_recordlist[0].saleDetails![0].productName);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return salesList;
  // }
}
