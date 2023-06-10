import 'package:flutter/material.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_All_get_production_record/production_record_api.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_Get_Purchase_record/Get_Purchase_record_all.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_Get_sales/api_get_sales.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_accounts/Api_all_bank_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_transaction/Api_all_bank_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_cash_transaction/Api_all_cash_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_category/Api_all_category.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_customers/Api_all_customers.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_getUnits/Api_all_getUnits.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_bank_transaction/Api_all_get_bank_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_cash_transaction/Api_all_get_cash_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_customer_payment/Api_all_get_customer_payment.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_districes/Api_all_get_districes.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_employees/Api_all_get_employees.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_material/Api_all_get_material.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_productions/api_all_get_productions.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_shift/Api_all_get_shift.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_supplier_payment/Api_all_get_supplier_payment.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_suppliers/api_all_suppliers.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_meterial_purchase_record/Api_all_meterial_purchase_record.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_product_ledger/api_all_product_ledger.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_products/api_all_products.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_profit&loss/Api_all_profit_&_loss.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_supplier_due/api_all_supplier_due.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_customer_categories/api_get_customer_categories.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_customer_products/api_get_customer_products.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_purchase_details/api_get_purchase_details.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_sale_details/api_get_sale_details.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_sale_summary/api_get_sale_summary.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_get_sales_record/api_get_sales_record.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/api_get_purchases/api_get_purchases.dart';
import 'package:poss/Api_Integration/Api_Modelclass/All_Shift_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Get_purchase_record_all.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_accounts_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_transaction_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_cash_transaction_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_get_bank_transaction_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_get_cash_transaction_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/cash_statement_model.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_Profit_Loss_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_category_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_customers_Class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_getUnits_Class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_customer_payment_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_districes_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_employee_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_material_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_supplier_payment_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_meterial_purchase_record_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_product_ledger_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_products_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_supplier_due_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_customer_cateMClass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_customer_product_Mclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_purchase_details.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_purchases_mclass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/get_sale_summaryMClass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/production_record_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/productions_ModelClass.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/salse_record_model_class.dart';

import '../../Api_Integration/Api_Modelclass/get_sale_details_MClass.dart';

class CounterProvider extends ChangeNotifier {
  //production record
  List<ProductionRecordModelClass> allProductionRecordlist = [];

  getProductionRecord(BuildContext context, String? dateFrom,
      String? dateTo) async {
    allProductionRecordlist =
    await ApiallProductionRecord.GetApiProductionRecord(
        context, dateFrom, dateTo);
    notifyListeners();
  }

  //Get Suppliers
  List<AllSuppliersClass> allSupplierslist = [];

  Future<List<AllSuppliersClass>>getSupplier(BuildContext context) async {
    allSupplierslist = await ApiAllSuppliers.GetApiAllSuppliers(context);
    allSupplierslist.insert(0, AllSuppliersClass(displayName: "General Supplier"));
    notifyListeners();
    return allSupplierslist;
  }

  //Get Meterial purchase
  List<Purchases> allPurchaseslist = [];
  getMeterialPurchase(context, String? dateFrom,
      String? dateTo, String? supplier_id) async {
    allPurchaseslist =
    await ApiAllMeterialPurchase.GetApiAllMeterialPurchase(
        context, dateFrom, dateTo,supplier_id);
    notifyListeners();
  }

  //Customers/////////////
  List<AllCustomersClass> allCustomerslist = [];

  Future<List<AllCustomersClass>> getCustomers(BuildContext context) async {
    allCustomerslist = await ApiAllCustomers.GetApiAllCustomers(context);
    notifyListeners();
    return allCustomerslist;
  }

  //Profit & Loss
  List<AllProfitLossClass> allProfitLosslist = [];

  getProfitLoss(context, String? customer, String? dateFrom,
      String? dateTo) async {
    allProfitLosslist = await ApiAllProfitLoss.GetApiAllProfitLoss(
        context, customer, dateFrom, dateTo);
    notifyListeners();
  }

  //Products
  List<AllProductsClass> allProductslist = [];

  getProducts(BuildContext context) async {
    allProductslist = await ApiAllProducts.GetApiAllProducts(context);
    notifyListeners();
  }

  //Product Ledger
  List<Ledger> allProductLedgerlist = [];

  getProductLedger(context, String? productId, String? dateFrom,
      String? dateTo) async {
    allProductLedgerlist = await ApiAllProductLedger.GetApiAllProductLedger(
        context, productId, dateFrom, dateTo);
    notifyListeners();
  }

