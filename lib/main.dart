import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poss/hive/hive/product.dart';
import 'package:poss/login_page/log_in_page.dart';
import 'package:poss/provider/account_module/bank_deposit_transaction_provider.dart';
import 'package:poss/provider/account_module/bank_withdraw_transaction_provider.dart';
import 'package:poss/provider/account_module/cash_paid_transaction_provider.dart';
import 'package:poss/provider/account_module/cash_received_transaction_provider.dart';
import 'package:poss/provider/account_module/provider_cash_paid_to_customer.dart';
import 'package:poss/provider/account_module/provider_cash_paid_to_supplier.dart';
import 'package:poss/provider/account_module/provider_cash_received_from_customer.dart';
import 'package:poss/provider/account_module/provider_cash_received_from_supplier.dart';
import 'package:poss/provider/account_module/provider_cash_statement.dart';
import 'package:poss/provider/account_module/provider_employee_payment.dart';
import 'package:poss/provider/account_module/provider_purchase.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/purchase_module/provider_supplier_payment_report.dart';
import 'package:poss/provider/sales_module/provider_customer_list_with_customer_type.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_report.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:poss/provider/sales_module/stock/provider_current_stock.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_customer_list.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:poss/provider/sales_module/stock/provider_product_wise_stock.dart';
import 'package:poss/provider/sales_module/stock/provider_total_stock.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(ProductDetailsAdapter());
  // Opening the box
  await Hive.openBox('productBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // Closes all Hive boxes
    Hive.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllProductProvider>(
            create: (_) => AllProductProvider()),
        ChangeNotifierProvider<CurrentStockProvider>(
            create: (_) => CurrentStockProvider()),
        ChangeNotifierProvider<TotalStockProvider>(
            create: (_) => TotalStockProvider()),
        ChangeNotifierProvider<CategoryWiseStockProvider>(
            create: (_) => CategoryWiseStockProvider()),
        ChangeNotifierProvider<TotalStockWithCategoryProvider>(
            create: (_) => TotalStockWithCategoryProvider()),
        ChangeNotifierProvider<ProductWiseStockProvider>(
            create: (_) => ProductWiseStockProvider()),
        ChangeNotifierProvider<TotalStockWithProductProvider>(
            create: (_) => TotalStockWithProductProvider()),
        ChangeNotifierProvider<CustomerListProvider>(
            create: (_) => CustomerListProvider()),
        ChangeNotifierProvider<CustomerPaymentHistoryProvider>(
            create: (_) => CustomerPaymentHistoryProvider()),
        ChangeNotifierProvider<CounterProvider>(
            create: (_) => CounterProvider()),
        ChangeNotifierProvider<CustomerListByCustomerTypeProvider>(
            create: (_) => CustomerListByCustomerTypeProvider()),
        ChangeNotifierProvider<CustomerPaymentReportProvider>(
            create: (_) => CustomerPaymentReportProvider()),
        ChangeNotifierProvider<SupplierPaymentReportProvider>(
            create: (_) => SupplierPaymentReportProvider()),
        ChangeNotifierProvider<GetSaleProvider>(
            create: (_) => GetSaleProvider()),
        ChangeNotifierProvider<GetPurchaseProvider>(
            create: (_) => GetPurchaseProvider()),
        ChangeNotifierProvider<GetBankWithdrawTransactionProvider>(
            create: (_) => GetBankWithdrawTransactionProvider()),
        ChangeNotifierProvider<GetBankDepositTransactionProvider>(
            create: (_) => GetBankDepositTransactionProvider()),
        ChangeNotifierProvider<GetCashPaidTransactionProvider>(
            create: (_) => GetCashPaidTransactionProvider()),
        ChangeNotifierProvider<GetCashReceivedTransactionProvider>(
            create: (_) => GetCashReceivedTransactionProvider()),
        ChangeNotifierProvider<GetCashReceivedFromCustomerProvider>(
            create: (_) => GetCashReceivedFromCustomerProvider()),
        ChangeNotifierProvider<GetCashPaidToCustomerProvider>(
            create: (_) => GetCashPaidToCustomerProvider()),
        ChangeNotifierProvider<GetCashPaidToSupplierProvider>(
            create: (_) => GetCashPaidToSupplierProvider()),
        ChangeNotifierProvider<GetCashReceivedFromSupplierProvider>(
            create: (_) => GetCashReceivedFromSupplierProvider()),
        ChangeNotifierProvider<GeEmployeePaymentProvider>(
            create: (_) => GeEmployeePaymentProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Happy Khata',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LogInPage()),
    );
  }
}
