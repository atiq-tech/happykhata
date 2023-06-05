import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/const_page.dart';

class ApiAllAddCustomerPayment {
  static GetApiAllAddCustomerPayment(
    context,
    String? CPayment_Paymentby,
    String? CPayment_TransactionType,
    String? CPayment_amount,
    String? CPayment_customerID,
    String? CPayment_date,
    int? CPayment_id,
    String? CPayment_notes,
    String? CPayment_previous_due,
    String? account_id,
  ) async {
    String Link = "${BaseUrl}api/v1/addCustomerPayment";

    try {
      Response response = await Dio().post(Link,
          data: {
            "CPayment_Paymentby": "$CPayment_Paymentby",
            "CPayment_TransactionType": "$CPayment_TransactionType",
            "CPayment_amount": "$CPayment_amount",
            "CPayment_customerID": "$CPayment_customerID",
            "CPayment_date": "$CPayment_date",
            "CPayment_id":CPayment_id,
            "CPayment_notes": "$CPayment_notes",
            "CPayment_previous_due": "$CPayment_previous_due",
            "account_id": "$account_id"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print(
          "AddCustomerPayment AddCustomerPayment::AddCustomerPayment:${response.data}");
      print("===========++++++=============");
      print("AddCustomerPayment AddCustomerPayment AddCustomerPayment");
      print("============+++++++++++++++=========");

      var data = jsonDecode(response.data);

      print("Add Customer Payment length is ${data}");
    } catch (e) {
      print("Something is wrong AAAAdd CCCCustomer PPPayment=======:$e");
    }
  }
}
