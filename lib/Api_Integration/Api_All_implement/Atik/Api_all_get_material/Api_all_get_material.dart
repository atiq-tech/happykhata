import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_material_class.dart';
import 'package:poss/const_page.dart';
import 'package:http/http.dart' as http;

class ApiAllGetMaterial {
  static GetApiAllGetMaterial(context) async {
    List<AllGetMaterialClass> allGetMateriallist = [];
    AllGetMaterialClass allGetMaterialClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getMaterials"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});
      var data = jsonDecode(Response.body);
    print("Get Material all data=======>${data}");
      for (var i in data) {
        allGetMaterialClass = AllGetMaterialClass.fromJson(i);
        allGetMateriallist.add(allGetMaterialClass);
        // print(allCustomerslist);
      }
      print(
          "all Customers list===========================> ${allGetMateriallist.length}  ");
    } catch (e) {
      print("Something is wrong all Customers list=======:$e");
    }
    return allGetMateriallist;
  }
}