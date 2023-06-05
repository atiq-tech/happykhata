import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/All_Shift_model_class.dart';
import 'package:poss/const_page.dart';
import 'package:http/http.dart' as http;

class ApiAllGetShift {
  static GetApiAllGetShift(context) async {
    List<AllShiftModelClass> allGetShiftlist = [];
    AllShiftModelClass allShiftModelClass;
    try {
      var Response = await http.post(
          Uri.parse("${BaseUrl}api/v1/getShifts"),
          headers: {
            "Authorization": "Bearer ${GetStorage().read("token")}",
          },
          body: {});
      var data = jsonDecode(Response.body);
      print("Get Shift all data=======>${data}");
      for (var i in data) {
        allShiftModelClass = AllShiftModelClass.fromJson(i);
        allGetShiftlist.add(allShiftModelClass);

      }
      print(
          "all Shift length is===========================> ${allGetShiftlist.length}  ");
    } catch (e) {
      print("Something is wrong all Shift list=======:$e");
    }
    return allGetShiftlist;
  }
}