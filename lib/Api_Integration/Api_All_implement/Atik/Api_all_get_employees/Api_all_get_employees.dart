import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_employee_class.dart';
import 'package:poss/const_page.dart';
import 'package:http/http.dart' as http;

class ApiAllGetEmployees {
  static GetApiAllGetEmployees(context) async {
    List<AllGetEmployeeClass> allGetEmployeelist = [];
    AllGetEmployeeClass allGetEmployeeClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getEmployees"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});
      var data = jsonDecode(Response.body);
      print("Get Employees all data=======>${data}");
      for (var i in data) {
        allGetEmployeeClass = AllGetEmployeeClass.fromJson(i);
        allGetEmployeelist.add(allGetEmployeeClass);

      }
      print(
          "all Employees length is===========================> ${allGetEmployeelist.length}  ");
    } catch (e) {
      print("Something is wrong all Employees list=======:$e");
    }
    return allGetEmployeelist;
  }
}