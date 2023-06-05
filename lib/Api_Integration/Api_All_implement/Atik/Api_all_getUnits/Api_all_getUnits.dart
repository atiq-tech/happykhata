import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_category_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_getUnits_Class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_products_class.dart';
import 'package:http/http.dart'as http;
import 'package:poss/const_page.dart';

class ApiAllGetUnits{
  static GetApiAllUnits(context) async {
    List<AllGetUnitsClass> allUnitslist = [];
    AllGetUnitsClass allGetUnitsClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getUnits"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});

      var data = jsonDecode(Response.body);
      // print("+++++====+++++product all++++===data;;;;;: ${data}");
      for (var i in data) {
        allGetUnitsClass= AllGetUnitsClass.fromJson(i);
        allUnitslist.add(allGetUnitsClass);

      }
      print("+++++====+++++Units all++++===data;;;;;: ${allUnitslist.length}");

    } catch (e) {
      print("Something is wrong all Units list=======:$e");
    }
    return allUnitslist;
  }
}