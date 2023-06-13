import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_product_ledger/api_all_product_ledger.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_products/api_all_products.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/utils/utils.dart';

import 'package:provider/provider.dart';

class ProductLedgerPage extends StatefulWidget {
  const ProductLedgerPage({super.key});

  @override
  State<ProductLedgerPage> createState() => _ProductLedgerPageState();
}

class _ProductLedgerPageState extends State<ProductLedgerPage> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();

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
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
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
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        print("Firstdateee $firstPickedDate");
      });
    }
  }

  String? _selectedType;
  List<String> _selectedTypeList = [
    'Received',
    'Payment',
  ];
  String? _selectedAccount;

  ApiAllProducts? apiAllProducts;
  ApiAllProductLedger? apiAllProductLedger;

  bool isLoading = false;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    //Products
    ApiAllProducts apiAllProducts;
    Provider.of<CounterProvider>(context, listen: false).getProducts(context);

    // TODO: implement initState
    super.initState();
  }

  var productAllController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Products
    final allProductsData =
        Provider.of<CounterProvider>(context).allProductslist;
    print(
        "Product===Product===Product===Product===Lenght is:::::${allProductsData.length}");
    //
    //Product Ledger
    final allProductLedgerData =
        Provider.of<CounterProvider>(context).allProductLedgerlist;
    print(
        "ProductLedgeer===ProductLedger===ProductLedger=Lenght is:::::${allProductLedgerData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Product Ledger"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 150.0,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Product :",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 5, 107, 155),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FutureBuilder(
                              future: Provider.of<AllProductProvider>(context).FetchAllProduct(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllProductModelClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          if (value == '') {
                                            _selectedAccount = '';
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: productAllController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Product',
                                          suffix: _selectedAccount == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productAllController.text = '';
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
                                          .where((element) => element.displayText!
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(allProductsData.length)
                                          .toList();
                                      // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: SizedBox(child: Text("${suggestion.displayText}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (AllProductModelClass suggestion) {
                                      productAllController.text = suggestion.displayText!;
                                      setState(() {
                                        _selectedAccount =
                                            suggestion.productSlNo.toString();

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
                            //       'Select Product',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     dropdownColor: Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedAccount,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedAccount = newValue!.toString();
                            //       });
                            //     },
                            //     items: allProductsData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.productName}",
                            //           style: TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.productSlNo,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Date :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
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
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
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
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
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
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getProductLedger(
                                    context,
                                    "${_selectedAccount}",
                                    "${firstPickedDate}",
                                    "${secondPickedDate}");

                            print(
                                "firstDate product ledger=====::${firstPickedDate}");
                            print(
                                "secondDate ++++++product ledger=====::${secondPickedDate}");
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                        },
                        child: Container(
                          height: 35.0,
                          width: 75.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 75, 196, 201),
                                width: 2.0),
                            color: const Color.fromARGB(255, 87, 113, 170),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Center(
                              child: Text(
                            "Show",
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
            ),
            const SizedBox(height: 10.0),
           isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
              height: MediaQuery.of(context).size.height / 1.43,
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
                        border:
                            TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('Date')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Description')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Rate')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('In Quantity')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Out Quantity')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Stock')),
                          ),
                        ],
                        rows: List.generate(
                          allProductLedgerData.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].date}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].description}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].rate}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].inQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].outQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductLedgerData[index].stock}')),
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
