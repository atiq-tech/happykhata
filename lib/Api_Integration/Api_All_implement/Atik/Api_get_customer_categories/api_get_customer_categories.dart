

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_customer_cateMClass.dart';
import 'package:poss/const_page.dart';

class ApiGetCustomerCategories {
  static GetApiGetCustomerCategories(
      context,String? customerId) async {
    String Link = "${BaseUrl}api/v1/getCustomerCategories";
    List<GetCustomerCateMClass> getCustomerCategorieslist = [];
    GetCustomerCateMClass getCustomerCateMClass;
    try {
      Response response = await Dio().post(Link,
          data: {
             "customerId":"$customerId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("GetCustomerCategoris===::========:${response.data}");
      print("===========++++++=============");
      print("GetCustomerCategoris GetCustomerCategoris");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print(
          "GetCustomerCategoris=================: ${data}");
      for (var i in data) {
        getCustomerCateMClass = GetCustomerCateMClass.fromJson(i);
        getCustomerCategorieslist.add(getCustomerCateMClass);
      }

      print(
          "getCustomerCategorislist getCustomerCategorislist length is ${getCustomerCategorieslist.length}");
    } catch (e) {
      print(
          "Something is wrong GetCustomerProducts=======:$e");
    }
    return getCustomerCategorieslist;
  }
}
