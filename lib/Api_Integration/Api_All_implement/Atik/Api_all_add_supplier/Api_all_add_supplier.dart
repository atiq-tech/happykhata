import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'package:poss/const_page.dart';

class ApiAllAddSupplier {
  static GetApiAllAddSupplier(
      context,
      String? AddBy,
      String? AddTime,
      String? Country_SlNo,
      String? District_SlNo,
      String? Status,
      String? Supplier_Address,
      String? Supplier_Code,
      String? Supplier_Email,
      String? Supplier_Mobile,
      String? Supplier_Name,
      String? Supplier_OfficePhone,
      String? Supplier_Phone,
      String? Supplier_SlNo,
      String? Supplier_Type,
      String? Supplier_Web,
      String? Supplier_brinchid,
      String? UpdateBy,
      String? UpdateTime,
      String? contact_person,
      String? display_name,
      String? image_name,
      String? previous_due,
      ) async {
    String Link = "${BaseUrl}api/v1/addSupplier";

    try {
      Response response = await Dio().post(Link,
          data: {
            "AddBy":"$AddBy",
            "AddTime":"$AddTime",
            "Country_SlNo":"$Country_SlNo",
            "District_SlNo":"$District_SlNo",
            "Status":"$Status",
            "Supplier_Address":"$Supplier_Address",
            "Supplier_Code":"$Supplier_Code",
            "Supplier_Email":"$Supplier_Email",
            "Supplier_Mobile":"$Supplier_Mobile",
            "Supplier_Name":"$Supplier_Name",
            "Supplier_OfficePhone":"$Supplier_OfficePhone",
            "Supplier_Phone":"$Supplier_Phone",
            "Supplier_SlNo":"$Supplier_SlNo",
            "Supplier_Type":"$Supplier_Type",
            "Supplier_Web":"$Supplier_Web",
            "Supplier_brinchid":"$Supplier_brinchid",
            "UpdateBy":null,
            "UpdateTime":null,
            "contact_person":"$contact_person",
            "display_name":"$display_name",
            "image_name":null,
            "previous_due":"$previous_due"

          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print(
          "AddSupplier AddSupplier::AddSupplier:${response.data}");
      print("===========++++++=============");
      print("Add Supplier Add Supplier Add Supplier");
      print("============+++++++++++++++=========");

      var data = jsonDecode(response.data);

      print("Add Supplier  length is ${data}");
    } catch (e) {
      print("Something is wrong AAAAdd Supplier=======:$e");
    }
  }
}
