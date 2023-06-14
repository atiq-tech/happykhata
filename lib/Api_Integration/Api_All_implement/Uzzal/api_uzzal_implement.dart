import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_customer_wisee_category_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_purchase_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_All_customer_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_category_wise_saless_record.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_user_get_sale_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/customer_due_list_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/get_all_user_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/sales_module_by_employee_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/salse_record_model_class.dart';
import 'package:poss/const_page.dart';

class Api_Uzzal_implement_Class {
  static FetchgetCustomers(String? dateFrom, String? dateTo, String? customerId,
      String? employeeId, String? productId, String? userFullName) async {
    List<By_all_Customer> by_all_customer_list = [];
    String link = "${BaseUrl}api/v1/getCustomers";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    try {
      By_all_Customer by_all_customer;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        by_all_customer = By_all_Customer.fromJson(i);
        by_all_customer_list.add(by_all_customer);
      }
    } catch (e) {
      print(e);
    }
    return by_all_customer_list;
  }

  //////////////////////////////BY all Employeeee ////////////////////////

  static FetchAllEmployee(String? dateFrom, String? dateTo, String? customerId,
      String? employeeId, String? productId, String? userFullName) async {
    List<By_all_employee_ModelClass> By_all_employee_ModelClass_list = [];
    String link = "${BaseUrl}api/v1/getEmployees";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    try {
      By_all_employee_ModelClass by_all_employee_modelClass;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        by_all_employee_modelClass = By_all_employee_ModelClass.fromJson(i);
        By_all_employee_ModelClass_list.add(by_all_employee_modelClass);
      }
    } catch (e) {
      print(e);
    }
    return By_all_employee_ModelClass_list;
  }

  ////////////////////////////////////BY employeee full details//////////////////
  static FetchAllSalseDataByemployee(
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String link = "${BaseUrl}api/v1/getSalesRecord";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<SalseRecordModelClass> sales_recordlist = [];
    try {
      SalseRecordModelClass salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
      }
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////BY Category full details//////////////////

  static FetchCategorySalseData(
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String link = "${BaseUrl}api/v1/getSalesRecord";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<SalseRecordModelClass> sales_recordlist = [];
    try {
      SalseRecordModelClass salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
      }
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////Get All Prodeuct//////////////////
  static FetchAllProduct() async {
    String link = "${BaseUrl}api/v1/getProducts";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<AllProductModelClass> AllProductModelClasslist = [];
    try {
      AllProductModelClass allProductModelClass;
      Response response = await Dio().get(link,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        allProductModelClass = AllProductModelClass.fromJson(i);
        AllProductModelClasslist.add(allProductModelClass);
        //   print(AllProductModelClasslist[0].productName);
      }
    } catch (e) {
      print(e);
    }
    return AllProductModelClasslist;
  }

  ////////////////////////////////////BY Summary full details//////////////////
  static FetchSummarySalseData(
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String link = "${BaseUrl}api/v1/getSalesRecord";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<SalseRecordModelClass> sales_recordlist = [];
    try {
      SalseRecordModelClass salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
      }
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////BY Summary full details//////////////////
  static FetchGetbyuserSalseData(
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      String? productId,
      String? userFullName) async {
    String link = "${BaseUrl}api/v1/getSales";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<Sales> sales_list_by_user = [];
    try {
      Sales sales;
      Response response = await Dio().post(link,
          data: {
            // "dateFrom": "$dateFrom", "dateTo": "$dateTo"
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "customerId": "$customerId",
            "employeeId": "$employeeId",
            "productId": "$productId",
            "userFullName": "$userFullName"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        sales = Sales.fromJson(i);
        sales_list_by_user.add(sales);
      }
    } catch (e) {
      print(e);
    }
    return sales_list_by_user;
  }

  ////////////////////////////////////BY Summary full details//////////////////
  static FetchGetUserbyuserSalseData(context) async {
    String link = "${BaseUrl}api/v1/getUsers";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<Dataa> datalist = [];
    try {
      Dataa dataa;
      Response response = await Dio().get(link,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item["data"]) {
        dataa = Dataa.fromJson(i);
        datalist.add(dataa);
      }
    } catch (e) {
      print(e);
    }
    return datalist;
  }

  ////////////////////////////////////BY //////////////////
  static FetchCustomerwiseCategorySalseData(
      context, String? customerId, String? dateFrom, String? dateTo) async {
    String link = "${BaseUrl}api/v1/getCustomerCategories";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<CustomerCategories> CustomerCategorieslist = [];
    try {
      CustomerCategories customerCategories;
      Response response = await Dio().post(link,
          data: {
            "categoryId": "",
            "customerId": "$customerId",
            "productId": "",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "userFullName": ""
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        customerCategories = CustomerCategories.fromJson(i);
        CustomerCategorieslist.add(customerCategories);
        print(CustomerCategorieslist[0].productCategoryName);
      }
    } catch (e) {
      print(e);
    }
    return CustomerCategorieslist;
  }

  ////////////////////////////////////BY Customer wise sales Details full details//////////////////
  static FetchCustomerwiseCategorySalseDetails(context, String? categoryId,
      String? customerId, String? dateFrom, String? dateTo) async {
    String link = "${BaseUrl}api/v1/getSales";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<CategoryWiseSaleDetails> CategoryWiseSaleDetailsList = [];
    try {
      CategoryWiseSaleDetails dataa;
      Response response = await Dio().post(link,
          data: {
            "categoryId": "$categoryId",
            "customerId": "$customerId",
            "productId": "",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item["sales"]) {
        dataa = CategoryWiseSaleDetails.fromJson(i);
        CategoryWiseSaleDetailsList.add(dataa);
        print(CategoryWiseSaleDetailsList[0].customerName);
      }
    } catch (e) {
      print(e);
    }
    return CategoryWiseSaleDetailsList;
  }

  static bool isLoading = false;

  //////////////////// Customer Due List //////////////////////////////////
  static FetchAllCustomerDueList(context, String? customerId) async {
    String link = "${BaseUrl}api/v1/getCustomerDue";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<AllCustomerDueList> AllCustomerDueListList = [];
    double totalDue = 0.0;
    String totalD;
    try {
      AllCustomerDueList dataa;
      Response response = await Dio().post(link,
          data: {"customerId": "$customerId"},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        dataa = AllCustomerDueList.fromJson(i);
        AllCustomerDueListList.add(dataa);
        //Due
        totalDue += double.parse(
            "${AllCustomerDueList.fromJson(i).dueAmount}");
        totalD = totalDue.toStringAsFixed(2);
        GetStorage().write("totalDue", totalD);
        print(AllCustomerDueListList[0].customerName);
        isLoading = false;
      }
    } catch (e) {
      print(e);
    }
    return AllCustomerDueListList;
  }

  //////////////////// Customer Due List //////////////////////////////////
  static FetchOneCustomerDueList(context, String? customerId) async {
    String link = "${BaseUrl}api/v1/getCustomerDue";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<AllCustomerDueList> AllCustomerDueListList = [];
    try {
      AllCustomerDueList dataa;
      Response response = await Dio().post(link,
          data: {"customerId": ""},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        dataa = AllCustomerDueList.fromJson(i);
        AllCustomerDueListList.add(dataa);
        print(AllCustomerDueListList[0].customerName);
      }
    } catch (e) {
      print(e);
    }
    return AllCustomerDueListList;
  }

  ////////////////////////////////////BY Summary full details//////////////////
  static FetchCategoryySalseData(String? dateFrom, String? dateTo,
      String? customerId, String? categoryId) async {
    String link = "${BaseUrl}api/v1/getSalesRecord";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<SalseRecordModelClass> sales_recordlist = [];
    try {
      SalseRecordModelClass salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {
            "categoryId": "$categoryId",
            "customerId": "$customerId",
            "productId": "",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
        print(sales_recordlist[0].saleMasterDueAmount);
      }
      print(
          "sales_recordlist===========================> ${sales_recordlist.length}  ");
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////BY Summary full details//////////////////
  static GetPurchase(context) async {
    String link = "${BaseUrl}api/v1/getPurchases";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<Purchases> sales_recordlist = [];
    try {
      Purchases salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {"dateFrom": "", "dateTo": ""},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      // print(response.data);
      var item = jsonDecode(response.data);
      for (var i in item["purchases"]) {
        salseRecordModelClass = Purchases.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
        print(sales_recordlist[0].purchaseMasterBranchID);
      }
      print(
          "sales_recordlist===========================> ${sales_recordlist.length}  ");
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////BY User wise full details//////////////////
  static GetUserWisePurchase(
      String? userFullName, String? dateFrom, String? dateTo) async {
    String link = "${BaseUrl}api/v1/getPurchases";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<Purchases> sales_recordlist = [];
    double totalSalesSubtotal = 0.0;
    String totalSalesSt;
    double totalVat = 0.0;
    String totalVt;
    double totalDiscount = 0.0;
    String totalDiscnt;
    double totalTransCost = 0.0;
    String totalTC;
    double totalTotal = 0.0;
    String totalT;
    double totalPaid = 0.0;
    String totalPd;
    double totalDue = 0.0;
    String totalD;
    try {
      Purchases salseRecordModelClass;
      Response response = await Dio().post(link,
          data: {
            "userFullName": "$userFullName",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item["purchases"]) {
        salseRecordModelClass = Purchases.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);
        totalSalesSubtotal += double.parse(
            "${Purchases.fromJson(i).purchaseMasterSubTotalAmount}");
        totalSalesSt = totalSalesSubtotal.toStringAsFixed(2);
        GetStorage().write("totalSalesSubtotal", totalSalesSt);
        //vat
        totalVat += double.parse(
            "${Purchases.fromJson(i).purchaseMasterTax}");
        totalVt = totalVat.toStringAsFixed(2);
        GetStorage().write("totalVat", totalVt);
        //discount
        totalDiscount += double.parse(
            "${Purchases.fromJson(i).purchaseMasterDiscountAmount}");
        totalDiscnt = totalDiscount.toStringAsFixed(2);
        GetStorage().write("totalDiscount", totalDiscnt);
        //TransCost
        totalTransCost += double.parse(
            "${Purchases.fromJson(i).purchaseMasterFreight}");
        totalTC = totalTransCost.toStringAsFixed(2);
        GetStorage().write("totalTransCost", totalTC);
        //Total
        totalTotal += double.parse(
            "${Purchases.fromJson(i).purchaseMasterTotalAmount}");
        totalT = totalTotal.toStringAsFixed(2);
        GetStorage().write("totalTotal", totalT);
        //Paid
        totalPaid += double.parse(
            "${Purchases.fromJson(i).purchaseMasterPaidAmount}");
        totalPd = totalPaid.toStringAsFixed(2);
        GetStorage().write("totalPaid", totalPd);
        //Due
        totalDue += double.parse(
            "${Purchases.fromJson(i).purchaseMasterDueAmount}");
        totalD = totalDue.toStringAsFixed(2);
        GetStorage().write("totalDue", totalD);
      }
      print(
          "sales_recordlist===========================> ${sales_recordlist.length}  ");
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  ////////////////////////////////////Get All Prodeuct//////////////////
  static CategoryWiseProduct(String? isService, String? categoryId) async {
    String link = "${BaseUrl}api/v1/getProducts";
    // String basicAuth = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjI0IiwibmFtZSI6IkxpbmsgVXAgQXBpIiwidXNlcnR5cGUiOiJtIiwiaW1hZ2VfbmFtZSI6IjEuanBnIiwiYnJhbmNoIjoiMSJ9.v-zzAx2iYpfsyB-fna8_QHUkQGZpndgpAaYLRSSQ-8k';
    List<AllProductModelClass> AllProductModelClasslist = [];
    try {
      AllProductModelClass allProductModelClass;
      Response response = await Dio().post(link,
          data: {"isService": "$isService", "categoryId": "$categoryId"},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      for (var i in item) {
        allProductModelClass = AllProductModelClass.fromJson(i);
        AllProductModelClasslist.add(allProductModelClass);
      }
    } catch (e) {
      print(e);
    }
    return AllProductModelClasslist;
  }
}
