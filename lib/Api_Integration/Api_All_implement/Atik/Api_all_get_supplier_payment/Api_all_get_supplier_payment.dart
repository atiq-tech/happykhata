import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_supplier_payment_class.dart';
import 'package:poss/const_page.dart';

class ApiAllGetSupplierPayments {
  static GetApiAllGetSupplierPayments(
      context, String? dateFrom, String? dateTo) async {
    String Link = "${BaseUrl}api/v1/getSupplierPayments";
    List<AllGetSupplierPaymentClass> allGetSupplierPaymentlist = [];
    AllGetSupplierPaymentClass allGetSupplierPaymentClass;
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
      print("GetSupplierPayments::GetSupplierPayments:${response.data}");
      print("===========++++++=============");
      print("GetSupplierPayments GetSupplierPayments");


      var data = jsonDecode(response.data);
      print(
          "===========GetSupplierPayments GetSupplierPayments=======: ${data}");
      for (var i in data) {
        allGetSupplierPaymentClass = AllGetSupplierPaymentClass.fromJson(i);
        allGetSupplierPaymentlist.add(allGetSupplierPaymentClass);
      }

      print(
          "GetSupplierPayments GetSupplierPayments length is ${allGetSupplierPaymentlist.length}");
    } catch (e) {
      print(
          "Something is wrong GetSupplierPayments =======:$e");
    }
    return allGetSupplierPaymentlist;
  }
}
