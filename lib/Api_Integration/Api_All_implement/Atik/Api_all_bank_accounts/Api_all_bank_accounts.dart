import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';

class ApiAllBankAccounts {
  static GetApiAllBankAccounts(context) async {
    
    List<AllBankAccountModelClass> allBankAccountlist = [];
    AllBankAccountModelClass allBankAccountModelClass;
    try {
      var Response = await http.post(
          Uri.parse("http://testapi.happykhata.com/api/v1/getBankAccounts"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});

      var data = jsonDecode(Response.body);

      for (var i in data) {
        allBankAccountModelClass = AllBankAccountModelClass.fromJson(i);
       allBankAccountlist.add(allBankAccountModelClass);

      }
      print(
          "allBankAccountlist===========================> ${allBankAccountlist.length}  ");
    } catch (e) {
      print("Something is wrong all BankAccounts list=======:$e");
    }
    return allBankAccountlist ;
  }
}