  //Supplier Due
  List<AllSupplierDueClass> allSupplierDuelist = [];

  getSupplierDue(context, String? supplierId) async {
    allSupplierDuelist =
    await ApiAllSupplierDue.GetApiAllSupplierDue(context, supplierId);
    notifyListeners();
  }

  //Supplier Due
  List<AllSupplierDueClass> alllSupplierDuelist = [];

  getSupplierDuee(context,) async {
    allSupplierDuelist =
    await ApiAllSupplierDue.GetApiAllSupplierDue(context, "");
    notifyListeners();
  }

  //ACCOUNTS
  List<AllAccountsModelClass> allAccountslist = [];

  Future<List<AllAccountsModelClass>>getAccounts(BuildContext context) async {
    allAccountslist = await ApiAllAccounts.GetApiAllAccounts(context);
    notifyListeners();
    return allAccountslist;
  }

  //CashTransactions
  List<AllCashTransactionsClass> allCashTransactionslist = [];

  getCashTransactions(context, String? transactionType, String? accountId,
      String? dateFrom, String? dateTo) async {
    allCashTransactionslist =
    await ApiAllCashTransactions.GetApiAllCashTransactions(
        context, transactionType, accountId, dateFrom, dateTo);
    notifyListeners();
  }

  //Get CashTransactions
  List<AllGetCashTransactionsClass> allGetCashTransactionslist = [];

  getGetCashTransactions(context, String? dateFrom, String? dateTo) async {
    allGetCashTransactionslist =
    await ApiAllGetCashTransactions.GetApiAllGetCashTransactions(
        context, dateFrom, dateTo);
    notifyListeners();
  }

  // Bank ACCOUNTS
  List<AllBankAccountModelClass> allBankAccountlist = [];

  getBankAccounts(BuildContext context) async {
    allBankAccountlist =
    await ApiAllBankAccounts.GetApiAllBankAccounts(context);
    notifyListeners();
  }

  //Get bankTransactions
  List<AllGetBankTransactionClass> allGetBankTransactionslist = [];

  getGetBankTransactions(context, String? dateFrom, String? dateTo) async {
    allGetBankTransactionslist =
    await ApiAllGetBankTransactions.GetApiAllGetBankTransactions(
        context, dateFrom, dateTo);
    notifyListeners();
  }

  //Bank Transactions
  List<AllBankTransactionModelClass> allBankTransactionslist = [];

  getBankTransactions(context, String? accountId, String? dateFrom,
      String? dateTo, String? transactionType) async {
    allBankTransactionslist =
    await ApiAllBankTransactions.GetApiAllBankTransactions(
        context, accountId, dateFrom, dateTo, transactionType);
    notifyListeners();
  }

  //  //  // Get CustomerPayment
  List<AllGetCustomerPaymentClass> allGetCustomerPaymentlist = [];

  getGetCustomerPayment(context, String? dateFrom, String? dateTo) async {
    allGetCustomerPaymentlist =
    await ApiAllGetCustomerPayments.GetApiAllGetCustomerPayments(
        context, dateFrom, dateTo);
    notifyListeners();
  }

  //Get Supplier Payment
  List<AllGetSupplierPaymentClass> allGetSupplierPaymentlist = [];

  getGetSupplierPayment(context, String? dateFrom, String? dateTo) async {
    allGetSupplierPaymentlist =
    await ApiAllGetSupplierPayments.GetApiAllGetSupplierPayments(
        context, dateFrom, dateTo);
    notifyListeners();
  }

  //Category
  List<AllCategoryClass> allCategorylist = [];

  getCategory(BuildContext context) async {
    allCategorylist = await ApiAllCategory.GetApiAllCategory(context);
    notifyListeners();
  }

  //Get Units
  List<AllGetUnitsClass> allUnitslist = [];

  getUnits(BuildContext context) async {
    allUnitslist = await ApiAllGetUnits.GetApiAllUnits(context);
    notifyListeners();
  }

  //Get Districts area
  List<AllGetDistricesClass> allDistrictslist = [];

  Future<List<AllGetDistricesClass>>getDistricts(BuildContext context) async {
    allDistrictslist = await ApiAllGetDistricts.GetApiAllDistricts(context);
    return allDistrictslist;
    notifyListeners();
  }

  //Get Material
  List<AllGetMaterialClass> allGetMateriallist = [];

  Future<List<AllGetMaterialClass>>getMaterials(BuildContext context) async {
    allGetMateriallist = await ApiAllGetMaterial.GetApiAllGetMaterial(context);
    return allGetMateriallist;
    notifyListeners();
  }

