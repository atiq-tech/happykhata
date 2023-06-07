import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:provider/provider.dart';

import '../../provider/sales_module/stock/provider_customer_list.dart';

class Customer_Payment_History extends StatefulWidget {
  const Customer_Payment_History({Key? key}) : super(key: key);

  @override
  State<Customer_Payment_History> createState() =>
      _Customer_Payment_HistoryState();
}

class _Customer_Payment_HistoryState extends State<Customer_Payment_History> {
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

  List<String> _types = [
    'Retail',
    'WholeSale',
  ];

  List<String> _category = [
    'All',
    'Received',
    'Paid',
  ];

  String? _selectedCustomer;
  String? _selectedPaymentType;
  String customerId = "";
  String paymentType = "";

  bool isLoading = false; //for loading circulerprogressindicator
  @override
  void initState() {
   // firstPickedDate = "2000-03-01";
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Provider.of<CustomerListProvider>(context, listen: false)
        .getCustomerListData(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provideCustomerList =
        Provider.of<CustomerListProvider>(context).provideCustomerList;
    final provideCustomerPaymentList =
        Provider.of<CustomerPaymentHistoryProvider>(context)
            .provideCustomerPaymentHistoryList;

    print(
        "{Payment History =======provideCustomerPaymentList=====> ${provideCustomerPaymentList.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Customer Payment History"),
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
                                  'Please select a customer',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                value: _selectedCustomer,
                                onChanged: (newValue) {
                                  setState(() {
                                    customerId = "$newValue";
                                    print("Customer Id============$newValue");
                                    _selectedCustomer = newValue.toString();
                                    print(
                                        "dropdown value================$newValue");
                                  });
                                },
                                items: provideCustomerList.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.customerName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.customerSlNo,
                                  );
                                }).toList(),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Payment Type:",
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
                              hint: Text(
                                'Please select a payment type',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ), // Not necessary for Option 1
                              value: _selectedPaymentType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedPaymentType = newValue.toString();
                                  _selectedPaymentType == 'Paid'
                                      ? paymentType = 'paid'
                                      : _selectedPaymentType == 'Received'
                                      ? paymentType = "received"
                                      : _selectedPaymentType == 'All'
                                      ? paymentType = ""
                                      : paymentType = "";
                                  print("Payment Type: ${paymentType}");
                                });
                              },
                              items: _category.map((location) {
                                return DropdownMenuItem(
                                  child: Text(
                                    location,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
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
                        Provider.of<CustomerPaymentHistoryProvider>(context,
                                listen: false)
                            .getCustomerPaymentData(context, "$customerId",
                                firstPickedDate, secondPickedDate, paymentType);
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
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
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
                            // color: Colors.red,
                            // padding:EdgeInsets.only(bottom: 16.0),
                            child: DataTable(
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1),
                              columns: [
                                DataColumn(
                                  label: Center(child: Text('Transaction Id')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Date')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Customer')),
                                ),
                                DataColumn(
                                  label:
                                      Center(child: Text('Transaction Type')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Payment by')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Amount')),
                                ),
                              ],
                              rows: List.generate(
                                provideCustomerPaymentList.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .cPaymentInvoice!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .cPaymentDate!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .customerName!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .transactionType!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .paymentBy!)),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentList[index]
                                                  .cPaymentAmount!)),
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
        // Provider.of<CustomerPaymentHistoryProvider>(context, listen: false)
        //     .getCustomerPaymentData(context, customerId, firstPickedDate,
        //         secondPickedDate, paymentType);
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
        secondPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        // Provider.of<CustomerPaymentHistoryProvider>(context, listen: false)
        //     .getCustomerPaymentData(context, customerId, firstPickedDate,
        //         secondPickedDate, paymentType);
        print("secondPickedDate $secondPickedDate");
      });
    }
  }
}
