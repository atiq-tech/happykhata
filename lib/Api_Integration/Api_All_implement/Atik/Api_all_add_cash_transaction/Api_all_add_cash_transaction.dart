
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:poss/const_page.dart';

class ApiAllAddCashTransactions {

  static bool isLoading = false;

  static GetApiAllAddCashTransactions(
    BuildContext context,
    String? accSlid,
    int? inAmount,
    int? outAmount,
    String? trDescription,
    String? trId,
    int? trSlno,
    String? trType,
    String? trAccountType,
    String? trDate,
  ) async {
    String Link = "${BaseUrl}api/v1/addCashTransaction";

    try {
      Response response = await Dio().post(Link,
          data: {
            "Acc_SlID": "$accSlid",
            "In_Amount": inAmount,
            "Out_Amount": outAmount,
            "Tr_Description": "$trDescription",
            "Tr_Id": "$trId",
            "Tr_SlNo": trSlno,
            "Tr_Type": "$trType",
            "Tr_account_Type": "$trAccountType",
            "Tr_date": "$trDate"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var data = jsonDecode(response.data);
      if(data['success']==true){
        print("CashTransactions CashTransactions:::${data}");
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Center(child: Text("${data["message"]}",style: const TextStyle(color: Colors.white, fontSize: 16),))));
      }
      else{
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Center(child: Text("${data["message"]}",style: const TextStyle(color: Colors.red, fontSize: 16),))));
      }

    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Center(child: Text("${e}",style: const TextStyle(color: Colors.red, fontSize: 16),))));
      print("Something is wrong all Add CashTransactions list=======:$e");
    }
  }
}
