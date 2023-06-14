import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/provider_customer_payment_history.dart';
import 'package:poss/utils/utils.dart';
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
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
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
        secondPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndSecondDate = Utils.formatBackEndDate(selectedDate);
        print("Firstdateee $secondPickedDate");
      });
    }
    else{
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondDate = Utils.formatBackEndDate(toDay);
        print("Firstdateee $secondPickedDate");
      });
    }
  }

  bool isLoading = false;
  var supplyerController = TextEditingController();

  @override
  void initState() {
    // firstPickedDate = "2000-03-01";
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
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
        "UI: allSupplierslist length=====> ${allSupplierslist.length}");
    print(
        "UI: provideSupplierPaymentReportList length=====> ${provideSupplierPaymentReportList.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Supplier Payment Report"),
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
                          "Supplier:",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            height: 38,
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
                                onChanged: (value){
                                  if (value == '') {
                                    _selectedCustomer = '';
                                  }
                                },
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                                controller: supplyerController,
                                decoration: InputDecoration(
                                  hintText: 'Select Supplier',
                                  suffix: _selectedCustomer == '' ? null : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        supplyerController.text = '';
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3),
                                      child: Icon(Icons.close,size: 14,),
                                    ),
                                  ),
                                )
                            ),
                            suggestionsCallback: (pattern) {
                              allSupplierslist.removeAt(0);
                              return allSupplierslist
                                  .where((element) => element.supplierName
                                  .toString()
                                  .toLowerCase()
                                  .contains(pattern
                                  .toString()
                                  .toLowerCase()))
                                  .take(allSupplierslist.length)
                                  .toList();
                              // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: SizedBox(child: Text("${suggestion.supplierName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected:
                                (AllSuppliersClass suggestion) {
                              supplyerController.text = suggestion.supplierName!;
                              setState(() {
                                _selectedCustomer = suggestion.supplierSlNo;
                                supplierId = suggestion.supplierSlNo.toString();
                              });
                            },
                            onSaved: (value) {},
                          ),
                          // child: FutureBuilder(
                          //   future: Provider.of<CounterProvider>(context, listen: false).getSupplier(context),
                          //   builder: (context,
                          //       AsyncSnapshot<List<AllSuppliersClass>> snapshot) {
                          //     if (snapshot.hasData) {
                          //       return TypeAheadFormField(
                          //         textFieldConfiguration:
                          //         TextFieldConfiguration(
                          //             onChanged: (value){
                          //               if (value == '') {
                          //                 _selectedCustomer = '';
                          //               }
                          //             },
                          //             style: const TextStyle(
                          //               fontSize: 15,
                          //             ),
                          //             controller: supplyerController,
                          //             decoration: InputDecoration(
                          //               hintText: 'Select Supplier',
                          //               suffix: _selectedCustomer == '' ? null : GestureDetector(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     supplyerController.text = '';
                          //                   });
                          //                 },
                          //                 child: const Padding(
                          //                   padding: EdgeInsets.symmetric(horizontal: 3),
                          //                   child: Icon(Icons.close,size: 14,),
                          //                 ),
                          //               ),
                          //             )
                          //         ),
                          //         suggestionsCallback: (pattern) {
                          //           return snapshot.data!
                          //               .where((element) => element.supplierName
                          //               .toString()
                          //               .toLowerCase()
                          //               .contains(pattern
                          //               .toString()
                          //               .toLowerCase()))
                          //               .take(allSupplierslist.length)
                          //               .toList();
                          //           // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                          //         },
                          //         itemBuilder: (context, suggestion) {
                          //           return ListTile(
                          //             title: SizedBox(child: Text("${suggestion.supplierName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                          //           );
                          //         },
                          //         transitionBuilder:
                          //             (context, suggestionsBox, controller) {
                          //           return suggestionsBox;
                          //         },
                          //         onSuggestionSelected:
                          //             (AllSuppliersClass suggestion) {
                          //           supplyerController.text = suggestion.supplierName!;
                          //           setState(() {
                          //             _selectedCustomer =
                          //                 suggestion.supplierSlNo;
                          //              });
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
                            //       'Please select a supplier',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     value: _selectedCustomer,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         supplierId = "$newValue";
                            //         print("Customer Id============$newValue");
                            //         _selectedCustomer = newValue.toString();
                            //         print(
                            //             "dropdown value================$newValue");
                            //       });
                            //     },
                            //     items: allSupplierslist.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.supplierName}",
                            //           style: TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.supplierSlNo,
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
                      Container(
                        child: const Text("To"),
                      ),
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
                        if(supplyerController.text != ''){
                          setState(() {
                            isLoading = true;
                          });
                          Provider.of<SupplierPaymentReportProvider>(context,
                              listen: false)
                              .getSupplierPaymentData(
                            context,
                            "$supplierId",
                            backEndFirstDate,
                            backEndSecondDate,
                          );
                          print('lkjnfgalksfgak ${backEndFirstDate} sdfgsdg${backEndSecondDate}dfgsd${supplierId}');

                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.black,
                              content: Center(child: Text("Please Select Supplier",style: TextStyle(color: Colors.red),))));
                        }
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
                          style: TextStyle(color: Colors.white),
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