  //Get Shift
  List<AllShiftModelClass> allGetShiftlist = [];

  getShift(BuildContext context) async {
    allGetShiftlist = await ApiAllGetShift.GetApiAllGetShift(context);
    notifyListeners();
  }

  //Get Employee//Incharge
  List<AllGetEmployeeClass> allGetEmployeelist = [];

  Future<List<AllGetEmployeeClass>>getEmployees(BuildContext context) async {
    allGetEmployeelist =
    await ApiAllGetEmployees.GetApiAllGetEmployees(context);
    return allGetEmployeelist;
    notifyListeners();
  }

  //Get productions
  List<ProductionsModelClass> allProductionslist = [];

  getProductions(BuildContext context) async {
    allProductionslist =
    await ApiallGetProductions.GetApiGetProductions(context);
    notifyListeners();
  }

//get purchase record
  List<GetPurchaseRecord_ALL> getPurchaseRecordList = [];
  getPurchaseRecord(BuildContext context, String? dateFrom, String? dateTo,
      String? userFullName) async {
    getPurchaseRecordList = await ApiGetPurchaseRecordAll.GetPurchaseRecordAll(
        context, dateFrom, dateTo, userFullName);
    notifyListeners();
  }

  //Get Purchase Details
  List<GetPurchaseDetailsModelClass> getPurchaseDetailslist = [];

  getPurchaseDetails(context, String? categoryId, String? dateFrom,
      String? dateTo, String? productId, String? supplierId) async {
    getPurchaseDetailslist =
    await ApiGetPurchaseDetails.GetApiGetPurchaseDetails(
        context, categoryId, dateFrom, dateTo, productId, supplierId);
    notifyListeners();
  }

  //Get Sales
  List<Sales> getSaleslist = [];

  getSales(context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? employeeId,
      String? productId,
      String? userFullName,) async {
    getSaleslist = await ApiGetSales.GetApiGetSales(
      context,
      customerId,
      dateFrom,
      dateTo,
      employeeId,
      productId,
      userFullName,
    );
    notifyListeners();
  }

  //Get Sales record
  List<SalseRecordModelClass> getSalesRecordlist = [];

  getSalesRecord(context,
      String? customerId,
      String? dateFrom,
      String? dateTo,
      String? employeeId,
      String? productId,
      String? userFullName,) async {
    getSalesRecordlist = await ApiGetSalesRecord.GetApiGetSalesRecord(
      context,
      customerId,
      dateFrom,
      dateTo,
      employeeId,
      productId,
      userFullName,
    );
    notifyListeners();
  }

  //Get_Customer_products
  List<GetCustomerProductsMclass> getCustomerProductslist = [];

  Future<List<GetCustomerProductsMclass>>getCustomer_products(BuildContext context, String? customerId) async {
    getCustomerProductslist =
    await ApiGetCustomerProducts.GetApiGetCustomerProducts(context, customerId);
    return getCustomerProductslist;
    notifyListeners();
  }

  //Get_Customer_Categoris
  List<GetCustomerCateMClass> getCustomerCategorieslist = [];

  getCustomer_Categoris(BuildContext context, String? customerId) async {
    getCustomerCategorieslist =
    await ApiGetCustomerCategories.GetApiGetCustomerCategories(
        context, customerId);
    notifyListeners();
  }

//get sale summary
  List<GetSaleSummaryMClass> getSaleSummarylist = [];

  getSaleSummary(BuildContext context, String? dateFrom, String? dateTo,
      String? productId) async {
    getSaleSummarylist = await ApiGetSaleSummary.GetApiGetSaleSummary(
        context, dateFrom, dateTo, productId);
    notifyListeners();
  }

  //Get Sale_Details
  List<GetSaleDetailsMClass> getSaleDetailslist = [];

  getSaleDetails(context, String? categoryId, String? customerId,
      String? dateFrom,
      String? dateTo, String? productId) async {
    getSaleDetailslist =
    await ApiGetSaleDetails.GetApiGetSaleDetails(
        context, categoryId, customerId, dateFrom, dateTo, productId);
    notifyListeners();
  }

  //Get Sales
  List<Purchasess> getPurchasesslist = [];

  getPurchasess(context,
      String? dateFrom,
      String? dateTo,
      String? userFullName,) async {
    getPurchasesslist = await ApiGetPurchases.GetApiGetPurchases(
      context,
      dateFrom,
      dateTo,
      userFullName,
    );
    notifyListeners();
  }
}
