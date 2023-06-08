import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_material/Api_all_get_material.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_material_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/const_page.dart';
import 'package:poss/home_page.dart';
import 'package:poss/pages/administration_pages/supplier_entry_page.dart';
import 'package:poss/pages/production_pages/material_page.dart';
import 'package:poss/pages/production_pages/supplier_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';

import '../../Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/sales_cart_model_class.dart';

class MeterialPurchasePage extends StatefulWidget {
  const MeterialPurchasePage({super.key});

  @override
  State<MeterialPurchasePage> createState() => _MeterialPurchasePageState();
}

var supplyerController = TextEditingController();
var materialController = TextEditingController();

class _MeterialPurchasePageState extends State<MeterialPurchasePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _VatController = TextEditingController();
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController _matenameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _DiscountController = TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _purcasheRateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

  String? supplierMobile;
  String? supplierAddress;
  String? previousDue;
  //product
  String? M_materialId;
  String? ccategoryName;
  String? M_name;
  //String? csalesRate;
  String? cvat;
  String? cquantity;
  String? ctotal;
  String? M_purchaseRate;
//
  List<MaterialPurchaseModelClass> MaterialPurchaseCartList = [];
//
  double CartTotal = 0;
  double TotalVat = 0;
  double DiccountTotal = 0;
  double TransportTotal = 0;
  double Diccountper = 0;
  double totalDue = 0;
  double totalDueTc = 0;
  double Totaltc = 0;
  double AfteraddVatTotal = 0;
  List<String> salesByList = ['A', 'B', 'C', 'D'];
  List<String> supplierList = [
    'General Supplier',
    'Sabbbir Enterprise',
    'Bulet',
    'Noyon'
  ];
  List<String> categoryList = ['Paper', 'Khata', 'Printing Paper', 'Tissue'];
  List<String> productList = ['Drawing Khata', 'Pencil', 'Notebook', 'Pen'];

  String? _selectedSupplier;
  String? _selectedCategory;
  String? _selectedProduct;
  String level = "Retails";
  String availableStock = "41 reem";
  String? SupplierSlNo;
  double h1TextSize = 16.0;
  double h2TextSize = 12.0;
  //total
  double Total = 0.0;

  bool isVisible = false;
  bool isEnabled = false;

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


  final TextEditingController _DateController = TextEditingController();

  String? _selectedPurchase;
  List<String> _selectedPurchaseList = [
    'Happy Product',
    'Selected Product',
  ];
  String? _selectedAccount;
  ApiAllGetMaterial? apiAllGetMaterial;
  @override
  void initState() {
     _quantityController.text = "1";
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // get materials
    ApiAllGetMaterial apiAllGetMaterial;
    Provider.of<CounterProvider>(context, listen: false).getMaterials(context);
    // TODO: implement initState
     getMaterialInvoice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final All_Supplier = Provider.of<CounterProvider>(context).allSupplierslist;

    print("All_Supplier ===========> ${All_Supplier.length}");
    // get materials
    final allGetMaterialsData =
        Provider.of<CounterProvider>(context).allGetMateriallist;
    print(
        "GetMaterial GetMaterial GetMaterial=======Lenght is:::::${allGetMaterialsData.length}");

    return Scaffold(
      appBar: CustomAppBar(
        title: "Meterial Purchase",
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120.0,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Invoice no",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: const Color.fromARGB(255, 7, 125, 180))),
                            child: TextField(
                              controller: invoiceNoController,
                              decoration: InputDecoration(
                                enabled: false,
                                filled: true,
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
                    Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Purchase For",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
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
                                hint: const Text(
                                  'Selected Product',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: const Color.fromARGB(255, 231, 251,
                                    255), // Not necessary for Option 1
                                value: _selectedPurchase,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedPurchase = newValue!;
                                    getMaterialInvoice();
                                  });
                                },
                                items: _selectedPurchaseList.map((location) {
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Text(
                            "Date",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28,
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
                  ],
                ),
              ),
              Container(
                height: 220.0,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      color: const Color.fromARGB(255, 107, 134, 146),
                      child: const Center(
                        child: Text(
                          'Supplier & Material Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Supplier ID",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, right: 5),
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

                                      // print('General customer ${All_Supplier.length}');
                                      //
                                      // All_Supplier.insert(0, AllSuppliersClass(displayName: "General Customer"));
                                      // print('General customer ${All_Supplier.length}');
                                      //
                                      return snapshot.data!
                                          .where((element) => element.displayName!
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(All_Supplier.length)
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
                                        (AllSuppliersClass suggestion) {
                                      supplyerController.text = suggestion.displayName!;
                                      setState(() {
                                        print("Supplier Si No ======> ${suggestion.supplierSlNo}");
                                        _selectedSupplier = suggestion.supplierSlNo.toString();
                                        SupplierSlNo = suggestion.supplierSlNo.toString();
                                        _selectedSupplier == "General Supplier"
                                            ? isVisible = true
                                            : isVisible = false;
                                        _selectedSupplier == "General Supplier"
                                            ? isEnabled = true
                                            : isEnabled = false;

                                        print(_selectedSupplier);
                                        print(isVisible);
                                        final results = [
                                          All_Supplier.where((m) => m.supplierSlNo!
                                                  .contains(
                                                      '${suggestion.supplierSlNo}')) // or Testing 123
                                              .toList(),
                                        ];
                                        results.forEach((element) {
                                          element.add(element.first);
                                          print("dfhsghdfkhgkh");
                                          print(
                                              "supplierSlNo===> ${element[0].displayName}");
                                          print(
                                              "supplierName===> ${element[0].supplierName}");
                                          supplierMobile =
                                              "${element[0].supplierMobile}";
                                          _mobileNumberController.text =
                                              "${element[0].supplierMobile}";
                                          print(
                                              "supplierMobile===> ${element[0].supplierMobile}");
                                          supplierAddress =
                                              "${element[0].supplierAddress}";
                                          _addressController.text =
                                              "${element[0].supplierAddress}";
                                          print(
                                              "supplierAddress===> ${element[0].supplierAddress}");
                                          previousDue = "${element[0].previousDue}";
                                          _previousDueController.text =
                                              "${element[0].previousDue}";
                                          print(
                                              "previousDue===> ${element[0].previousDue}");
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
                            //       'Select Supplier',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ), // Not necessary for Option 1
                            //     value: _selectedSupplier,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         print("Supplier Si No ======> $newValue");
                            //         _selectedSupplier = newValue.toString();
                            //         SupplierSlNo = newValue.toString();
                            //         _selectedSupplier == "General Supplier"
                            //             ? isVisible = true
                            //             : isVisible = false;
                            //         _selectedSupplier == "General Supplier"
                            //             ? isEnabled = true
                            //             : isEnabled = false;
                            //
                            //         print(_selectedSupplier);
                            //         print(isVisible);
                            //         final results = [
                            //           All_Supplier.where((m) => m.supplierSlNo!
                            //                   .contains(
                            //                       '$newValue')) // or Testing 123
                            //               .toList(),
                            //         ];
                            //         results.forEach((element) {
                            //           element.add(element.first);
                            //           print("dfhsghdfkhgkh");
                            //           print(
                            //               "supplierSlNo===> ${element[0].displayName}");
                            //           print(
                            //               "supplierName===> ${element[0].supplierName}");
                            //           supplierMobile =
                            //               "${element[0].supplierMobile}";
                            //           _mobileNumberController.text =
                            //               "${element[0].supplierMobile}";
                            //           print(
                            //               "supplierMobile===> ${element[0].supplierMobile}");
                            //           supplierAddress =
                            //               "${element[0].supplierAddress}";
                            //           _addressController.text =
                            //               "${element[0].supplierAddress}";
                            //           print(
                            //               "supplierAddress===> ${element[0].supplierAddress}");
                            //           previousDue = "${element[0].previousDue}";
                            //           _previousDueController.text =
                            //               "${element[0].previousDue}";
                            //           print(
                            //               "previousDue===> ${element[0].previousDue}");
                            //         });
                            //       });
                            //     },
                            //     items: All_Supplier.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.displayName}",
                            //           style: const TextStyle(
                            //             overflow: TextOverflow.ellipsis,
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.supplierSlNo,
                            //       );
                            //     }).toList(),
                            //     isExpanded: true,
                            //   ),
                            // ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const SupplierEntryPage()));
                            },
                            child: Container(
                              height: 28.0,
                              margin: const EdgeInsets.only(bottom: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 224, 103, 67),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: const Color.fromARGB(255, 165, 56, 28),
                                      width: 1)),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 28.0,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: TextField(
                                style: const TextStyle(color: Colors.grey),
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
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
                    ),
                    // drop down

                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Mobile No",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                color: Color.fromARGB(255, 139, 139, 139),
                              ),
                              controller: _mobileNumberController,
                              enabled: isEnabled,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isEnabled == true
                                    ? Colors.white
                                    : Colors.grey[200],
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
                    ), // mobile
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Address",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                color: Color.fromARGB(255, 139, 139, 139),
                              ),
                              maxLines: 3,
                              controller: _addressController,
                              enabled: isEnabled,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isEnabled == true
                                    ? Colors.white
                                    : Colors.grey[200],
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 10),
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
                    //address
                  ],
                ),
              ),
              Container(
                height: 210.0,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                padding: const EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Material",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 5, right: 5),
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
                              future: Provider.of<CounterProvider>(context).getMaterials(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllGetMaterialClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          if (value == '') {
                                            _selectedProduct = '';
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: materialController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Material',
                                          suffix: _selectedProduct == '' ? null : GestureDetector(
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
                                        _selectedProduct = suggestion.materialId.toString();
                                        final results = [
                                          allGetMaterialsData
                                              .where((m) => m.materialId!.contains(
                                                  '${suggestion.materialId}')) // or Testing 123
                                              .toList(),
                                        ];
                                        results.forEach((element) async {
                                          element.add(element.first);
                                          print("dfhsghdfkhgkh");
                                          M_materialId = "${element[0].materialId}";
                                          print(
                                              "productSlNo===> ${element[0].materialId}");
                                          ccategoryName =
                                              "${element[0].categoryName}";
                                          print(
                                              "ccategoryName===> ${element[0].categoryName}");
                                          M_name = "${element[0].name}";
                                          print(
                                              "productName===> ${element[0].name}");
                                          _matenameController.text =
                                              "${element[0].name}";
                                          print(
                                              "productName===> ${element[0].name}");

                                          // cvat = "${element[0].vat}";
                                          // print("vat===> ${element[0].vat}");

                                          print(
                                              "_quantityController ===> ${_quantityController.text}");
                                          M_purchaseRate =
                                              "${element[0].purchaseRate}";
                                          print(
                                              "M_purchaseRate===> ${element[0].purchaseRate}");
                                          // _VatController.text = "${element[0].vat}";
                                          _purcasheRateController.text =
                                              "${element[0].purchaseRate}";
                                          Total = (double.parse(
                                                  _quantityController.text) *
                                              double.parse(
                                                  _purcasheRateController.text));
                                          //totalStack(cproductId);
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
                            //         color: Colors.grey,
                            //         fontSize: 14,
                            //       ),
                            //     ), // Not necessary for Option 1
                            //     value: _selectedProduct,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedProduct = newValue.toString();
                            //         final results = [
                            //           allGetMaterialsData
                            //               .where((m) => m.materialId!.contains(
                            //                   '$newValue')) // or Testing 123
                            //               .toList(),
                            //         ];
                            //         results.forEach((element) async {
                            //           element.add(element.first);
                            //           print("dfhsghdfkhgkh");
                            //           M_materialId = "${element[0].materialId}";
                            //           print(
                            //               "productSlNo===> ${element[0].materialId}");
                            //           ccategoryName =
                            //               "${element[0].categoryName}";
                            //           print(
                            //               "ccategoryName===> ${element[0].categoryName}");
                            //           M_name = "${element[0].name}";
                            //           print(
                            //               "productName===> ${element[0].name}");
                            //           _matenameController.text =
                            //               "${element[0].name}";
                            //           print(
                            //               "productName===> ${element[0].name}");
                            //
                            //           // cvat = "${element[0].vat}";
                            //           // print("vat===> ${element[0].vat}");
                            //
                            //           print(
                            //               "_quantityController ===> ${_quantityController.text}");
                            //           M_purchaseRate =
                            //               "${element[0].purchaseRate}";
                            //           print(
                            //               "M_purchaseRate===> ${element[0].purchaseRate}");
                            //           // _VatController.text = "${element[0].vat}";
                            //           _purcasheRateController.text =
                            //               "${element[0].purchaseRate}";
                            //           Total = (double.parse(
                            //                   _quantityController.text) *
                            //               double.parse(
                            //                   _purcasheRateController.text));
                            //           //totalStack(cproductId);
                            //         });
                            //       });
                            //     },
                            //     items: allGetMaterialsData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.name}",
                            //           style: const TextStyle(
                            //             fontSize: 16,
                            //           ),
                            //         ),
                            //         value: location.materialId,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),

                        // Expanded(
                        //   flex: 1,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => MaterialsPage()));
                        //     },
                        //     child: Container(
                        //       height: 28.0,
                        //       margin: EdgeInsets.only(bottom: 5, right: 5),
                        //       decoration: BoxDecoration(
                        //           color: Color.fromARGB(255, 224, 103, 67),
                        //           borderRadius: BorderRadius.circular(5.0),
                        //           border: Border.all(
                        //               color: Color.fromARGB(255, 165, 56, 28),
                        //               width: 1)),
                        //       child: Icon(
                        //         Icons.add,
                        //         color: Colors.white,
                        //         size: 25.0,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ), // product

                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Mate.Name",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                              controller: _matenameController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 5, left: 5),
                                hintText: "Material Name",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                                filled: true,
                                fillColor: Colors.white,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Pur. Rate",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                              controller: _purcasheRateController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                // hintText: "0",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                                filled: true,
                                fillColor: Colors.grey[200],
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
                        const SizedBox(width: 5.0),
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Qty",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(right: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                              controller: _quantityController,
                              onChanged: (value) {
                                setState(() {
                                  Total =
                                      (double.parse(_quantityController.text) *
                                          double.parse(
                                              _purcasheRateController.text));
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                //  hintText: "Quantity",
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                                filled: true,
                                fillColor: Colors.grey[200],
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
                    ), // quantity
                    const SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Total Amount",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, right: 5),
                            height: 30,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                color: const Color.fromARGB(255, 7, 125, 180),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "$Total",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 105, 105, 105),
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 107, 134, 146),
                          ),
                          onPressed: () {
                            setState(() {
                              MaterialPurchaseCartList.add(
                                  MaterialPurchaseModelClass(
                                Mate_productId: "$M_materialId",
                                categoryName: "$M_name",
                                name: "$ccategoryName",
                                purchaseRate: "${_purcasheRateController.text}",
                                vat: "${_VatController.text}",
                                quantity: "${_quantityController.text}",
                                total: "$Total",
                                //purchaseRate: "$cpurchaseRate"
                              ));

                              CartTotal += Total;
                              AfteraddVatTotal = CartTotal;
                              DiccountTotal = AfteraddVatTotal;
                              TransportTotal = DiccountTotal;
                              print("CartTotal ----------------- ${CartTotal}");
                            });
                          },
                          child: const Text("Add to cart")),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const Divider(thickness: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                "SL.",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: Center(
                              child: Text(
                                "Material Name",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Center(
                              child: Text(
                                "Category",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                "Qty.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                "P.Rate",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                "Total",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h2TextSize),
                              ),
                            )),
                      ],
                    ),
                    const Divider(thickness: 2),
                  ],
                ),
              ),
              Container(
                height: 200.0,
                width: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: MaterialPurchaseCartList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.blue[50],
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}.",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${MaterialPurchaseCartList[index].categoryName}",
                                                  style: TextStyle(
                                                    //overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${MaterialPurchaseCartList[index].name}",
                                                  style: TextStyle(
                                                    //overflow: TextOverflow.ellipsis,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${MaterialPurchaseCartList[index].quantity}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${MaterialPurchaseCartList[index].purchaseRate}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${MaterialPurchaseCartList[index].total}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                    fontSize: h2TextSize,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: const Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 107, 134, 146),
                      child: const Center(
                        child: Text(
                          'Amount Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Sub Total",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: const Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$CartTotal",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 126, 126, 126)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Vat",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _VatController,
                              onChanged: (value) {
                                setState(() {
                                  TotalVat = CartTotal *
                                      (double.parse(_VatController.text) / 100);
                                  AfteraddVatTotal = CartTotal + TotalVat;
                                  // DiccountTotal = AfteraddVatTotal;
                                  // TransportTotal = DiccountTotal;
                                  Totaltc = AfteraddVatTotal;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                filled: true,
                                fillColor: Colors.grey[200],
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
                        const Text(
                          "%",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: const Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$TotalVat",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 126, 126, 126)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Tr./L. Cost",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _transportController,
                              onChanged: (value) {
                                setState(() {
                                  TransportTotal = AfteraddVatTotal +
                                      double.parse(_transportController.text);
                                  Totaltc = TransportTotal;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 5, left: 5),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.grey[200],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Discount",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5, right: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _DiscountController,
                              onChanged: (value) {
                                setState(() {
                                  // Diccountper = AfteraddVatTotal *
                                  //     (double.parse(_DiscountController.text) /
                                  //         100);
                                  // _discountPercentController.text =
                                  //     "${Diccountper}";
                                  DiccountTotal =
                                      TransportTotal - double.parse(_DiscountController.text);
                                  Totaltc = DiccountTotal;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                filled: true,
                                fillColor: Colors.grey[200],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Total",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: const Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$Totaltc",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 126, 126, 126)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Paid",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _paidController,
                              onChanged: (value) {
                                setState(() {
                                  // totalDue = DiccountTotal -
                                  //     double.parse(_paidController.text);
                                  totalDueTc = Totaltc -
                                      double.parse(_paidController.text);

                                  // DiccountTotal -=
                                  //     double.parse(_paidController.text);
                                });
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                filled: true,
                                fillColor: Colors.grey[200],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Previous Due",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: const EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 236, 6, 6),
                              ),
                              controller: _previousDueController,
                              //keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                filled: true,
                                fillColor: Colors.white,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Due",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: const Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$totalDueTc",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 126, 126, 126)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              if (DiccountTotal == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Please Add to Cart")));
                              } else {
                                getMaterialInvoice();
                                AddMaterialPurchase();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Sales Successfull"),
                                      actions: [
                                        ActionChip(
                                          label: const Text("Back"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ActionChip(
                                          label: const Text("Home"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(
                                                        name: "",
                                                      ),
                                                ));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                MaterialPurchaseCartList.clear();
                                DiccountTotal = 0;
                              }
                            },
                            child: const Text("Purchase")),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 6, 118, 170),
                            ),
                            onPressed: () {},
                            child: const Text("New Purchase")),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AddMaterialPurchase() async {
    String link = "${BaseUrl}api/v1/addMaterialPurchase";
    try {
      var materialPurchasemap = MaterialPurchaseCartList.map((e) {
        return {
          "material_id": e.Mate_productId,
          "purchase_rate": e.purchaseRate,
          "quantity": e.quantity,
          "total": e.total
        };
      }).toList();
      print(materialPurchasemap);
      Response response = await Dio().post(
        link,
        data: {
          "purchase": {
            "purchase_id": 0,
            "supplier_id": "$SupplierSlNo",
            "invoice_no": "$materialInvoice",
            "purchase_date": firstPickedDate == null
                ? DateFormat('yyyy-MM-dd')
                .format(DateTime.now()):"${firstPickedDate}",
            "purchase_for": 0,
            "sub_total": "$CartTotal",
            "vat": "$TotalVat",
            "transport_cost": _transportController.text,
            "discount": _DiscountController.text,
            "total": "$Totaltc",
            "paid": _paidController.text,
            "due": "$totalDueTc",
            "previous_due": "$previousDue",
            "note": ""
          },
          "purchasedMaterials": materialPurchasemap
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      var mpdata = jsonDecode(response.data);
      print("${mpdata["message"]}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Text("${mpdata["message"]}")));
      _nameController.text = "";
      _paidController.text = "";
      _DiscountController.text = "";
      _mobileNumberController.text = "";
      _addressController.text = "";
      _salesRateController.text = "";
      _VatController.text = "";
      _quantityController.text = "";
      _transportController.text = "";
      DiccountTotal = 0;
      previousDue = "0";
      TotalVat = 0;
      CartTotal = 0;
    } catch (e) {
      print(e);
    }
  }

  //Get materialInvoice
  String? materialInvoice;
  getMaterialInvoice() async {
    String link = "${BaseUrl}api/v1/getMaterialInvoice";
    try {
      Response response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      var materialInvoice = jsonDecode(response.data);
      invoiceNoController.text = materialInvoice;
      print("MaterialInvoice Code===========> $materialInvoice");
    } catch (e) {
      print(e);
    }
  }
}
