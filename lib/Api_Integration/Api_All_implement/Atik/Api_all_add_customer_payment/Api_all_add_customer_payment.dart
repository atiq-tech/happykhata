import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/const_page.dart';

class ApiAllAddCustomerPayment {

  static bool isBtnClk = false;

  static getApiAllAddCustomerPayment(
    context,
    String? cpaymentPaymentby,
    String? cpaymentTransactiontype,
    String? cpaymentAmount,
    String? cpaymentCustomerid,
    String? cpaymentDate,
    int? cpaymentId,
    String? cpaymentNotes,
    String? cpaymentPreviousDue,
    String? accountId,
  ) async {
    String Link = "${BaseUrl}api/v1/addCustomerPayment";

    try {
      Response response = await Dio().post(Link,
          data: {
            "CPayment_Paymentby": "$cpaymentPaymentby",
            "CPayment_TransactionType": "$cpaymentTransactiontype",
            "CPayment_amount": "$cpaymentAmount",
            "CPayment_customerID": "$cpaymentCustomerid",
            "CPayment_date": "$cpaymentDate",
            "CPayment_id":cpaymentId,
            "CPayment_notes": "$cpaymentNotes",
            "CPayment_previous_due": "$cpaymentPreviousDue",
            "account_id": "$accountId"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      if(data['success'] == true){
        isBtnClk = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 1),
            content: Center(child: Text("${data["message"]}",style: const TextStyle(color: Colors.white),))));
      }else{
        isBtnClk = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 1),
            content: Center(child: Text("${data["message"]}",style: const TextStyle(color: Colors.red),))));
      }
      print("Add Customer Payment length is ${data}");
    } catch (e) {
      print("Something is wrong AAAAdd CCCCustomer PPPayment=======:$e");
      isBtnClk = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 1),
          content: Center(child: Text("${e.toString()}",style: const TextStyle(color: Colors.red),))));
    }
  }
}
