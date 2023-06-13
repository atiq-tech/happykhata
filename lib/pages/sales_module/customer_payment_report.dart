import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_All_customer_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/customer_list_model.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/provider_customer_list_with_customer_type.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../provider/sales_module/provider_customer_payment_report.dart';

class Customer_Payment_Report extends StatefulWidget {
  const Customer_Payment_Report({Key? key}) : super(key: key);

  @override
  State<Customer_Payment_Report> createState() =>
      _Customer_Payment_ReportState();
}

class _Customer_Payment_ReportState extends State<Customer_Payment_Report> {
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

  // List<String> _category = [
  //   'All',
  //   'Received',
  //   'Paid',
  // ];

  var customerController = TextEditingController();

  String? _selectedCustomer;
  String? _selectedCustomerType = 'Retail';
  String customerId = "";
  String customerType = "";
  String paymentType = "";

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
        print("First Selected date $firstPickedDate");
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatDate(toDay);
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
        secondPickedDate = Utils.formatDate(selectedDate);
        print("First Selected date $secondPickedDate");
      });
    }
    else{
      setState(() {
        secondPickedDate = Utils.formatDate(toDay);
        print("First Selected date $secondPickedDate");
      });
    }
  }

  bool isLoading = false; //for loading circulerprogressindicator
  @override
  void initState() {
    Provider.of<CustomerListByCustomerTypeProvider>(context, listen: false).getCustomerListByCustomerTypeData(context,customerType: _selectedCustomerType);
    getCustomerPaymentData();
    firstPickedDate = Utils.formatDate(DateTime.now());
    secondPickedDate = Utils.formatDate(DateTime.now());
    super.initState();
  }

  getCustomerPaymentData(){
    Provider.of<CustomerPaymentReportProvider>(context,
        listen: false)
        .getCustomerPaymentData(
      context,
      customerId,
      firstPickedDate,
      secondPickedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provideCustomerList =
        Provider.of<CustomerListByCustomerTypeProvider>(context)
            .provideCustomerListByCustomerType;
    // provideCustomerList.removeAt(0);

    final provideCustomerPaymentReportList =
        Provider.of<CustomerPaymentReportProvider>(context)
            .provideCustomerPaymentReportList;

    print(
        "UI: provideCustomerList length=====> ${provideCustomerList.length}");
    print(
        "UI: provideCustomerPaymentReportList length=====> ${provideCustomerPaymentReportList.length}");
    // for (int i = 0; i <= provideCustomerPaymentReportList.length; i++) {
    //   print(
    //       "UI: provideCustomerPaymentReportList=====> ${provideCustomerPaymentReportList[0].payments![0].description}");
    // }

    return Scaffold(
      appBar: CustomAppBar(title: "Customer Payment Report"),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          "Customer Type:",
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
                              value: _selectedCustomerType,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCustomerType = newValue.toString();
                                  _selectedCustomerType == 'Retail'
                                      ? customerType = 'retail'
                                      : _selectedCustomerType == 'WholeSale'
                                          ? customerType = "wholesale"
                                          : "";
                                  Provider.of<CustomerListByCustomerTypeProvider>(
                                          context,
                                          listen: false)
                                      .getCustomerListByCustomerTypeData(
                                          context, customerType: customerType);
                                  print("Customer Type: ${customerType}");
                                });
                              },
                              items: _types.map((location) {
                                return DropdownMenuItem(
                                  value: location,
                                  child: Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
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
                        child: TypeAheadFormField(
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
                              suffix: _selectedCustomer == '' ? null : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    customerController.text = '';
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  child: Icon(Icons.close,size: 14,),
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) {
                            provideCustomerList.removeAt(0);
                            return provideCustomerList
                                .where((element) => element
                                .displayName!
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
                              (CustomerListModel suggestion) {
                            setState(() {
                              customerId = "${suggestion.customerSlNo}";
                              customerController.text = suggestion.displayName!;
                              _selectedCustomer = suggestion.customerSlNo;

                              print("Selected customer $customerId");
                            });
                          },
                          onSaved: (value) {},
                        ),
                        // child: FutureBuilder(
                        //   future: Provider.of<AllProductProvider>(context)
                        //       .Fatch_By_all_Customer(context),
                        //   builder: (context,
                        //       AsyncSnapshot<List<By_all_Customer>>
                        //       snapshot) {
                        //     if (snapshot.hasData) {
                        //       return TypeAheadFormField(
                        //         textFieldConfiguration:
                        //         TextFieldConfiguration(
                        //           onChanged: (newValue) {
                        //             print("On change Value is $newValue");
                        //             if (newValue == '') {
                        //               _selectedCustomer = '';
                        //             }
                        //           },
                        //           style: const TextStyle(
                        //             fontSize: 15,
                        //           ),
                        //           controller: customerController,
                        //           decoration: InputDecoration(
                        //             hintText: 'Select Customer',
                        //             suffix: _selectedCustomer == '' ? null : GestureDetector(
                        //               onTap: () {
                        //                 setState(() {
                        //                   customerController.text = '';
                        //                 });
                        //               },
                        //               child: const Padding(
                        //                 padding: EdgeInsets.symmetric(horizontal: 3),
                        //                 child: Icon(Icons.close,size: 14,),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         suggestionsCallback: (pattern) {
                        //           return snapshot.data!
                        //               .where((element) => element
                        //               .displayName!
                        //               .toLowerCase()
                        //               .contains(pattern
                        //               .toString()
                        //               .toLowerCase()))
                        //               .take(provideCustomerList.length)
                        //               .toList();
                        //           // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                        //         },
                        //         itemBuilder: (context, suggestion) {
                        //           return ListTile(
                        //             title: SizedBox(
                        //                 child: Text(
                        //                   "${suggestion.displayName}",
                        //                   style: const TextStyle(fontSize: 12),
                        //                   maxLines: 1,
                        //                   overflow: TextOverflow.ellipsis,
                        //                 )),
                        //           );
                        //         },
                        //         transitionBuilder:
                        //             (context, suggestionsBox, controller) {
                        //           return suggestionsBox;
                        //         },
                        //         onSuggestionSelected:
                        //             (By_all_Customer suggestion) {
                        //           setState(() {
                        //             customerController.text = suggestion.displayName!;
                        //             _selectedCustomer = suggestion.countrySlNo;
                        //           });
                        //         },
                        //         onSaved: (value) {},
                        //       );
                        //     }
                        //     return const SizedBox();
                        //   },
                        // ),

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
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
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
                          margin: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
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
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        getCustomerPaymentData();
                        print("datessss ${firstPickedDate}");
                        print("datessss ${secondPickedDate}");
                        print("datessss ${customerId}");
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
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
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 92, 90, 90),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : provideCustomerPaymentReportList.isNotEmpty
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
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: DataTable(
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1),
                              columns: [
                                const DataColumn(
                                  label: Center(child: Text('Date')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Description')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Bill')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Paid')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Inv.Due')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Retruned')),
                                ),
                                const DataColumn(
                                  label:
                                      Center(child: Text('Paid to customer')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Balance')),
                                ),
                              ],
                              rows: List.generate(
                                provideCustomerPaymentReportList.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .date.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .description.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .bill.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .paid.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .due.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .returned.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              provideCustomerPaymentReportList[
                                                      index]
                                                  .paid.toString())),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              ("${provideCustomerPaymentReportList[index].balance.toString()}"))),
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
                    : const Align(alignment: Alignment.center,child: Center(child: Text("No Data Found",style: TextStyle(fontSize: 16,color: Colors.red),),))


    ],
      ),
    );
  }
}
