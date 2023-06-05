import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_customer_product_Mclass.dart';
import 'package:poss/const_page.dart';

class ApiGetCustomerProducts {
  static GetApiGetCustomerProducts(
      context,String? customerId) async {
    String Link = "${BaseUrl}api/v1/getCustomerProducts";
    List<GetCustomerProductsMclass> getCustomerProductslist = [];
    GetCustomerProductsMclass getCustomerProductsMclass;
    try {
      Response response = await Dio().post(Link,
          data: {
             "customerId":"$customerId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("GetCustomerProducts===::========:${response.data}");
      print("===========++++++=============");
      print("GetCustomerProducts GetCustomerProducts");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print(
          "GetCustomerProducts=================: ${data}");
      for (var i in data) {
        getCustomerProductsMclass = GetCustomerProductsMclass.fromJson(i);
        getCustomerProductslist.add(getCustomerProductsMclass);
      }

      print(
          "GetCustomerProducts GetCustomerProducts length is ${getCustomerProductslist.length}");
    } catch (e) {
      print(
          "Something is wrong GetCustomerProducts=======:$e");
    }
    return getCustomerProductslist;
  }
}
