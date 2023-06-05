import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:provider/provider.dart';

import '../../../provider/providers/counter_provider.dart';
import '../../provider/purchase_module/provider_supplier_payment_report.dart';

class SupplierPaymentReport extends StatefulWidget {
  const SupplierPaymentReport({Key? key}) : super(key: key);

  @override
  State<SupplierPaymentReport> createState() => _SupplierPaymentReportState();
}

class _SupplierPaymentReportState extends State<SupplierPaymentReport> {
  bool isAllPaymentTypeClicked = false;
  bool isReceivedPaymentTypeClicked = false;
  bool isPaidPaymentTypeClicked = false;
  bool isCategoryWiseClicked = false;
  bool isProductWiseClicked = false;
  double thFontSize = 10.0;
  String data = '';
  String data2 = '';
  bool is_second_Caregory = false;
  bool is_first_Caregory = false;

  String? _selectedCustomer;

  String supplierId = "";
  String customerType = "";
  String paymentType = "";

  String? firstPickedDate;
  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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
        secondPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    // firstPickedDate = "2000-03-01";
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Provider.of<CounterProvider>(context, listen: false).getSupplier(
      context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allSupplierslist =
        Provider.of<CounterProvider>(context).allSupplierslist;

    final provideSupplierPaymentReportList =
        Provider.of<SupplierPaymentReportProvider>(context)
            .provideSupplierPaymentReportList;
    print(
        "UI: provideCustomerPaymentReportList length=====> ${allSupplierslist.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Supplier Payment Report"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Customer:",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 30,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 7, 125, 180),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  'Please select a supplier',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                value: _selectedCustomer,
                                onChanged: (newValue) {
                                  setState(() {
                                    supplierId = "$newValue";
                                    print("Customer Id============$newValue");
                                    _selectedCustomer = newValue.toString();
                                    print(
                                        "dropdown value================$newValue");
                                  });
                                },
                                items: allSupplierslist.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.supplierName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.supplierSlNo,
                                  );
                                }).toList(),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                          height: 30,
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 7, 125, 180),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: (() {
                              _firstSelectedDate();
                            }),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 5),
                                filled: true,
                                // fillColor: Colors.blue[50],
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color.fromARGB(221, 22, 51, 95),
                                    size: 18,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: firstPickedDate == null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())
                                    : firstPickedDate,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black87),
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
                        child: Text("To"),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          height: 30,
                          padding: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 7, 125, 180),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: (() {
                              _secondSelectedDate();
                            }),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 5),
                                filled: true,
                                //fillColor: Colors.blue[50],
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color.fromARGB(221, 22, 51, 95),
                                    size: 18,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: secondPickedDate == null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())
                                    : secondPickedDate,
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.black87),
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
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        Provider.of<SupplierPaymentReportProvider>(context,
                                listen: false)
                            .getSupplierPaymentData(
                          context,
                          "$supplierId",
                          firstPickedDate,
                          secondPickedDate,
                        );
                        Future.delayed(Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Container(
                        height: 32.0,
                        width: 105.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 113, 185),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                            child: Text(
                          "Show Report",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 92, 90, 90),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.31,
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: DataTable(
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1),
                              columns: [
                                DataColumn(
                                  label: Center(child: Text('Date')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Description')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Bill')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Paid')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Inv.Due')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Retruned')),
                                ),
                                DataColumn(
                                  label:
                                      Center(child: Text('Paid to customer')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Balance')),
                                ),
                              ],
                              rows: List.generate(
                                provideSupplierPaymentReportList.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .date!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .description!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .bill!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .paid!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .due!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .returned!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideSupplierPaymentReportList[
                                                      index]
                                                  .paid!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              ("${provideSupplierPaymentReportList[index].balance!}"))),
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
                )
        ],
      ),
    );
  }
}
