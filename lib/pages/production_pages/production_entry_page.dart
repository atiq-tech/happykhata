import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_shift/Api_all_get_shift.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/custom_finish_product_add_cart.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/custom_material_add_cart.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_employee_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_material_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/const_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import '../../Api_Integration/Api_All_implement/Atik/Api_all_get_employees/Api_all_get_employees.dart';
import '../../Api_Integration/Api_All_implement/Atik/Api_all_get_material/Api_all_get_material.dart';
import '../../Api_Integration/Api_All_implement/Atik/Api_all_get_productions/api_all_get_productions.dart';
import '../../provider/sales_module/sales_record/provider_sales_data.dart';

class ProductionEntryPage extends StatefulWidget {
  const ProductionEntryPage({super.key});

  @override
  State<ProductionEntryPage> createState() => _ProductionEntryPageState();
}

class _ProductionEntryPageState extends State<ProductionEntryPage> {
  List<ProductionApiModelClass> materiallist = [];
  //finish product
  List<FinishProductionApiModelClass> finishproductlist = [];

  final TextEditingController _QuantityMaterialController =
      TextEditingController();
  final TextEditingController _QuantityProductController =
      TextEditingController();
  final TextEditingController _productionIdController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _LaborCostController = TextEditingController();
  final TextEditingController _transportCostController =
      TextEditingController();
  final TextEditingController _otherCostController = TextEditingController();
  final TextEditingController _totalCostController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String? materialname;
  String? catname;
  //finish product
  String? finishproductname;
  // String? inChargeName;
  // String? shiftName;
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

//input number
  int? sum = 0;
  //

  String? _selectedShift;
  String? _selectedMeterial;
  String? _selectedProduct;
  String? _selectedIncharge;

  ApiAllGetMaterial? apiAllGetMaterial;
  ApiAllGetShift? apiAllGetShift;
  ApiAllGetEmployees? apiAllGetEmployees;
  // ApiallGetProductions? apiallGetProduction;

  @override
  void initState() {
    // get materials
    ApiAllGetMaterial apiAllGetMaterial;
    Provider.of<CounterProvider>(context, listen: false).getMaterials(context);
    // get Shifts
    ApiAllGetShift apiAllGetShift;
    Provider.of<CounterProvider>(context, listen: false).getShift(context);
    // get employee //Incharge
    ApiAllGetEmployees apiAllGetEmployees;
    Provider.of<CounterProvider>(context, listen: false).getEmployees(context);
    //GetProductions
    // ApiallGetProductions apiallGetProduction;
    // Provider.of<CounterProvider>(context, listen: false)
    //     .getProductions(context);
    // TODO: implement initState
    _LaborCostController.text = "0";
    _transportCostController.text = "0";
    _otherCostController.text = "0";

    super.initState();
  }

