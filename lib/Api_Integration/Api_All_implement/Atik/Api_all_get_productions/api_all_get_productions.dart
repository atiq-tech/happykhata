import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:poss/Api_Integration/Api_Modelclass/production_record_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/productions_ModelClass.dart';
import 'package:poss/const_page.dart';

class ApiallGetProductions {
  static GetApiGetProductions(context) async {
    String Link = "${BaseUrl}api/v1/getProductions";
    List<ProductionsModelClass> allProductionslist = [];
    ProductionsModelClass productionsModelClass;
    try {
      var response = await Dio().post(Link,
          data: {},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var data = jsonDecode(response.data);

      for (var i in data) {
        productionsModelClass = ProductionsModelClass.fromJson(i);
        allProductionslist.add(productionsModelClass);
      }
      print("production_record=========daaaataaa============production_record");
      print(
          "allProductionRecordlista================= ${allProductionslist.length}");
    } catch (e) {
      print("Something is wrong all production_record=======:$e");
    }
    return allProductionslist;
  }
}


// class ApiallGetProductions {
//   static GetApiGetProductions(
//     context, 
//     // String? date, 
//     // String? incharge_id,
//     //  String? labour_cost, 
//     //  String? note, 
//     //  String? other_cost, 
//     //  String? production_id, 
//     //  String? production_sl, 
//     //  String? shift, 
//     //  String? total_cost,
//     //   String? transport_cost
//       ) async {
//     String Link = "${BaseUrl}api/v1/getProductions";
//     List<ProductionsModelClass> allProductionslist = [];
//     ProductionsModelClass productionsModelClass;
//     try {
//       var response = await Dio().post(Link,
//           data: {
//             // "date": "$date",
//             // "incharge_id": "$incharge_id",
//             // "labour_cost": "$labour_cost",
//             // "note": "$note",
//             // "other_cost": "$other_cost",
//             // "production_id": production_id,
//             // "production_sl": "$production_sl",
//             // "shift": "$shift",
//             // "total_cost": total_cost,
//             // "transport_cost": "$transport_cost"
// //             {
// // "date":"2023-05-09",
// // "incharge_id":"15",
// // "labour_cost":"5",
// // "note":"test",
// // "other_cost":"5",
// // "production_id":0,
// // "production_sl":"PR-3492",
// // "shift":"Day Shift",
// // "total_cost":15,
// // "transport_cost":"5"
// // }
//           },
//           options: Options(headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer ${GetStorage().read("token")}",
//           }));
//       var data = jsonDecode(response.data);

//       for (var i in data) {
//         productionsModelClass = ProductionsModelClass.fromJson(i);
//         allProductionslist.add(productionsModelClass);
//       }
//       print("production_record=========daaaataaa============production_record");
//       print(
//           "allProductionRecordlista================= ${allProductionslist.length}");
//     } catch (e) {
//       print("Something is wrong all production_record=======:$e");
//     }
//     return allProductionslist;
//   }
// }
