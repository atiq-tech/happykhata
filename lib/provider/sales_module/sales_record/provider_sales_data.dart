import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_customer_wisee_category_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_All_customer_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_category_wise_saless_record.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_user_get_sale_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/customer_due_list_modelclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/get_all_user_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/sales_module_by_employee_modelclass.dart';

import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../../Api_Integration/Api_All_implement/Uzzal/api_uzzal_implement.dart';
import '../../../Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_purchase_modelclass.dart';
import '../../../Api_Integration/Api_Modelclass/sales_module/salse_record_model_class.dart';

class AllProductProvider extends ChangeNotifier {
  List<SalseRecordModelClass> provideSalesRecordList = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  getAllSalesRecordData(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    provideSalesRecordList = await AllApiImplement.FetchAllSaleRecordData(
        dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }
  ////////////////////////////////By all customer/////////////////////////

  List<By_all_Customer> by_all_customer_list = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//

  Fatch_By_all_Customer(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    by_all_customer_list = await Api_Uzzal_implement_Class.FetchgetCustomers(
        dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }
  ////////////////////////////////By all Employee/////////////////////////

  List<By_all_employee_ModelClass> By_all_employee_ModelClass_List = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  Fatch_By_all_Employee(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    By_all_employee_ModelClass_List =
        await Api_Uzzal_implement_Class.FetchAllEmployee(
            dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }
  ////////////////////////////////By all Salse Recorde Employee/////////////////////////

  List<SalseRecordModelClass> ByemployeeallSalesRecordList = [];
  getAllSalesRecordbyemployeeData(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    ByemployeeallSalesRecordList =
        await Api_Uzzal_implement_Class.FetchAllSalseDataByemployee(
            dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }
  ////////////////////////////////By all Salse Recorde Employee/////////////////////////

  List<SalseRecordModelClass> FetchCategorySalseDatalist = [];
  FetchCategorySalseData(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    FetchCategorySalseDatalist =
        await Api_Uzzal_implement_Class.FetchCategorySalseData(
            dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }

  ////////////////////////////////AllProductLiist/////////////////////////

  List<AllProductModelClass> AllProductModelClassList = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  FetchAllProduct(BuildContext context) async {
    AllProductModelClassList =
        await Api_Uzzal_implement_Class.FetchAllProduct();
    notifyListeners();
  }

  ////////////////////////////////Byallsummarylist/////////////////////////

  List<SalseRecordModelClass> FetchBySummaryProductList = [];
  FetchBySummaryProduct(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    FetchBySummaryProductList =
        await Api_Uzzal_implement_Class.FetchSummarySalseData(
            dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }
  ////////////////////////////////ByalGet all sales list/////////////////////////

  List<Sales> salesList_by_user = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  FetchByUsergetAllSaleProduct(
      BuildContext context,
      String? dateFrom,
      String? dateTo,
      String? customerId,
      String? employeeId,
      productId,
      String? userFullName) async {
    salesList_by_user = await Api_Uzzal_implement_Class.FetchGetbyuserSalseData(
        dateFrom, dateTo, customerId, employeeId, productId, userFullName);
    notifyListeners();
  }

  ////////////////////////////////ByalGet all sales list/////////////////////////

  List<Dataa> Datalistt = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  FetchUserByUsergetAllSaleProduct(context) async {
    Datalistt =
        await Api_Uzzal_implement_Class.FetchGetUserbyuserSalseData(context);
    notifyListeners();
  }

  ////////////////////////////////Customer wise Category sales list/////////////////////////

  List<CustomerCategories> CustomerCategoriesList = [];
  FetchCustomerCategoriesSaleProduct(
      context, String? customerId, String? dateFrom, String? dateTo) async {
    CustomerCategoriesList =
        await Api_Uzzal_implement_Class.FetchCustomerwiseCategorySalseData(
            context, customerId, dateFrom, dateTo);
    notifyListeners();
  }
  ////////////////////////////////Customer wise Category sales list/////////////////////////

  List<CategoryWiseSaleDetails> CategoryWiseSaleDetailsList = [];
  FetchCustomerwiseCategorySalseDetailss(context, String? categoryId,
      String? customerId, String? dateFrom, String? dateTo) async {
    CategoryWiseSaleDetailsList =
        await Api_Uzzal_implement_Class.FetchCustomerwiseCategorySalseDetails(
            context, categoryId, customerId, dateFrom, dateTo);
    notifyListeners();
  }
  ////////////////////////////////Customer Due List /////////////////////////

  List<AllCustomerDueList> AllCustomerDueListList = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//
  FetchAllCustomerDueList(context, String? categoryId) async {
    AllCustomerDueListList =
        await Api_Uzzal_implement_Class.FetchAllCustomerDueList(
            context, categoryId);
    notifyListeners();
  }
  ////////////////////////////////One Customer Due List /////////////////////////

  List<AllCustomerDueList> OneCustomerDueListCustomerDueListList = [];
  //FetchAllSalseData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,String? productId,String? userFullName//

  FetchOneCustomerDueListCustomerDueList(context, String? categoryId) async {
    OneCustomerDueListCustomerDueListList =
        await Api_Uzzal_implement_Class.FetchOneCustomerDueList(
            context, categoryId);
    notifyListeners();
  }

  ////////////////////////////////One Customer Due List /////////////////////////
  List<SalseRecordModelClass> FetchCategoryySalseDataListt = [];
  FetchCategoryySalseDataList(String? dateFrom, String? dateTo,
      String? customerId, String? categoryId) async {
    FetchCategoryySalseDataListt =
        await Api_Uzzal_implement_Class.FetchCategoryySalseData(
            dateFrom, dateTo, customerId, categoryId);
    notifyListeners();
  }

  ///////////Get Pruchase All//////////////////
  List<Purchases> PurchasesList = [];
  Purchases_All_Provider(context) async {
    PurchasesList = await Api_Uzzal_implement_Class.GetPurchase(context);
    notifyListeners();
  }

  ///////////Get User Wise Pruchase All//////////////////
  List<Purchases> UserWisePurchasesList = [];
  GetUserWisePurchase(
      String? userFullName, String? dateFrom, String? dateTo) async {
    UserWisePurchasesList = await Api_Uzzal_implement_Class.GetUserWisePurchase(
        userFullName, dateFrom, dateTo);
    notifyListeners();
  }

  ///////////Get User Wise Pruchase All////////////////// eita
  List<AllProductModelClass> CategoryWiseProductList = [];
  CategoryWiseProduct(String? isService, String? categoryId) async {
    CategoryWiseProductList =
        await Api_Uzzal_implement_Class.CategoryWiseProduct(
            isService, categoryId);
    notifyListeners();

    List<Purchases> UserWisePurchasesList = [];
    GetUserWisePurchase(
        String? userFullName, String? dateFrom, String? dateTo) async {
      UserWisePurchasesList =
          await Api_Uzzal_implement_Class.GetUserWisePurchase(
              userFullName, dateFrom, dateTo);
    }
  }
}
