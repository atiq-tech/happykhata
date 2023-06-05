import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_accounts_model_class.dart';

import 'package:http/http.dart' as http;

class ApiAllAccounts {
  static GetApiAllAccounts(context) async {
    
    List<AllAccountsModelClass> allAccountslist = [];
    AllAccountsModelClass allAccountsModelClass;
    try {
      var Response = await http.post(
          Uri.parse("http://testapi.happykhata.com/api/v1/getAccounts"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});
      // print("Accounts Accounts Accounts daaaaaaaaaaaaaaaaaataaaaaaaaaaaaa:::${Response.body}");
      print("Accounts Accounts Accounts");
      print("++++++++++++++++++++++++++");
      print("Accounts Accounts Accounts");

      var data = jsonDecode(Response.body);
      // print("+++++====+++++Accounts Accounts Accounts all++++===data;;;;;: ${data}");
      for (var i in data) {
        allAccountsModelClass = AllAccountsModelClass.fromJson(i);
       allAccountslist.add(allAccountsModelClass);
       
      }
    } catch (e) {
      print("Something is wrong all Accounts list=======:$e");
    }
    return allAccountslist;
  }
}