  var materialController = TextEditingController();
  var productController = TextEditingController();
  var inchargeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print("summmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print(sum = int.parse(_LaborCostController.text) +
    //     int.parse(_transportCostController.text) +
    //     int.parse(_otherCostController.text));
    // get materials
    final allGetMaterialsData =
        Provider.of<CounterProvider>(context).allGetMateriallist;
    print(
        "GetMaterial GetMaterial GetMaterial=======Lenght is:::::${allGetMaterialsData.length}");

    // all products list
    final All_Product =
        Provider.of<AllProductProvider>(context).AllProductModelClassList;
    print("All_Product List langth==============>${All_Product.length}");

    // get shifts
    final allGetShiftsData =
        Provider.of<CounterProvider>(context).allGetShiftlist;
    print(
        "GetShifts GetShifts GetShifts======Lenght is::${allGetShiftsData.length}");

    // get shifts
    final allGetEmployeesData =
        Provider.of<CounterProvider>(context).allGetEmployeelist;
    print(
        "GetEmployee GetEmployee GetEmployee======Lenght is::${allGetEmployeesData.length}");

    // GetProductionsData
    // final allGetProductionsData =
    //     Provider.of<CounterProvider>(context).allProductionslist;
    // print(
    //     "Get Productions=====GetProductions======Lenght is::${allGetProductionsData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Production Entry"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              child: Container(
                height: 160.0,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0, left: 10.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                        height: 28.0,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 107, 134, 146),
                        child: const Center(
                            child: Text(
                          "Materials",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ))),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Material :",
                            style: TextStyle(
                                fontSize: 14,
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
                              future: Provider.of<CounterProvider>(context).getMaterials(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllGetMaterialClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          // if (value == '') {
                                          //   categoryId = '';
                                          // }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: materialController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Material',
                                          suffix: _selectedMeterial == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                materialController.text = '';
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
                                          .take(allGetMaterialsData.length)
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
                                        (AllGetMaterialClass suggestion) {
                                          materialController.text = suggestion.displayText!;
                                          setState(() {
                                            _selectedMeterial = suggestion.materialId!.toString();

                                            final results = [
                                              allGetMaterialsData
                                                  .where((m) => m.materialId!.contains(
                                                      '${suggestion.materialId}')) // or Testing 123
                                                  .toList(),
                                            ];
                                            results.forEach((element) async {
                                              element.add(element.first);
                                              print(
                                                  "supplierSlNo  ${element[0].materialId}");
                                              print(
                                                  "supplierMobile  ${element[0].name}");
                                              print(
                                                  "supplierName  ${element[0].categoryId}");
                                              print(
                                                  "supplierAddress  ${element[0].categoryName}");
                                              materialname = "${element[0].name}";
                                              catname = "${element[0].categoryName}";
                                            });
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
                            //     hint: const Text(
                            //       'Select Material',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //
                            //     dropdownColor: const Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedMeterial,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedMeterial = newValue!.toString();
                            //
                            //         final results = [
                            //           allGetMaterialsData
                            //               .where((m) => m.materialId!.contains(
                            //                   '$newValue')) // or Testing 123
                            //               .toList(),
                            //         ];
                            //         results.forEach((element) async {
                            //           element.add(element.first);
                            //           print(
                            //               "supplierSlNo  ${element[0].materialId}");
                            //           print(
                            //               "supplierMobile  ${element[0].name}");
                            //           print(
                            //               "supplierName  ${element[0].categoryId}");
                            //           print(
                            //               "supplierAddress  ${element[0].categoryName}");
                            //           materialname = "${element[0].name}";
                            //           catname = "${element[0].categoryName}";
                            //         });
                            //       });
                            //     },
                            //     items: allGetMaterialsData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.name}",
                            //           style: const TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.materialId,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Quantity :",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _QuantityMaterialController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintText: "Quantity",
                                hintStyle: const TextStyle(fontSize: 14),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            materiallist.add(ProductionApiModelClass(
                                name: materialname,
                                categoryName: catname,
                                quantity: _QuantityMaterialController.text));
                          });
                        },
                        child: Container(
                          height: 35.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 151, 177, 189),
                                width: 1.0),
                            color: const Color.fromARGB(255, 107, 134, 146),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Center(
                              child: Text(
                            "Add to Cart",
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
            const SizedBox(height: 3.0),
            Container(
              height: MediaQuery.of(context).size.height / 4,
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
                      child: DataTable(
                        showCheckboxColumn: true,
                        border:
                            TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          const DataColumn(
                            label: Center(child: Text('SL No.')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Material Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Category')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Quantity')),
                          ),
                        ],
                        rows: List.generate(
                          //allGetMaterialsData.length,
                          materiallist.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text('${index + 1}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text('${materiallist[index].name}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${materiallist[index].categoryName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${materiallist[index].quantity}')),
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
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 160.0,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0, left: 10.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                        height: 28.0,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 107, 134, 146),
                        child: const Center(
                            child: Text(
                          "Finish Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ))),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Product :",
                            style: TextStyle(
                                fontSize: 14,
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
                                          // if (value == '') {
                                          //   categoryId = '';
                                          // }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: productController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Product',
                                          suffix: _selectedProduct == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productController.text = '';
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
                                          .take(All_Product.length)
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
                                          productController.text = suggestion.displayText!;
                                          setState(() {
                                            _selectedProduct = suggestion.productSlNo.toString();
                                            print(
                                                "Product Si No= uzzal=====> ${suggestion.productSlNo}");
                                            final results = [
                                              All_Product.where((m) =>
                                                      m.productSlNo ==
                                                      '${suggestion.productSlNo}') // or Testing 123
                                                  .toList(),
                                            ];

                                            results.forEach((element) async {
                                              element.add(element.first);
                                              print(
                                                  "supplierSlNo uzzal=======  ${element[0].productSlNo}");
                                              print(
                                                  "supplierMobile uzzal ======  ${element[0].productName}");

                                              finishproductname =
                                                  "${element[0].productName}";
                                              // productname = "${element[0].productCategoryName}";
                                            });
                                            print(
                                                "supplierSlNo uzzal=======  ${results}");
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
                            //     hint: const Text(
                            //       'Select Product',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     dropdownColor: const Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedProduct,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedProduct = newValue.toString();
                            //         print(
                            //             "Product Si No= uzzal=====> ${newValue}");
                            //         final results = [
                            //           All_Product.where((m) =>
                            //                   m.productSlNo ==
                            //                   '$newValue') // or Testing 123
                            //               .toList(),
                            //         ];
                            //
                            //         results.forEach((element) async {
                            //           element.add(element.first);
                            //           print(
                            //               "supplierSlNo uzzal=======  ${element[0].productSlNo}");
                            //           print(
                            //               "supplierMobile uzzal ======  ${element[0].productName}");
                            //
                            //           finishproductname =
                            //               "${element[0].productName}";
                            //           // productname = "${element[0].productCategoryName}";
                            //         });
                            //         print(
                            //             "supplierSlNo uzzal=======  ${results}");
                            //       });
                            //     },
                            //     items: All_Product.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.productName}",
                            //           style: const TextStyle(
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
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Quantity :",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _QuantityProductController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintText: "Quantity",
                                hintStyle: const TextStyle(fontSize: 14),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            finishproductlist.add(
                              FinishProductionApiModelClass(
                                  name: finishproductname,
                                  quantity: _QuantityProductController.text),
                            );
                          });
                        },
                        child: Container(
                          height: 35.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 151, 177, 189),
                                width: 1.0),
                            color: const Color.fromARGB(255, 107, 134, 146),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Center(
                              child: Text(
                            "Add to Cart",
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
            const SizedBox(height: 3.0),
            Container(
              height: MediaQuery.of(context).size.height / 4,
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
                            label: Center(child: Text('SL No.')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Product Name')),
                          ),
                          const DataColumn(
                            label: Center(child: Text('Quantity')),
                          ),
                        ],
                        rows: List.generate(
                          finishproductlist.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text('${index + 1}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${finishproductlist[index].name}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${finishproductlist[index].quantity}')),
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
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 400.0,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                        height: 28.0,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 107, 134, 146),
                        child: const Center(
                            child: Text(
                          "Production",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ))),
                    const SizedBox(height: 5.0),
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       flex: 5,
                    //       child: Text(
                    //         "Production Id",
                    //         style: TextStyle(
                    //             color: Color.fromARGB(255, 126, 125, 125)),
                    //       ),
                    //     ),
                    //     const Expanded(flex: 1, child: Text(":")),
                    //     Expanded(
                    //       flex: 11,
                    //       child: Container(
                    //         height: 28.0,
                    //         width: MediaQuery.of(context).size.width / 2,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10.0),
                    //             border: Border.all(
                    //               color: const Color.fromARGB(255, 7, 125, 180),
                    //             )),
                    //         child: TextField(
                    //           controller: _productionIdController,
                    //           // keyboardType: TextInputType,
                    //           decoration: InputDecoration(
                    //             enabled: false,
                    //             border: InputBorder.none,
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color.fromARGB(255, 7, 125, 180),
                    //               ),
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: const BorderSide(
                    //                 color: Color.fromARGB(255, 7, 125, 180),
                    //               ),
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 5,
                              top: 5,
                              bottom: 5,
                            ),
                            height: 30,
                            child: GestureDetector(
                              onTap: (() {
                                _firstSelectedDate();
                              }),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: firstPickedDate == null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                      : firstPickedDate,
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
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "In-charge",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
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
                              future: Provider.of<CounterProvider>(context).getEmployees(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllGetEmployeeClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          if (value == '') {
                                            _selectedIncharge = '';
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: inchargeController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Incharge',
                                          suffix: _selectedIncharge == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                inchargeController.text = '';
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
                                          .where((element) => element.displayName!
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(allGetEmployeesData.length)
                                          .toList();
                                      // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: SizedBox(child: Text("${suggestion.displayName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (AllGetEmployeeClass suggestion) {
                                          inchargeController.text = suggestion.displayName!;
                                      setState(() {
                                        _selectedIncharge = suggestion.employeeSlNo.toString();
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
                            //     hint: const Text(
                            //       'Select Incharge',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     dropdownColor: const Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedIncharge,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedIncharge = newValue!.toString();
                            //       });
                            //     },
                            //     items: allGetEmployeesData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.displayName}",
                            //           style: const TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.employeeSlNo,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Shift",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 5, 107, 155),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: const Text(
                                  'Select Shift',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: const Color.fromARGB(255, 231, 251,
                                    255), // Not necessary for Option 1
                                value: _selectedShift,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedShift = newValue!.toString();
                                  });
                                },
                                items: allGetShiftsData.map((location) {
                                  return DropdownMenuItem(
                                    value: location.name,
                                    child: Text(
                                      "${location.name}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Labour Cost",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              onChanged: (value) {
                                sum = int.parse(value);
                                _totalCostController.text = "${sum}";
                              },
                              controller: _LaborCostController,
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Transport Cost",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              onChanged: (value) {
                                sum = int.parse(_LaborCostController.text) +
                                    int.parse(value);
                                _totalCostController.text = "${sum}";
                              },
                              controller: _transportCostController,
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Other Cost",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              onChanged: (value) {
                                sum = int.parse(_LaborCostController.text) +
                                    int.parse(_transportCostController.text) +
                                    int.parse(value);
                                _totalCostController.text = "${sum}";
                              },
                              controller: _otherCostController,
                              // keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Total Cost",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              //Total Cost text 1
                              controller: _totalCostController,
                              keyboardType: TextInputType.text,
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Note",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _noteController,
                              decoration: InputDecoration(
                                hintText: "Note",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          // Provider.of<CounterProvider>(context, listen: false)
                          //     .getProductions(
                          //         context,
                          //         // "$firstPickedDate",
                          //         // _selectedIncharge,
                          //         // _LaborCostController.text,
                          //         // "${_noteController.text}",
                          //         // _otherCostController.text,
                          //         // "production_id",
                          //         // iitem,
                          //         // _selectedShift,
                          //         // _totalCostController.text,
                          //         // _transportCostController.text
                          //         );
                          print("Button click");
                          _AddProduction(context);
                        },
                        child: Container(
                          height: 35.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 173, 241, 179),
                                width: 2.0),
                            color: const Color.fromARGB(255, 67, 134, 106),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                              child: Text(
                            "SAVE",
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
            // Container(
            //   height: MediaQuery.of(context).size.height / 1.43,
            //   width: double.infinity,
            //   padding: EdgeInsets.only(left: 8.0, right: 8.0),
            //   child: Container(
            //     width: double.infinity,
            //     height: double.infinity,
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Container(
            //           // color: Colors.red,
            //           // padding:EdgeInsets.only(bottom: 16.0),
            //           child: DataTable(
            //             showCheckboxColumn: true,
            //             border:
            //                 TableBorder.all(color: Colors.black54, width: 1),
            //             columns: [
            //               DataColumn(
            //                 label: Center(child: Text('Production Id.')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Date')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Incharge')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Shift')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Total Cost')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Note')),
            //               ),
            //               DataColumn(
            //                 label: Center(child: Text('Transport Cost')),
            //               ),
            //             ],
            //             rows: List.generate(
            //               allGetProductionsData.length,
            //               (int index) => DataRow(
            //                 cells: <DataCell>[
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].productionId}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].date}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].inchargeName}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].shift}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].totalCost}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].note}')),
            //                   ),
            //                   DataCell(
            //                     Center(
            //                         child: Text(
            //                             '${allGetProductionsData[index].transportCost}')),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _AddProduction(context) async {
    String Link = "${BaseUrl}api/v1/addProduction";
    try {
      var response = await Dio().post(Link,
          data: {
            "production": {
              "production_id": "0",
              "production_sl": "PR-3496",
              "date": firstPickedDate == null
            ? DateFormat('yyyy-MM-dd')
                .format(DateTime.now()) : "$firstPickedDate",
              "incharge_id": "$_selectedIncharge",
              "shift": _selectedShift,
              "note": _noteController.text,
              "labour_cost": _LaborCostController.text,
              "transport_cost": _transportCostController.text,
              "other_cost": _otherCostController.text,
              "total_cost": _totalCostController.text,
            },
            "materials": [
              {
                "category_id": "1",
                "category_name": "$catname",
                "code": "M0001",
                "display_text": " 22X35  50 GSM - M0001",
                "material_id": "1",
                "name": "$materialname",
                "purchase_rate": "1100",
                "quantity": _QuantityMaterialController.text,
                "reorder_level": "100",
                "status": "1",
                "status_text": "Active",
                "unit_id": "1",
                "unit_name": "PCS"
              }
            ],
            "products": [
              {
                "category_name": "File",
                "name": "$finishproductname",
                "price": "20.00",
                "product_id": "540",
                "quantity": _QuantityProductController.text
              }
            ]
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      print("AddProduction AddProduction AddProduction:${response.data}");
      print("===========++++++=============");
      print("AddProduction AddProduction AddProduction");
      print("============+++++++++++++++=========");

      var data = jsonDecode(response.data);
      // Provider.of<CounterProvider>(context, listen: false).getProducts(context);
      print("AddProduction AddProduction length is ${data}");
      print("success============> ${data["success"]}");
      print("message =================> ${data["message"]}");
      print("productionId ================>  ${data["productionId"]}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: const Color.fromARGB(255, 4, 108, 156),
          duration: const Duration(seconds: 1), content: Center(child: Text("${data["message"]}"))));
      _noteController.text = "";
      _LaborCostController.text = "";
      _transportCostController.text = "";
      _totalCostController.text = "";
      _otherCostController.text = "";
      _selectedIncharge = "";
      _selectedShift = "";
    } catch (e) {
      print("Something is wrong AddProduction=======:$e");
    }
  }
}
