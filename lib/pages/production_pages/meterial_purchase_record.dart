import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';

import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_suppliers/api_all_suppliers.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/pages/invoice_screen.dart';
import 'package:poss/provider/providers/counter_provider.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../Api_Integration/Api_All_implement/Atik/Api_all_meterial_purchase_record/Api_all_meterial_purchase_record.dart';

class MeterialPurchaseRecord extends StatefulWidget {
  const MeterialPurchaseRecord({super.key});

  @override
  State<MeterialPurchaseRecord> createState() => _MeterialPurchaseRecordState();
}

class _MeterialPurchaseRecordState extends State<MeterialPurchaseRecord> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();
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
  var supplyerController = TextEditingController();

  bool isSupplierListClicked = false;
  String? _searchType;

  List<String> _searchTypeList = [
    'All',
    'By Supplier',
  ];
//
  bool isLoading = false; //for loading circulerprogressindicator

  String? _selectedSupplier;

  ApiAllSuppliers? apiAllSuppliers;
  ApiAllMeterialPurchase? apiAllMeterialPurchase;
  @override
  void initState() {
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    ApiAllSuppliers apiAllSuppliers;
    Provider.of<CounterProvider>(context, listen: false).getSupplier(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Suppliers
    final allSuppliersData =
        Provider.of<CounterProvider>(context).allSupplierslist;
    print("ssssssssssssssssssssssssssssssssssssss${allSuppliersData.length}");
    //get Meterial Purchase
    final allMeterialPurchaseData =
        Provider.of<CounterProvider>(context).allPurchaseslist;
    print(
        "Meterial +++Purchase +++=Lenght is:::::${allMeterialPurchaseData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Meterial Purchase Record"),
      body: Container(
        padding: EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 210.0,
                width: double.infinity,
                padding: EdgeInsets.only(top: 6.0, left: 10.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Search Type",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 30.0,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 5, 107, 155),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(
                                    'All',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  dropdownColor: Color.fromARGB(255, 231, 251,
                                      255), // Not necessary for Option 1
                                  value: _searchType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _searchType = newValue!;
                                      _selectedSupplier=null;
                                      if (_searchType == "By Supplier") {

                                        isSupplierListClicked = true;
                                      } else {
                                        isSupplierListClicked = false;
                                      }
                                    });
                                  },
                                  items: _searchTypeList.map((location) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        maxLines: 1,
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    isSupplierListClicked == true
                        ? Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Supplier",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 126, 125, 125)),
                                  ),
                                ),
                                Expanded(flex: 1, child: Text(":")),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    height: 38.0,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(255, 5, 107, 155),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: FutureBuilder(
                                      future: Provider.of<CounterProvider>(context, listen: false).getSupplier(context),
                                      builder: (context,
                                          AsyncSnapshot<List<AllSuppliersClass>> snapshot) {
                                        if (snapshot.hasData) {
                                          return TypeAheadFormField(
                                            textFieldConfiguration:
                                            TextFieldConfiguration(
                                                onChanged: (value){
                                                  if (value == '') {
                                                    _selectedSupplier = '';
                                                  }
                                                },
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                                controller: supplyerController,
                                                decoration: InputDecoration(
                                                  hintText: 'Select Supplier',
                                                  suffix: _selectedSupplier == '' ? null : GestureDetector(
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
                                              return snapshot.data!
                                                  .where((element) => element.supplierName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(pattern
                                                  .toString()
                                                  .toLowerCase()))
                                                  .take(allSuppliersData.length)
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
                                                _selectedSupplier =
                                                    suggestion.supplierSlNo;
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
                                    //       'Select Supplier',
                                    //       style: TextStyle(
                                    //         fontSize: 14,
                                    //       ),
                                    //     ),
                                    //     dropdownColor: Color.fromARGB(
                                    //         255,
                                    //         231,
                                    //         251,
                                    //         255), // Not necessary for Option 1
                                    //     value: _selectedSupplier,
                                    //     onChanged: (newValue) {
                                    //       setState(() {
                                    //         _selectedSupplier =
                                    //             newValue.toString();
                                    //       });
                                    //     },
                                    //     items: allSuppliersData.map((location) {
                                    //       return DropdownMenuItem(
                                    //         child: Text(
                                    //           overflow: TextOverflow.visible,
                                    //           maxLines: 1,
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
                          )
                        : Container(),
                    SizedBox(height: 6.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Date From",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 35,
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
                                  fillColor: Colors.blue[50],
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
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
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Date To",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 35,
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
                                  fillColor: Colors.blue[50],
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
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
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getMeterialPurchase(
                                    context,
                                    "${firstPickedDate}",
                                    "${secondPickedDate}",
                                    _selectedSupplier??''
                                    );
                            print(
                                "firstDate Meterial purchase Record=====::${firstPickedDate}");
                            print(
                                "secondDate ++++++Meterial purchase Record=====::${secondPickedDate}");
                            print(
                                "firstDate Meterial purchase Record=====::${_selectedSupplier}");

                          });
                          Future.delayed(Duration(seconds: 3), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Container(
                          height: 35.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 75, 196, 201),
                                width: 2.0),
                            color: Color.fromARGB(255, 87, 113, 170),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                              child: Text(
                            "Search",
                            style: TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.43,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: DataTable(
                                    showCheckboxColumn: true,
                                    border: TableBorder.all(
                                        color: Colors.black54, width: 1),
                                    columns: [
                                      DataColumn(
                                        label: Center(child: Text('Invoice No.')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Date')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Supplier Id')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Supplier Name')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Sub Total')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('VAT')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Total')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Paid')),
                                      ),
                                      DataColumn(
                                        label: Center(child: Text('Due')),
                                      ),
                                      // DataColumn(
                                      //   label: Center(child: Text('Action')),
                                      // ),
                                    ],
                                    rows: List.generate(
                                      allMeterialPurchaseData.length,
                                      (int index) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].invoiceNo}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].purchaseDate}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].supplierCode}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].supplierName}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].subTotal}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].vat}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].total}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].paid}')),
                                          ),
                                          DataCell(
                                            Center(
                                                child: Text(
                                                    '${allMeterialPurchaseData[index].due}')),
                                          ),
                                          // DataCell(
                                          //   Row(
                                          //     children: [
                                          //       GestureDetector(child: Icon(Icons.save),onTap: () {
                                          //         Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicePage(id: "${allMeterialPurchaseData[index].invoiceNo}".substring("${allMeterialPurchaseData[index].invoiceNo}".indexOf('-')).replaceAll('-', '')),));
                                          //       },),
                                          //       GestureDetector(child: Icon(Icons.delete)),
                                          //     ],
                                          //   )
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    const Text(//5555555
                                      "Total Ammount        :  ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    allMeterialPurchaseData
                                        .length ==
                                        0
                                        ? const Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 14),
                                    )
                                        : Text(
                                      "${GetStorage().read("totalTotal")}",
                                      style: const TextStyle(
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(//6666666
                                      "Total Paid                  :  ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    allMeterialPurchaseData
                                        .length ==
                                        0
                                        ? const Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 14),
                                    )
                                        : Text(
                                      "${GetStorage().read("totalPaid")}",
                                      style: const TextStyle(
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                Row(

                                  children: [
                                    const Text(//77777777
                                      "Total Due                   :  ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    allMeterialPurchaseData
                                        .length ==
                                        0
                                        ? const Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 14),
                                    )
                                        : Text(
                                      "${GetStorage().read("totalDue")}",
                                      style: const TextStyle(
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
