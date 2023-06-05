import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_customer_payment_class.dart';
import 'package:poss/const_page.dart';
//
class ApiAllGetCustomerPayments {
  static GetApiAllGetCustomerPayments(
      context, String? dateFrom, String? dateTo) async {
    String Link = "${BaseUrl}api/v1/getCustomerPayments";
    List<AllGetCustomerPaymentClass> allGetCustomerPaymentlist = [];
    AllGetCustomerPaymentClass allGetCustomerPaymentClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("GetCustomerPayments::GetCustomerPayments:${response.data}");
      print("===========++++++=============");
      print("GetCustomerPayments GetCustomerPayments");
      print("============++++++=========");

      var data = jsonDecode(response.data);
      print(
          "===========GetCustomerPayments GetCustomerPayments=======: ${data}");
      for (var i in data) {
        allGetCustomerPaymentClass = AllGetCustomerPaymentClass.fromJson(i);
        allGetCustomerPaymentlist.add(allGetCustomerPaymentClass);
      }

      print(
          "GetCustomerPayments GetCustomerPayments length is ${allGetCustomerPaymentlist.length}");
    } catch (e) {
      print(
          "Something is wrong GetCustomerPayments GetCustomerPayments=======:$e");
    }
    return allGetCustomerPaymentlist;
  }
}
