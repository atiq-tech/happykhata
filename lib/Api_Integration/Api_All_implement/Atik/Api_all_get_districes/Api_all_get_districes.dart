import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart'as http;
import 'package:poss/Api_Integration/Api_Modelclass/all_get_districes_class.dart';
import 'package:poss/const_page.dart';

class ApiAllGetDistricts{
  static GetApiAllDistricts(context) async {
    List<AllGetDistricesClass> allDistrictslist = [];
    AllGetDistricesClass allGetDistricesClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getDistricts"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});

      var data = jsonDecode(Response.body);
      // print("+++++====+++++product all++++===data;;;;;: ${data}");
      for (var i in data) {
        allGetDistricesClass= AllGetDistricesClass.fromJson(i);
        allDistrictslist.add(allGetDistricesClass);

      }
      print("Districts=========data;;;;;: ${allDistrictslist.length}");

    } catch (e) {
      print("Something is wrong all Districts list=======:$e");
    }
    return allDistrictslist;
  }
}