import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_All_customer_model_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/utils/utils.dart';
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
  String? _selectedPaymentType = 'All';
  String customerId = "";
  String paymentType = "";

  @override
  void initState() {
    // firstPickedDate = "2000-03-01";
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());

    Provider.of<CustomerListProvider>(context, listen: false)
        .getCustomerListData(context);
    // getCustomerPaymentData();
    super.initState();
  }

  var customerController = TextEditingController();

  getCustomerPaymentData(
      backEndFirstDate, backEndSecondDate, customerId, paymentType) {
    Provider.of<CustomerPaymentHistoryProvider>(context, listen: false)
        .getCustomerPaymentData(context, customerId, backEndFirstDate,
            backEndSecondDate, paymentType);
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
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      const Expanded(
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
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          height: 40,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 7, 125, 180),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FutureBuilder(
                            future: Provider.of<AllProductProvider>(context)
                                .Fatch_By_all_Customer(context),
                            builder: (context,
                                AsyncSnapshot<List<By_all_Customer>> snapshot) {
                              if (snapshot.hasData) {
                                return TypeAheadFormField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    onChanged: (newValue) {
                                      print("On change Value is $newValue");
                                      if (newValue == '') {
                                        _selectedCustomer = '';
                                      }
                                    },
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    controller: customerController,
                                    decoration: InputDecoration(
                                      hintText: 'Select Customer',
                                      suffix: _selectedCustomer == ''
                                          ? null
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  customerController.text = '';
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                child: Icon(
                                                  Icons.close,
                                                  size: 14,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return snapshot.data!
                                        .where((element) => element.displayName!
                                            .toLowerCase()
                                            .contains(pattern
                                                .toString()
                                                .toLowerCase()))
                                        .take(provideCustomerList.length)
                                        .toList();
                                    // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: SizedBox(
                                          child: Text(
                                        "${suggestion.displayName}",
                                        style: const TextStyle(fontSize: 12),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    );
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected:
                                      (By_all_Customer suggestion) {
                                    setState(() {
                                      customerController.text =
                                          suggestion.displayName!;
                                      _selectedCustomer =
                                          suggestion.customerSlNo;
                                      customerId =
                                          suggestion.customerSlNo.toString();
                                    });
                                  },
                                  onSaved: (value) {},
                                );
                              }
                              return const SizedBox();
                            },
                          ),

                          // child: DropdownButtonHideUnderline(
                          //   child: DropdownButton(
                          //     isExpanded: true,
                          //     hint: Text(
                          //       'Please select a customer',
                          //       style: TextStyle(
                          //         fontSize: 14,
                          //       ),
                          //     ),
                          //     value: _selectedCustomer,
                          //     onChanged: (newValue) {
                          //       setState(() {
                          //         customerId = "$newValue";
                          //         print("Customer Id============$newValue");
                          //         _selectedCustomer = newValue.toString();
                          //         print(
                          //             "dropdown value================$newValue");
                          //       });
                          //     },
                          //     items: provideCustomerList.map((location) {
                          //       return DropdownMenuItem(
                          //         child: Text(
                          //           "${location.customerName}",
                          //           style: TextStyle(
                          //             fontSize: 14,
                          //           ),
                          //         ),
                          //         value: location.customerSlNo,
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
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
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          height: 30,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 7, 125, 180),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text(
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
                                  print("Payment Type: $paymentType");
                                });
                              },
                              items: _category.map((location) {
                                return DropdownMenuItem(
                                  child: Text(
                                    location,
                                    style: const TextStyle(
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
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 5, top: 5, bottom: 5),
                          height: 30,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 7, 125, 180),
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
                                    const EdgeInsets.only(top: 10, left: 5),
                                filled: true,
                                // fillColor: Colors.blue[50],
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color.fromARGB(221, 22, 51, 95),
                                    size: 18,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: firstPickedDate,
                                hintStyle: const TextStyle(
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
                      const Text("To"),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          height: 30,
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 7, 125, 180),
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
                                    const EdgeInsets.only(top: 10, left: 5),
                                filled: true,
                                //fillColor: Colors.blue[50],
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color.fromARGB(221, 22, 51, 95),
                                    size: 18,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: secondPickedDate,
                                hintStyle: const TextStyle(
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
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        AllApiImplement.isCustomerPaymentHistoryLoading = true;
                      });
                      getCustomerPaymentData(backEndFirstDate,
                          backEndSecondDate, customerId, paymentType);

                      print("datessss $backEndFirstDate");
                      print("datessss $backEndSecondDate");
                      print("datessss $customerId");
                      print("datessss $paymentType");

                      // Future.delayed(const Duration(seconds: 3), () {
                      //   setState(() {
                      //     AllApiImplement.isCustomerPaymentHistoryLoading = fa;
                      //   });
                      // });
                    },
                    child: Container(
                      height: 32.0,
                      width: 105.0,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 113, 185),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Center(
                          child: Text(
                        "Show Report",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 92, 90, 90),
          ),
          AllApiImplement.isCustomerPaymentHistoryLoading && provideCustomerPaymentList.isNotEmpty
              ? const Center(child: CircularProgressIndicator())
              : provideCustomerPaymentList.isNotEmpty
                  ? Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 1.31,
                        width: double.infinity,
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                showCheckboxColumn: true,
                                border: TableBorder.all(
                                    color: Colors.black54, width: 1),
                                columns: const [
                                  DataColumn(
                                    label:
                                        Center(child: Text('Transaction Id')),
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
                                                provideCustomerPaymentList[
                                                        index]
                                                    .cPaymentInvoice
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                provideCustomerPaymentList[
                                                        index]
                                                    .cPaymentDate
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                provideCustomerPaymentList[
                                                        index]
                                                    .customerName
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                provideCustomerPaymentList[
                                                        index]
                                                    .transactionType
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                provideCustomerPaymentList[
                                                        index]
                                                    .paymentBy
                                                    .toString())),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                provideCustomerPaymentList[
                                                        index]
                                                    .cPaymentAmount
                                                    .toString())),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ))
        ],
      ),
    );
  }

  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondDate;
  var toDay = DateTime.now();

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    } else {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
        print("First Selected date $firstPickedDate");
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
        secondPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndSecondDate = Utils.formatBackEndDate(selectedDate);
        print("First Selected date $secondPickedDate");
      });
    } else {
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondDate = Utils.formatBackEndDate(toDay);
        print("First Selected date $secondPickedDate");
      });
    }
  }
}
