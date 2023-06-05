// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:poss/const_page.dart';

// class ApiAllAddCustomer {
//   static GetApiAllAddCustomer(
//     context,
//     int? Customer_SlNo,
//     String? Customer_Code,
//     String? Customer_Name,
//     String? Customer_Type,
//     String? Customer_Phone,
//     String? Customer_Mobile,
//     String? Customer_Email,
//     String? Customer_OfficePhone,
//     String? Customer_Address,
//     String? owner_name,
//     String? area_ID,
//     String? Customer_Credit_Limit,
//     String? previous_due,
//   ) async {
//     String Link = "${BaseUrl}api/v1/addCustomer";

//     try {
//       Response response = await Dio().post(Link,
//           data: {
//             "Customer_SlNo": Customer_SlNo,
//             "Customer_Code": "$Customer_Code",
//             "Customer_Name": "$Customer_Name",
//             "Customer_Type": "$Customer_Type",
//             "Customer_Phone": "$Customer_Phone",
//             "Customer_Mobile": "$Customer_Mobile",
//             "Customer_Email": "$Customer_Email",
//             "Customer_OfficePhone": "$Customer_OfficePhone",
//             "Customer_Address": "$Customer_Address",
//             "owner_name": "$owner_name",
//             "area_ID": "$area_ID",
//             "Customer_Credit_Limit": "$Customer_Credit_Limit",
//             "previous_due": "$previous_due"
//           },
//           options: Options(headers: {
//             "Content-Type": "application/json",
//             "Authorization": "Bearer ${GetStorage().read("token")}",
//           }));
//       print("AddCustomer AddCustomer::AddCustomer:${response.data}");
//       print("===========++++++=============");
//       print("AddCustomer AddCustomer AddCustomer");
//       print("============+++++++++++++++=========");

//       var data = jsonDecode(response.data);

//       print("Add Customer  data is ${data}");
//     } catch (e) {
//       print("Something is wrong AAAAdd CCCCustomer =======:$e");
//     }
//   }
// }
