import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/cash_transaction_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/purchase_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/category_wise_stock_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/customer_list_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/customer_payment_report.dart' as salesModule;
import 'package:poss/const_page.dart';
import '../../Api_Modelclass/account_module/bank_transaction_model.dart';
import '../../Api_Modelclass/account_module/cash_statement_model.dart';
import '../../Api_Modelclass/account_module/employee_payment_model.dart';
import '../../Api_Modelclass/account_module/supplier_payment_model.dart';
import '../../Api_Modelclass/purchase_module/supplier_payment_report_model.dart';
import '../../Api_Modelclass/sales_module/current_stock_model.dart' as current_stock_model;
import '../../Api_Modelclass/sales_module/customer_payment_history_model.dart';
import '../../Api_Modelclass/sales_module/product_wise_stock_model.dart';
import '../../Api_Modelclass/sales_module/total_stock_model.dart' as total_stock_model;
import '../../Api_Modelclass/sales_module/salse_record_model_class.dart';

class AllApiImplement {
  //==================Sales Module ==> Sales Record API=======================
  static FetchAllSaleRecordData(String? dateFrom, String? dateTo, String? customerId, String? employeeId,
      String? productId, String? userFullName) async {
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
      // print(response.data);
      var item = jsonDecode(response.data);
      //   print(item);
      for (var i in item) {
        salseRecordModelClass = SalseRecordModelClass.fromJson(i);
        sales_recordlist.add(salseRecordModelClass);

        //   print(sales_recordlist[0].saleDetails![0].productName);
      }
    } catch (e) {
      print(e);
    }
    return sales_recordlist;
  }

  //==================Sales Module ==> Current Stock API=======================
  static FetchCurrentStock(context) async {
    List<current_stock_model.Stock> currentStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getCurrentStock";
      current_stock_model.Stock item;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data["stock"]) {
        item = current_stock_model.Stock.fromJson(i);
        currentStockList.add(item);
        // print("item===========================${item}");
        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return currentStockList;
  }

  //==================Sales Module ==> Total Stock API=======================
  static FetchTotalStock(context) async {
    List<total_stock_model.Stock> totalStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getTotalStock";
      total_stock_model.Stock item;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data["stock"]) {
        item = total_stock_model.Stock.fromJson(i);
        totalStockList.add(item);
        // print("item===========================${item}");

        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return totalStockList;
  }

  //==================Sales Module ==> Total Stock with Category ID API=======================
  static FetchTotalStockWithCategory(context, String? categoryId) async {
    List<total_stock_model.Stock> totalStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getTotalStock";
      total_stock_model.Stock item;
      Response response = await Dio().post(url,
          data: {"categoryId": "$categoryId"},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      //print("data===========================${data["stock"][0]["ProductCategory_Name"]}");
      for (var i in data["stock"]) {
        item = total_stock_model.Stock.fromJson(i);
        totalStockList.add(item);
        // print("product cat name===========================${totalStockList[0].productCategoryName}");
        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return totalStockList;
  }

  //==================Sales Module ==> Category Wise Stock API=======================
  static FetchCategoryWiseStock(context) async {
    List<CategoryWiseStockModel> categoryWiseStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getCategories";
      CategoryWiseStockModel item;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data) {
        item = CategoryWiseStockModel.fromJson(i);
        categoryWiseStockList.add(item);
        // print("item===========================${item}");

        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return categoryWiseStockList;
  }

  //==================Sales Module ==>Total Stock with Product ID API=======================
  static FetchTotalStockWithProduct(context, String? productId) async {
    List<total_stock_model.Stock> totalStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getTotalStock";
      total_stock_model.Stock item;
      Response response = await Dio().post(url,
          data: {"productId": "$productId"},
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      //print("data===========================${data["stock"][0]["ProductCategory_Name"]}");
      for (var i in data["stock"]) {
        item = total_stock_model.Stock.fromJson(i);
        totalStockList.add(item);
        // print("product cat name===========================${totalStockList[0].productCategoryName}");
        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return totalStockList;
  }

  //==================Sales Module ==> Product Wise Stock API=======================
  static FetchProductWiseStock(context) async {
    List<ProductWiseStockModel> productWiseStockList = [];
    try {
      String url = "${BaseUrl}api/v1/getProducts";
      ProductWiseStockModel item;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data) {
        item = ProductWiseStockModel.fromJson(i);
        productWiseStockList.add(item);
        // print("item===========================${item}");

        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return productWiseStockList;
  }

  //==================Sales Module ==> Customer List API=======================
  static FetchCustomerList(context) async {
    List<CustomerListModel> customerList = [];
    try {
      String url = "${BaseUrl}api/v1/getCustomers";
      CustomerListModel item;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data) {
        item = CustomerListModel.fromJson(i);
        customerList.add(item);
        // print("Customer List length===========================${customerList.length}");

        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return customerList;
  }

  //==================Sales Module ==> Customer Payment History API=======================
  static FetchCustomerPaymentHistory(
    context,
    String? customerId,
    String? dateFrom,
    String? dateTo,
    String? paymentType,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCustomerPayments";
    List<CustomerPaymentHistoryModel> customerPaymentList = [];
    CustomerPaymentHistoryModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "customerId": "$customerId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "paymentType": "$paymentType",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("customerPaymentList===========: ${data}");
      for (var i in data) {
        item = CustomerPaymentHistoryModel.fromJson(i);
        customerPaymentList.add(item);
      }

      print("customerPaymentList length is==${customerPaymentList.length}");
    } catch (e) {
      print("Something is wrong customerPaymentList=======:$e");
    }
    return customerPaymentList;
  }

  //==================Sales Module ==> Customer List with CustomerType API=======================
  static FetchCustomerListWithCustomerType(
    context,
    String? customerType,
  ) async {
    List<CustomerListModel> customerList = [];
    try {
      String url = "${BaseUrl}api/v1/getCustomers";
      CustomerListModel item;
      Response response = await Dio().post(url,
          data: {
            "customerType": "$customerType",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      // print("data===========================${data}");
      for (var i in data) {
        item = CustomerListModel.fromJson(i);
        customerList.add(item);
        // print("Customer List length===========================${customerList.length}");
        //print("product name:${currentStockList[0].productName} \n");
      }
    } catch (e) {
      print(e);
    }
    return customerList;
  }

  //==================Sales Module ==> Customer Payment Report API=======================
  static FetchCustomerPaymentReport(
    context,
    String? customerId,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCustomerLedger";
    List<salesModule.Payments> customerPaymentReportList = [];
    salesModule.Payments item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "customerId": "$customerId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);

      for (var i in data['payments']) {
        item = salesModule.Payments.fromJson(i);
        customerPaymentReportList.add(item);
      }
      print("Api: customerPaymentReportList length is==${customerPaymentReportList.length}");
      print("Api: customerPaymentList description is==${customerPaymentReportList[0].description}");
    } catch (e) {
      print("Api: Something is wrong customerPaymentReportList=======:$e");
    }
    return customerPaymentReportList;
  }

  //==================Purchase Module ==> Supplier Payment Report API=======================
  static FetchSupplierPaymentReport(
    context,
    String? supplierId,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getSupplierLedger";
    List<Payments> supplierPaymentReportList = [];
    Payments item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "supplierId": "$supplierId",
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
   print(response.data);
      var data = jsonDecode(response.data);

      for (var i in data['payments']) {
        item = Payments.fromJson(i);
        supplierPaymentReportList.add(item);
      }
      print("Api: supplierPaymentReportList length is==${supplierPaymentReportList.length}");
      print("Api: supplierPaymentList description is==${supplierPaymentReportList[0].description}");
    } catch (e) {
      print("Api: Something is wrong supplierPaymentReportList=======:$e");
    }
    return supplierPaymentReportList;
  }

  //==================Account Module ==> Sales data API=======================
  static FetchAllSalseData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String link = "${BaseUrl}api/v1/getSales";
    List<Sales> salesList = [];
    double totalSales = 0.0;
    String totalSaless;

    Sales item;
    try {
      Response response = await Dio().post(link,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      // print(response.data);
      var data = jsonDecode(response.data);
      //   print(item);
      for (var i in data['sales']) {
        item = Sales.fromJson(i);
        salesList.add(item);
        totalSales += double.parse("${item.saleMasterPaidAmount}");
        totalSaless = totalSales.toStringAsFixed(2);
        GetStorage().write("totalSales", totalSaless);
        // print(sales_recordlist[0].saleDetails![0].productName);my help section
      }
    } catch (e) {
      print(e);
    }
    return salesList;
  }

  //==================Account Module ==> purchase API=======================
  static FetchAllPurchaseData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String link = "${BaseUrl}api/v1/getPurchases";
    List<Purchases> purchaseList = [];
    Purchases item;
    try {
      Response response = await Dio().post(link,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      // print(response.data);
      var data = jsonDecode(response.data);
      //   print(item);
      for (var i in data['purchases']) {
        item = Purchases.fromJson(i);
        purchaseList.add(item);
        // print(sales_recordlist[0].saleDetails![0].productName);
      }
    } catch (e) {
      print(e);
    }
    return purchaseList;
  }

  //==================Accounts Module ==> Bank Withdraw Transaction Type  API=======================
  static FetchBankWithdrawTransaction(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getBankTransactions";
    List<BankTransactionModel> bankWithdrawTransactionList = [];
    double totalBankWithdraw = 0.0;
    String totalBankWithdraww;
    BankTransactionModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "transactionType": "withdraw",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data) {
        item = BankTransactionModel.fromJson(i);
        bankWithdrawTransactionList.add(item);
        totalBankWithdraw += double.parse("${item.amount}");
        totalBankWithdraww = totalBankWithdraw.toStringAsFixed(2);
        GetStorage().write("totalBankWithdraw", totalBankWithdraww);
      }

      print("bankWithdrawTransactionList length is==${bankWithdrawTransactionList.length}");
    } catch (e) {
      print("Something is wrong bankWithdrawTransactionList=======:$e");
    }
    return bankWithdrawTransactionList;
  }

  //==================Accounts Module ==> Bank Deposit Transaction Type  API=======================
  static FetchBankDepositTransaction(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getBankTransactions";
    List<BankTransactionModel> bankDepositTransactionList = [];
    BankTransactionModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "transactionType": "deposit",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data) {
        item = BankTransactionModel.fromJson(i);
        bankDepositTransactionList.add(item);
      }

      print("bankDepositTransactionList length is==${bankDepositTransactionList.length}");
    } catch (e) {
      print("Something is wrong bankDepositTransactionList=======:$e");
    }
    return bankDepositTransactionList;
  }

  //==================Accounts Module ==> Cash Paid Transaction Type  API=======================
  static FetchCashTransactionPaid(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCashTransactions";
    List<CashTransactionModel> cashTransactionPaidList = [];
    CashTransactionModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "transactionType": "paid",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);

      for (var i in data) {
        item = CashTransactionModel.fromJson(i);
        cashTransactionPaidList.add(item);
      }

      print("cashTransactionPaidList length is==${cashTransactionPaidList.length}");
    } catch (e) {
      print("Something is wrong cashTransactionPaidList=======:$e");
    }
    return cashTransactionPaidList;
  }

  //==================Accounts Module ==> Cash Received Transaction Type  API=======================
  static FetchCashTransactionReceived(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCashTransactions";
    List<CashTransactionModel> cashTransactionReceivedList = [];
    double totalCashReceived = 0.0;
    String totalCashReceivedd;
    CashTransactionModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "transactionType": "received",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);

      for (var i in data) {
        item = CashTransactionModel.fromJson(i);
        cashTransactionReceivedList.add(item);
        totalCashReceived += double.parse("${item.inAmount}");
        totalCashReceivedd = totalCashReceived.toStringAsFixed(2);
        GetStorage().write("totalCashReceived", totalCashReceivedd);
      }
      print("cashTransactionReceivedList length is==${cashTransactionReceivedList.length}");
    } catch (e) {
      print("Something is wrong cashTransactionReceivedList=======:$e");
    }
    return cashTransactionReceivedList;
  }

  //==================Account Module ==> Cash Statement ===> Received from Customer API=======================

  static FetchCustomerReceivedPayment(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCustomerPayments";
    List<CustomerPaymentHistoryModel> customerPaymentList = [];
    double totalAmountReceivedFromCustomer = 0.0;
    String totalAmountReceivedFromCustomerr;
    CustomerPaymentHistoryModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "paymentType": "received",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);
      for (var i in data.where((item) => item["CPayment_Paymentby"] == "cash")) {
        item = CustomerPaymentHistoryModel.fromJson(i);
        customerPaymentList.add(item);
        totalAmountReceivedFromCustomer += double.parse("${item.cPaymentAmount}");
        totalAmountReceivedFromCustomerr = totalAmountReceivedFromCustomer.toStringAsFixed(2);
        GetStorage().write("totalAmountReceivedFromCustomer", totalAmountReceivedFromCustomerr);
      }

      print("customer Payment length is==${customerPaymentList.length}");
      print("totalAmountReceivedFromCustomer is==$totalAmountReceivedFromCustomer");
    } catch (e) {
      print("Something is wrong customerPaymentList=======:$e");
    }
    return customerPaymentList;
    //return {customerPaymentList, totalAmountReceivedFromCustomer};
  }

  //==================Account Module ==> Cash Statement ===> Paid to Customer API=======================
  static FetchCustomerPaidPayment(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getCustomerPayments";
    List<CustomerPaymentHistoryModel> customerPaymentList = [];
    CustomerPaymentHistoryModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "paymentType": "paid",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data.where((item) => item["CPayment_Paymentby"] == "cash")) {
        item = CustomerPaymentHistoryModel.fromJson(i);
        customerPaymentList.add(item);
      }

      print("customer Payment length is==${customerPaymentList.length}");
    } catch (e) {
      print("Something is wrong customerPaymentList=======:$e");
    }
    return customerPaymentList;
  }

  //==================Account Module ==> Cash Statement ===> Received from Customer API=======================
  static FetchSupplierReceivedPayment(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getSupplierPayments";
    List<SupplierPaymentModel> supplierPaymentList = [];
    double totalAmountReceivedFromSupplier = 0.0;
    String totalAmountReceivedFromSupplierr;

    SupplierPaymentModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "paymentType": "received",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data.where((item) => item["SPayment_Paymentby"] == "cash")) {
        item = SupplierPaymentModel.fromJson(i);
        supplierPaymentList.add(item);

        totalAmountReceivedFromSupplier += double.parse("${item.sPaymentAmount}");
        totalAmountReceivedFromSupplierr = totalAmountReceivedFromSupplier.toStringAsFixed(2);
        GetStorage().write("totalAmountReceivedFromSupplier", totalAmountReceivedFromSupplierr);
      }

      print("supplier Payment length is==${supplierPaymentList.length}");
    } catch (e) {
      print("Something is wrong supplierPaymentList=======:$e");
    }
    return supplierPaymentList;
  }

  //==================Account Module ==> Cash Statement ===> Paid to Customer API=======================
  static FetchSupplierPaidPayment(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getSupplierPayments";
    List<SupplierPaymentModel> supplierPaymentList = [];
    SupplierPaymentModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
            "paymentType": "paid",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data.where((item) => item["SPayment_Paymentby"] == "cash")) {
        item = SupplierPaymentModel.fromJson(i);
        supplierPaymentList.add(item);
      }
      print("supplier Payment length is==${supplierPaymentList.length}");
    } catch (e) {
      print("Something is wrong supplierPaymentList=======:$e");
    }
    return supplierPaymentList;
  }

  //==================Account Module ==> Cash Statement ===> Paid to Customer API=======================
  static FetchEmployeedPayment(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    String apiUrl = "${BaseUrl}api/v1/getEmployeePayments";
    List<EmployerPaymentModel> employeePaymentList = [];
    EmployerPaymentModel item;
    try {
      Response response = await Dio().post(apiUrl,
          data: {
            "dateFrom": "$dateFrom",
            "dateTo": "$dateTo",
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));

      var data = jsonDecode(response.data);


      for (var i in data) {
        item = EmployerPaymentModel.fromJson(i);
        employeePaymentList.add(item);
      }

      print("employee Payment length is==${employeePaymentList.length}");
    } catch (e) {
      print("Something is wrong employeePaymentList=======:$e");
    }
    return employeePaymentList;
  }
}
