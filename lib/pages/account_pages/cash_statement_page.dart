import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/account_module/cash_paid_transaction_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../provider/account_module/bank_deposit_transaction_provider.dart';
import '../../provider/account_module/bank_withdraw_transaction_provider.dart';
import '../../provider/account_module/cash_received_transaction_provider.dart';
import '../../provider/account_module/provider_cash_paid_to_customer.dart';
import '../../provider/account_module/provider_cash_paid_to_supplier.dart';
import '../../provider/account_module/provider_cash_received_from_customer.dart';
import '../../provider/account_module/provider_cash_received_from_supplier.dart';
import '../../provider/account_module/provider_cash_statement.dart';
import '../../provider/account_module/provider_employee_payment.dart';
import '../../provider/account_module/provider_purchase.dart';

class CashStatementPage extends StatefulWidget {
  const CashStatementPage({super.key});

  @override
  State<CashStatementPage> createState() => _CashStatementPageState();
}

class _CashStatementPageState extends State<CashStatementPage> {
  String? firstPickedDate;
  var toDay = DateTime.now();

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatDate(toDay);
        print("Firstdateee $firstPickedDate");
      });
    }
  }

  String? secondPickedDate;

  void _secondSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatDate(toDay);
        print("Firstdateee $firstPickedDate");
      });
    }
  }
 bool isLoading = false;
  @override
  void initState() {
    // firstPickedDate = "2000-03-01";
    firstPickedDate = Utils.formatDate(DateTime.now());
    secondPickedDate = Utils.formatDate(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provideSaleList = Provider.of<GetSaleProvider>(context).provideSaleList;
    final providePurchaseList = Provider.of<GetPurchaseProvider>(context).providePurchaseList;
    final provideBankWithdrawTransactionList =
        Provider.of<GetBankWithdrawTransactionProvider>(context).provideBankWithdrawTransactionList;

    final provideBankDepositTransactionList =
        Provider.of<GetBankDepositTransactionProvider>(context).provideBankDepositTransactionList;

    final provideCashPaidTransactionList =
        Provider.of<GetCashPaidTransactionProvider>(context).provideCashTransactionPaidList;

    final provideCashReceivedTransactionList =
        Provider.of<GetCashReceivedTransactionProvider>(context).provideCashTransactionReceivedList;

    final provideCashReceivedFromCustomerList =
        Provider.of<GetCashReceivedFromCustomerProvider>(context).provideCashReceivedFromCustomerList;

    final provideCashPaidToCustomerList =
        Provider.of<GetCashPaidToCustomerProvider>(context).provideCashPaidToCustomerList;

    final provideCashPaidToSupplierList =
        Provider.of<GetCashPaidToSupplierProvider>(context).provideCashPaidToSupplierList;

    final provideCashReceivedFromSupplierList =
        Provider.of<GetCashReceivedFromSupplierProvider>(context).provideCashReceivedFromSupplierList;

    final provideEmployeePaymentList = Provider.of<GeEmployeePaymentProvider>(context).provideEmployeePaymentList;

    return Scaffold(
      appBar: CustomAppBar(title: "Cash Statement"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 100.0,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Date :",
                          style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 35,
                            child: GestureDetector(
                              onTap: (() {
                                _firstSelectedDate();
                              }),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 5),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: firstPickedDate,
                                  hintStyle: const TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: const Text("to"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 35,
                            child: GestureDetector(
                              onTap: (() {
                                _secondSelectedDate();
                              }),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 10, left: 5),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                                  hintText: secondPickedDate,
                                  hintStyle: const TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                         setState(() {
                          isLoading = true;
                         });
                          // print(
                          //     "Cash In Total: ${double.parse(GetStorage().read("totalSales") ?? "0") + double.parse(GetStorage().read("totalAmountReceivedFromCustomer") ?? "0") + double.parse(GetStorage().read("totalAmountReceivedFromSupplier") ?? "0") + double.parse(GetStorage().read("totalCashReceived") ?? "0") + double.parse(GetStorage().read("totalBankWithdraw") ?? "0")}");
                          // print("Total Sales: ${double.parse(GetStorage().read("totalSales") ?? "0")}");
                          // print(
                          //     "Total Received from Customer: ${double.parse(GetStorage().read("totalAmountReceivedFromCustomer") ?? "0")}");
                          // print(
                          //     "Total Received from Supplier: ${double.parse(GetStorage().read("totalAmountReceivedFromSupplier") ?? "0")}");
                          // print("totalCashReceived: ${double.parse(GetStorage().read("totalCashReceived") ?? "0")}");
                          // print("totalBankWithdraw: ${double.parse(GetStorage().read("totalBankWithdraw") ?? "0")}");
                          Provider.of<GetSaleProvider>(context, listen: false).getSaleData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetPurchaseProvider>(context, listen: false).getPurchaseData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetBankWithdrawTransactionProvider>(context, listen: false)
                              .getBankWithdrawTransactionData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetBankDepositTransactionProvider>(context, listen: false)
                              .getBankDepositTransactionData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashPaidTransactionProvider>(context, listen: false)
                              .getCashPaidTransactionData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashReceivedTransactionProvider>(context, listen: false)
                              .getCashReceivedTransactionData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashReceivedFromCustomerProvider>(context, listen: false)
                              .getCashReceivedFromCustomerData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashPaidToCustomerProvider>(context, listen: false).getCashPaidToCustomerData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashPaidToSupplierProvider>(context, listen: false).getCashPaidToSupplierData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GetCashReceivedFromSupplierProvider>(context, listen: false)
                              .getCashReceivedFromSupplierData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          Provider.of<GeEmployeePaymentProvider>(context, listen: false).getEmployeePaymentData(
                            context,
                            firstPickedDate,
                            secondPickedDate,
                          );

                          // provideSaleList.length == 0
                          //     ? GetStorage().write("totalSales", "0")
                          //     : debugPrint("/totalSales/");
                            Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                        },
                        child: Container(
                          height: 35.0,
                          width: 85.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 40, 104, 163), width: 2.0),
                            color: const Color.fromARGB(255, 87, 113, 170),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Center(
                              child: Text(
                            "Search",
                            style: TextStyle(letterSpacing: 1.0, color: Colors.white, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(6.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: Container(
            //           height: 40.0,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                   flex: 5,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 87, 141, 87),
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(5.0),
            //                           bottomLeft: Radius.circular(5.0),
            //                         )),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.monetization_on_outlined,
            //                           color: Colors.white,
            //                           size: 12.0,
            //                         ),
            //                         Text(
            //                           "Cash In",
            //                           style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 239, 244, 248)),
            //                         )
            //                       ],
            //                     ),
            //                   )),
            //               Expanded(
            //                   flex: 7,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 184, 199, 173),
            //                         borderRadius: BorderRadius.only(
            //                           bottomRight: Radius.circular(5.0),
            //                           topRight: Radius.circular(5.0),
            //                         )),
            //                     child: Center(
            //                         child: Text(
            //                             "${double.parse(GetStorage().read("totalSales") ?? "0") + double.parse(GetStorage().read("totalAmountReceivedFromCustomer") ?? "0") + double.parse(GetStorage().read("totalAmountReceivedFromSupplier") ?? "0") + double.parse(GetStorage().read("totalCashReceived") ?? "0") + double.parse(GetStorage().read("totalBankWithdraw") ?? "0")}")),
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 6),
            //       Expanded(
            //         flex: 1,
            //         child: Container(
            //           height: 40.0,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                   flex: 5,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 87, 141, 87),
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(5.0),
            //                           bottomLeft: Radius.circular(5.0),
            //                         )),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.monetization_on_outlined,
            //                           color: Colors.white,
            //                           size: 12.0,
            //                         ),
            //                         Text(
            //                           "Cash Out",
            //                           style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 239, 244, 248)),
            //                         )
            //                       ],
            //                     ),
            //                   )),
            //               Expanded(
            //                   flex: 7,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 184, 199, 173),
            //                         borderRadius: BorderRadius.only(
            //                           bottomRight: Radius.circular(5.0),
            //                           topRight: Radius.circular(5.0),
            //                         )),
            //                     child: Center(child: Text("tk.200.0")),
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 6),
            //       Expanded(
            //         flex: 1,
            //         child: Container(
            //           height: 40.0,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                   flex: 5,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 87, 141, 87),
            //                         borderRadius: BorderRadius.only(
            //                           topLeft: Radius.circular(5.0),
            //                           bottomLeft: Radius.circular(5.0),
            //                         )),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: [
            //                         Icon(
            //                           Icons.monetization_on_outlined,
            //                           color: Colors.white,
            //                           size: 12.0,
            //                         ),
            //                         Text(
            //                           "Balance",
            //                           style: TextStyle(fontSize: 12.0, color: Color.fromARGB(255, 239, 244, 248)),
            //                         )
            //                       ],
            //                     ),
            //                   )),
            //               Expanded(
            //                   flex: 7,
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Color.fromARGB(255, 184, 199, 173),
            //                         borderRadius: BorderRadius.only(
            //                           bottomRight: Radius.circular(5.0),
            //                           topRight: Radius.circular(5.0),
            //                         )),
            //                     child: Center(child: Text("tk.200.0")),
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const Center(
                child: Text(
              "Sales",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
            isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Invoice')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Customer')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Received')),
                              ),
                            ],
                            rows: List.generate(
                              provideSaleList.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(child: Text("${provideSaleList[index].saleMasterInvoiceNo}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideSaleList[index].saleMasterSaleDate}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideSaleList[index].customerName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideSaleList[index].saleMasterPaidAmount}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              provideSaleList.length == 0
                                  ? const Text(
                                      "0",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      "${GetStorage().read("totalSales")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Received from Customers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Invoice')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Customer')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Received')),
                              ),
                            ],
                            rows: List.generate(
                              provideCashReceivedFromCustomerList.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(
                                        child: Text("${provideCashReceivedFromCustomerList[index].cPaymentInvoice}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromCustomerList[index].cPaymentDate}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromCustomerList[index].customerName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromCustomerList[index].cPaymentAmount}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              provideCashReceivedFromCustomerList.length == 0
                                  ? const Text(
                                      "0",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      "${GetStorage().read("totalAmountReceivedFromCustomer")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const Center(
                child: Text(
              "Received from Suppliers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Invoice')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Supplier')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Received')),
                              ),
                            ],
                            rows: List.generate(
                              provideCashReceivedFromSupplierList.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(
                                        child: Text("${provideCashReceivedFromSupplierList[index].sPaymentInvoice}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromSupplierList[index].sPaymentDate}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromSupplierList[index].supplierName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedFromSupplierList[index].sPaymentAmount}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              provideCashReceivedFromSupplierList.length == 0
                                  ? const Text(
                                      "0",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      "${GetStorage().read("totalAmountReceivedFromSupplier")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Cash Received",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Transaction Id')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Account Name')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Received')),
                              ),
                            ],
                            rows: List.generate(
                              provideCashReceivedTransactionList.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedTransactionList[index].trSlNo}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedTransactionList[index].trDate}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedTransactionList[index].accName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideCashReceivedTransactionList[index].inAmount}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              provideCashReceivedTransactionList.length == 0
                                  ? const Text(
                                      "0",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      "${GetStorage().read("totalCashReceived")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Bank Withdraws",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DataTable(
                            showCheckboxColumn: true,
                            border: TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Sl')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Account Name')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Account Number')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Bank Name')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Withdraw')),
                              ),
                            ],
                            rows: List.generate(
                              provideBankWithdrawTransactionList.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].transactionId}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].accountName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].accountNumber}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].bankName}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].transactionDate}")),
                                  ),
                                  DataCell(
                                    Center(child: Text("${provideBankWithdrawTransactionList[index].amount}")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Total:",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              provideBankWithdrawTransactionList.length == 0
                                  ? const Text(
                                      "0",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      "${GetStorage().read("totalBankWithdraw")}",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Purchases",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Invoice')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Supplier')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Paid')),
                          ),
                        ],
                        rows: List.generate(
                          providePurchaseList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${providePurchaseList[index].purchaseMasterInvoiceNo}")),
                              ),
                              DataCell(
                                Center(child: Text("${providePurchaseList[index].purchaseMasterOrderDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${providePurchaseList[index].supplierName}")),
                              ),
                              DataCell(
                                Center(child: Text("${providePurchaseList[index].purchaseMasterTotalAmount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Paid to Suppliers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Invoice')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Supplier')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Paid')),
                          ),
                        ],
                        rows: List.generate(
                          provideCashPaidToSupplierList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${provideCashPaidToSupplierList[index].sPaymentInvoice}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToSupplierList[index].sPaymentDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToSupplierList[index].supplierName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToSupplierList[index].sPaymentAmount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Paid to Customers",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Invoice')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Customer')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Paid')),
                          ),
                        ],
                        rows: List.generate(
                          provideCashPaidToCustomerList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${provideCashPaidToCustomerList[index].cPaymentInvoice}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToCustomerList[index].cPaymentDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToCustomerList[index].customerName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidToCustomerList[index].cPaymentAmount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Cash Paid",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Transaction Id')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Account Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Paid')),
                          ),
                        ],
                        rows: List.generate(
                          provideCashPaidTransactionList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${provideCashPaidTransactionList[index].trSlNo}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidTransactionList[index].trDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidTransactionList[index].accName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideCashPaidTransactionList[index].outAmount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Bank Deposits",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Sl')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Account Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Account Number')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Bank Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Deposit')),
                          ),
                        ],
                        rows: List.generate(
                          provideBankDepositTransactionList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].transactionId}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].accountName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].accountNumber}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].bankName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].transactionDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideBankDepositTransactionList[index].amount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
                child: Text(
              "Employee Payments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 15, 101, 199),
              ),
            )),
            const SizedBox(height: 3.0),
             isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Employee Id')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Employee Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Month')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Amount')),
                          ),
                        ],
                        rows: List.generate(
                          provideEmployeePaymentList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text("${provideEmployeePaymentList[index].employeeID}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideEmployeePaymentList[index].employeeName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideEmployeePaymentList[index].paymentDate}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideEmployeePaymentList[index].monthName}")),
                              ),
                              DataCell(
                                Center(child: Text("${provideEmployeePaymentList[index].paymentAmount}")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
