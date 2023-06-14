import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/salse_record_model_class.dart';
import 'package:poss/const_page.dart';

class ApiGetSalesRecord {

  static bool isLoading = false;

  static GetApiGetSalesRecord(
      context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String Link = "${BaseUrl}api/v1/getSalesRecord";
    List<SalseRecordModelClass> getSalesRecordlist = [];
    SalseRecordModelClass salseRecordModelClass;
    try {
      Response response = await Dio().post(Link,
          data: {
            "customerId": "$customerId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("getSalesRecordlist===::===getSalesRecordlist:${response.data}");
      print("===========++++++=============");
      print("getSalesRecordlist getSalesRecordlist getSalesRecordlist");
      print("============++++++=========");
      var data = jsonDecode(response.data);
      print("getSalesRecordlist===========getSalesRecordlist=======: ${data}");
      for (var i in data) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        getSalesRecordlist.add(salseRecordModelClass);
        isLoading = false;
      }
      print(
          "getSalesRecordlist getSalesRecordlist length is ${getSalesRecordlist.length}");
    } catch (e) {
      isLoading = false;
      print("Something is wrong getSalesRecordlist=======:$e");
    }
    return getSalesRecordlist;
  }

// static FetchAllSalseDataByemployee(
  //     String? dateFrom,
  //     String? dateTo,
  //     String? customerId,
  //     String? employeeId,
  //     String? productId,
  //     String? userFullName) async {
  //   String link = "${BaseUrl}api/v1/getSalesRecord";
  //   // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
  //   List<SalseRecordModelClass> sales_recordlist = [];
  //   try {
  //     SalseRecordModelClass salseRecordModelClass;
  //     Response response = await Dio().post(link,
  //         data: {
  //           // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
  //           "dateFrom": "$dateFrom",
  //           "dateTo": "$dateTo",
  //           "customerId": "$customerId",
  //           "employeeId": "$employeeId",
  //           "productId": "$productId",
  //           "userFullName": "$userFullName"
  //         },
  //         options: Options(headers: {
  //           "Content-Type": "application/json",
  //           "Authorization": "Bearer ${GetStorage().read("token")}",
  //         }));
  //     var item = jsonDecode(response.data);
  //     for (var i in item) {
  //       salseRecordModelClass = SalseRecordModelClass.fromJson(i);
  //       sales_recordlist.add(salseRecordModelClassi["SaleMaster_SlNo"],
    // List saleDetailsItem = i["saleDetails"];
    //     for (int j = 0; j < saleDetailsItem.length; j++) {
    //     }
    //     print("saleDetails saleDetails length is ${saleDetailsItem.length}");
  // i["SaleMaster_InvoiceNo"],
  // i["SalseCustomer_IDNo"],
  // i["employee_id"],
  // i["SaleMaster_SaleDate"],
  // i["SaleMaster_Description"],
  // i["SaleMaster_SaleType"],
  // i["payment_type"],
  // i["SaleMaster_TotalSaleAmount"],
  // i["SaleMaster_TotalDiscountAmount"],
  // i["SaleMaster_TaxAmount"],
  // i["SaleMaster_Freight"],
  // i["SaleMaster_SubTotalAmount"],
  // i["SaleMaster_PaidAmount"],
  // i["SaleMaster_DueAmount"],
  // i["SaleMaster_Previous_Due"],
  // i["Status"],
  // i["is_service"],
  // i["AddBy"],
  // i["AddTime"],
  // i["UpdateBy"],
  // i["UpdateTime"],
  // i["SaleMaster_branchid"],
  // i["Customer_Code"],
  // i["Customer_Name"],
  // i["Customer_Mobile"],
  // i["Customer_Address"],
  // i["Employee_Name"],
  // i["Brunch_name"],
  // i["total_products"],
  // i["saleDetails"],);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return sales_recordlist;
  // }
}
