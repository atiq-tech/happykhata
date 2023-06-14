import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:poss/const_page.dart';

class ApiAllAddSupplierPayment {

  static bool isBtnClk = false;

  static getApiAllAddSupplierPayment(
      context,
      String? spaymentPaymentby,
      String? spaymentTransactiontype,
      String? spaymentAmount,
      String? spaymentCustomerid,
      String? spaymentDate,
      int? spaymentId,
      String? spaymentNotes,
      String? accountId,
      ) async {
    String Link = "${BaseUrl}api/v1/addSupplierPayment";

    try {
      Response response = await Dio().post(Link,
          data: {
            "SPayment_Paymentby": "$spaymentPaymentby",
            "SPayment_TransactionType": "$spaymentTransactiontype",
            "SPayment_amount": "$spaymentAmount",
            "SPayment_customerID": "$spaymentCustomerid",
            "SPayment_date": "$spaymentDate",
            "SPayment_id": spaymentId,
            "SPayment_notes": "$spaymentNotes",
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

    } catch (e) {
      isBtnClk = false;
      print("Something is wrong AAAAdd Supplier PPPayment=======:$e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 1),
          content: Center(child: Text(e.toString(),style: const TextStyle(color: Colors.red),))));
    }
  }
}
