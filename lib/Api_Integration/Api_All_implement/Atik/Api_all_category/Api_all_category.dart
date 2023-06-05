import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_category_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_products_class.dart';
import 'package:http/http.dart'as http;
import 'package:poss/const_page.dart';

class ApiAllCategory{
  static GetApiAllCategory(context) async {
    //String Link = "${BaseUrl}api/v1/getCustomers";
    List<AllCategoryClass> allCategorylist = [];
    AllCategoryClass allCategoryClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getProducts"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});
      // print("Products pppppppppppppppddddddddddddd:::${Response.body}");


      var data = jsonDecode(Response.body);
      // print("+++++====+++++product all++++===data;;;;;: ${data}");
      for (var i in data) {
        allCategoryClass = AllCategoryClass.fromJson(i);
        allCategorylist.add(allCategoryClass);
        // print(allCustomerslist);
      }
      print("+++++====+++++Category all++++===data;;;;;: ${allCategorylist.length}");
      print("ccccccccccccccc");
      print("++++++++++++++++++++++++++");
       print(" Category Category Category");
    } catch (e) {
      print("Something is wrong all Category list=======:$e");
    }
    return allCategorylist;
  }
}