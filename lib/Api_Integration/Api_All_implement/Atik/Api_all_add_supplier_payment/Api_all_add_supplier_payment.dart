import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'package:poss/const_page.dart';

class ApiAllAddSupplierPayment {
  static GetApiAllAddSupplierPayment(
      context,
      String? SPayment_Paymentby,
      String? SPayment_TransactionType,
      String? SPayment_amount,
      String? SPayment_customerID,
      String? SPayment_date,
      int? SPayment_id,
      String? SPayment_notes,
      String? account_id,
      ) async {
    String Link = "${BaseUrl}api/v1/addSupplierPayment";

    try {
      Response response = await Dio().post(Link,
          data: {
            "SPayment_Paymentby": "$SPayment_Paymentby",
            "SPayment_TransactionType": "$SPayment_TransactionType",
            "SPayment_amount": "$SPayment_amount",
            "SPayment_customerID": "$SPayment_customerID",
            "SPayment_date": "$SPayment_date",
            "SPayment_id": SPayment_id,
            "SPayment_notes": "$SPayment_notes",
            "account_id": "$account_id"
            // "CPayment_Paymentby": "$CPayment_Paymentby",
            // "CPayment_TransactionType": "$CPayment_TransactionType",
            // "CPayment_amount": "$CPayment_amount",
            // "CPayment_customerID": "$CPayment_customerID",
            // "CPayment_date": "$CPayment_date",
            // "CPayment_id":CPayment_id,
            // "CPayment_notes": "$CPayment_notes",
            // "CPayment_previous_due": "$CPayment_previous_due",
            // "account_id": "$account_id"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print(
          "AddSupplierPayment AddSupplierPayment::AddSupplierPayment:${response.data}");
      print("===========++++++=============");
      print("Add Supplier Payment AddSupplierPayment AddSupplierPayment");
      print("============+++++++++++++++=========");

      var data = jsonDecode(response.data);

      print("Add Supplier Payment length is ${data}");
    } catch (e) {
      print("Something is wrong AAAAdd Supplier PPPayment=======:$e");
    }
  }
}
