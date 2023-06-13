import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/category_wise_stock_model.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../Api_Integration/Api_All_implement/Atik/Api_all_products/api_all_products.dart';
import '../../common_widget/custom_appbar.dart';

class PurchaseRecord extends StatefulWidget {
  const PurchaseRecord({super.key});

  @override
  State<PurchaseRecord> createState() => _PurchaseRecordState();
}

class _PurchaseRecordState extends State<PurchaseRecord> {
  //main dropdowns logic
  bool isAllTypeClicked = true;
  bool isCategoryWiseClicked = false;
  bool isQuantityWiseClicked = false;
  bool isUserWiseClicked = false;

  //sub dropdowns logic
  bool isWithoutDetailsClicked = true;
  bool isWithDetailsClicked = false;

  // dropdown value
  String? userFullName;
  String? _selectedSearchTypes = "All";
  String? _selectedRecordTypes = "Without Details";
  String? _selectedCustomerTypes;
  String? _selectedQuantityProductTypes;
  String? _selectedQuantitySupplierTypes;
  String? _selectedUserTypes;
//my work value
  String? isService;
  String? categoryId;
  //
  String data = 'showAllWithoutDetails';

  //all the dropdown lists
  List<String> _searchTypes = [
    'All',
    'By Category',
    'By Quantity',
    'By User',
  ];
  List<String> _recordType = [
    'Without Details',
    'With Details',
  ];

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

  var categoryController = TextEditingController();
  var supplyerController = TextEditingController();
  var productAllController = TextEditingController();

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
  ApiAllProducts? apiAllProducts;
  @override
  void initState() {
    Provider.of<CounterProvider>(context, listen: false).getProducts(context);
    Provider.of<AllProductProvider>(context, listen: false)
        .Purchases_All_Provider(context);
    //firstPickedDate = "2000-03-23";
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Purchases
    final allGetPurchasesData = Provider.of<CounterProvider>(context).getPurchasesslist;
    print("Get Sales length=====> ${allGetPurchasesData.length} ");
    final All_Purchase_list =
        Provider.of<AllProductProvider>(context).PurchasesList;
    final All_Actegory_List = Provider.of<CategoryWiseStockProvider>(context)
        .provideCategoryWiseStockList;
    final allSupplierslist =
        Provider.of<CounterProvider>(context).allSupplierslist;
    //ge products
    final AllGetProducts =
        Provider.of<CounterProvider>(context).allProductslist;
    //
    final All_User_List = Provider.of<AllProductProvider>(context).Datalistt;
    final UserWisePurchaseslist =
        Provider.of<AllProductProvider>(context).UserWisePurchasesList;

    //get purchase record
    final allPurchaseRecordData =
        Provider.of<CounterProvider>(context).getPurchaseRecordList;
    //Get PurchaseDetails
    final allPurchaseDetailsData =
        Provider.of<CounterProvider>(context).getPurchaseDetailslist;
    print(
        "AllPurchaseDetailsData ==allPurchaseDetailsData=====Lenght is:::::${allPurchaseDetailsData.length}");
    print("All_Purchase_list=================> ${All_Purchase_list.length}");
    print("All_Suppliers_list=================> ${allSupplierslist.length}");
    print("All_User_list=================> ${All_User_List.length}");
    print(
        "User Wise Purchase list=================> ${UserWisePurchaseslist.length}");
    print(
        "GetPurchaseRecordData list=================> ${allPurchaseRecordData.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Purchase Record"),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Search Type:",
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
                                  'All',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedSearchTypes,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSearchTypes = newValue!;
                                    // _selectedSearchTypes == "All"
                                    //     ? data = "showAllWithoutDetails"
                                    //     : "";
                                    _selectedSearchTypes == "All"
                                        ?isAllTypeClicked = true
                                        :isAllTypeClicked = false;

                                    _selectedSearchTypes == "By Category"
                                        ? isCategoryWiseClicked = true
                                        : isCategoryWiseClicked = false;

                                    _selectedSearchTypes == "By Quantity"
                                        ? isQuantityWiseClicked = true
                                        : isQuantityWiseClicked = false;

                                    _selectedSearchTypes == "By User"
                                        ? isUserWiseClicked = true
                                        : isUserWiseClicked = false;
                                  });
                                },
                                items: _searchTypes.map((location) {
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
                            )),
                      ),
                    ],
                  ),
                ),
                isAllTypeClicked == true
                    ? Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Record Type:",
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
                              isExpanded: true,
                              hint: const Text(
                                'Please select a record type',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ), // Not necessary for Option 1
                              value: _selectedRecordTypes,
                              onChanged: (newValue) {
                                print('Seletcted value $_selectedRecordTypes');
                                setState(() {
                                  _selectedRecordTypes = newValue!;
                                  _selectedRecordTypes ==
                                      "Without Details"
                                      ? isWithoutDetailsClicked = true
                                      : isWithoutDetailsClicked = false;
                                  _selectedRecordTypes == "With Details"
                                      ? isWithDetailsClicked = true
                                      : isWithDetailsClicked = false;
                                });
                              },
                              items: _recordType.map((location) {
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
                          )),
                    ),
                  ],
                )
                    : Container(),

                isCategoryWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Category:",
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
                                  child: FutureBuilder(
                                    future: Provider.of<CategoryWiseStockProvider>(context).getCategoryWiseStockData(context),
                                    builder: (context,
                                        AsyncSnapshot<List<CategoryWiseStockModel>> snapshot) {
                                      if (snapshot.hasData) {
                                        return TypeAheadFormField(
                                          textFieldConfiguration:
                                          TextFieldConfiguration(
                                              onChanged: (value){
                                                if (value == '') {
                                                  categoryId = '';
                                                }
                                              },
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              controller: categoryController,
                                              decoration: InputDecoration(
                                                hintText: 'Select Category',
                                                suffix: categoryId == '' ? null : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      categoryController.text = '';
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
                                                .where((element) => element.productCategoryName!
                                                .toLowerCase()
                                                .contains(pattern
                                                .toString()
                                                .toLowerCase()))
                                                .take(All_Actegory_List.length)
                                                .toList();
                                            // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                          },
                                          itemBuilder: (context, suggestion) {
                                            return ListTile(
                                              title: SizedBox(child: Text("${suggestion.productCategoryName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                            );
                                          },
                                          transitionBuilder:
                                              (context, suggestionsBox, controller) {
                                            return suggestionsBox;
                                          },
                                          onSuggestionSelected:
                                              (CategoryWiseStockModel suggestion) {
                                            categoryController.text = suggestion.productCategoryName!;
                                            setState(() {
                                              _selectedCustomerTypes = suggestion.productCategorySlNo.toString();
                                              print('Category id is $_selectedCustomerTypes');
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
                                  //       'Please select a Category',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ), // Not necessary for Option 1
                                  //     value: _selectedCustomerTypes,
                                  //     onChanged: (newValue) {
                                  //       setState(() {
                                  //         _selectedCustomerTypes =
                                  //             newValue.toString();
                                  //
                                  //         print(
                                  //             "Category Si No ==== > ${newValue}");
                                  //       });
                                  //     },
                                  //     items: All_Actegory_List.map((location) {
                                  //       return DropdownMenuItem(
                                  //         child: Text(
                                  //           "${location.productCategoryName}",
                                  //           style: TextStyle(
                                  //             fontSize: 14,
                                  //           ),
                                  //         ),
                                  //         value: location.productCategorySlNo,
                                  //       );
                                  //     }).toList(),
                                  //   ),
                                  // ),
                                ),
                              )
                            ],
                          ), // Employee
                        ],
                      )
                    : Container(),
                isQuantityWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  _selectedQuantitySupplierTypes = '';
                                                }
                                              },
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              controller: supplyerController,
                                              decoration: InputDecoration(
                                                hintText: 'Select Supplier',
                                                suffix: _selectedQuantitySupplierTypes == '' ? null : GestureDetector(
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
                                                .where((element) => element.displayName!
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
                                              _selectedQuantitySupplierTypes =
                                                  suggestion.supplierSlNo;
                                              print(
                                                  "Customer Wise Category ID ========== > ${suggestion.supplierSlNo} ");
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
                                  //       'Please select a Supplier',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ), // Not necessary for Option 1
                                  //     value: _selectedQuantitySupplierTypes,
                                  //     onChanged: (newValue) {
                                  //       setState(() {
                                  //         _selectedQuantitySupplierTypes =
                                  //             newValue.toString();
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
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Product:",
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
                                                  _selectedQuantityProductTypes = '';
                                                }
                                              },
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              controller: productAllController,
                                              decoration: InputDecoration(
                                                hintText: 'Select Product',
                                                suffix: _selectedQuantityProductTypes == '' ? null : GestureDetector(
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
                                                .where((element) => element.productName!
                                                .toLowerCase()
                                                .contains(pattern
                                                .toString()
                                                .toLowerCase()))
                                                .take(AllGetProducts.length)
                                                .toList();
                                            // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                          },
                                          itemBuilder: (context, suggestion) {
                                            return ListTile(
                                              title: SizedBox(child: Text("${suggestion.productName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                            );
                                          },
                                          transitionBuilder:
                                              (context, suggestionsBox, controller) {
                                            return suggestionsBox;
                                          },
                                          onSuggestionSelected:
                                              (AllProductModelClass suggestion) {
                                            productAllController.text = suggestion.productName!;
                                            setState(() {
                                              _selectedQuantityProductTypes =
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
                                  //     hint: Text(
                                  //       'Please select a Product',
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //       ),
                                  //     ), // Not necessary for Option 1
                                  //     value: _selectedQuantityProductTypes,
                                  //     onChanged: (newValue) {
                                  //       setState(() {
                                  //         _selectedQuantityProductTypes =
                                  //             newValue!.toString();
                                  //       });
                                  //     },
                                  //     items: AllGetProducts.map((location) {
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
                                  //     isExpanded: true,
                                  //   ),
                                  // ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Container(),
                isUserWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "User:",
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
                                      isExpanded: true,
                                      hint: const Text(
                                        'Please select a User',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedUserTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedUserTypes =
                                              newValue.toString();
                                          userFullName = "$newValue";
                                          print(
                                              "User Full name No =====> $userFullName");
                                          print(
                                              "User Full name No =====> $firstPickedDate");
                                          print(
                                              "User Full name No =====> $secondPickedDate");
                                          Provider.of<AllProductProvider>(
                                                  context,
                                                  listen: false)
                                              .GetUserWisePurchase(
                                                  userFullName,
                                              backEndFirstDate,
                                                  backEndSecondDate);
                                        });
                                      },
                                      items: All_User_List.map((location) {
                                        return DropdownMenuItem(
                                          value: location.fullName,
                                          child: Text(
                                            "${location.fullName}",
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
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Record Type:",
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
                                          'Please select a record type',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ), // Not necessary for Option 1
                                        value: _selectedRecordTypes,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedRecordTypes = newValue!;
                                            _selectedRecordTypes ==
                                                    "Without Details"
                                                ? isWithoutDetailsClicked = true
                                                : isWithoutDetailsClicked =
                                                    false;
                                            _selectedRecordTypes ==
                                                    "With Details"
                                                ? isWithDetailsClicked = true
                                                : isWithDetailsClicked = false;
                                          });
                                        },
                                        items: _recordType.map((location) {
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
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
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
                    color: const Color.fromARGB(255, 3, 91, 150),
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });

                        setState(() {
                          // AllType
                          print(" dsafasfasfasdfasdf$isAllTypeClicked && $isWithoutDetailsClicked");

                          if (isAllTypeClicked && isWithoutDetailsClicked) {
                            print(" dsafasfasfasdfasdf$isAllTypeClicked && $isWithoutDetailsClicked");
                            data = 'showAllWithoutDetails';
                            print("date 1st $backEndFirstDate");
                            Provider.of<CounterProvider>(context,listen: false)
                                .getPurchasess(
                                context,
                               "$backEndFirstDate",
                                "$backEndSecondDate",
                                "");
                          } else if (isAllTypeClicked && isWithDetailsClicked) {
                            data = 'showAllWithDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseRecord(
                              context,
                              "$backEndFirstDate",
                              "$backEndSecondDate",
                              "",
                            );
                          }

                          // By Category
                          else if (isCategoryWiseClicked) {
                            data = 'showByCategoryDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseDetails(
                                    context,
                                    "$_selectedCustomerTypes",
                                    "$backEndFirstDate",
                                    "$backEndSecondDate",
                                    "",
                                    "");
                          }
                          // By Quantity
                          else if (isQuantityWiseClicked) {
                            data = 'showByQuantityDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseDetails(
                                    context,
                                    "",
                                    "$backEndFirstDate",
                                    "$backEndSecondDate",
                                    "$_selectedQuantityProductTypes",
                                    "$_selectedQuantitySupplierTypes");
                          }

                          // By User
                          else if (isUserWiseClicked &&
                              isWithoutDetailsClicked) {
                            data = 'showByUserWithoutDetails';
                            Provider.of<AllProductProvider>(context,
                                    listen: false)
                                .GetUserWisePurchase(userFullName,
                                backEndFirstDate, backEndSecondDate);
                          } else if (isUserWiseClicked &&
                              isWithDetailsClicked) {
                            data = 'showByUserWithDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseRecord(
                              context,
                              "$backEndFirstDate",
                              "$backEndSecondDate",
                              "$_selectedUserTypes",
                            );
                          }
                        });
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Container(
                        height: 30.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 4, 113, 185),
                          borderRadius: BorderRadius.circular(3.0),
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
          data == 'showAllWithoutDetails'
              ? Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
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
                                    // color: Colors.red,
                                    // padding:EdgeInsets.only(bottom: 16.0),
                                    child: DataTable(
                                      showCheckboxColumn: true,
                                      border: TableBorder.all(
                                          color: Colors.black54, width: 1),
                                      columns: const [
                                        DataColumn(
                                          label: Center(child: Text('Invoice No')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Date')),
                                        ),
                                        DataColumn(
                                          label:
                                              Center(child: Text('Supplier Name')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Sub Total')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Discount')),
                                        ),
                                        DataColumn(
                                          label:
                                              Center(child: Text('Transport Cost')),
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

                                      ],
                                      rows: List.generate(
                                        allGetPurchasesData.length,
                                        (int index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterInvoiceNo}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterOrderDate}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].supplierName}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterSubTotalAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterTax}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterDiscountAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterFreight}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterTotalAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetPurchasesData[index].purchaseMasterPaidAmount}')),
                                            ),
                                            // DataCell(
                                            //   Center(child: Text('Action')),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0 ,bottom: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(//111111
                                              "Sub Total              :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
                                                .length ==
                                                0
                                                ? const Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 14),
                                            )
                                                : Text(
                                              "${GetStorage().read("totalSalesSubtotal")}",
                                              style: const TextStyle(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(//2222
                                              "Total Vat               :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
                                                .length ==
                                                0
                                                ? const Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 14),
                                            )
                                                : Text(
                                              "${GetStorage().read("totalVat")}",
                                              style: const TextStyle(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(//3333333333
                                              "Total Discount     :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
                                                .length ==
                                                0
                                                ? const Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 14),
                                            )
                                                : Text(
                                              "${GetStorage().read("totalDiscount")}",
                                              style: const TextStyle(
                                                  fontSize:14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(//4444444
                                              "Total Trans.Cost  :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
                                                .length ==
                                                0
                                                ? const Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 14),
                                            )
                                                : Text(
                                              "${GetStorage().read("totalTransCost")}",
                                              style: const TextStyle(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(//5555555
                                              "Total                      :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
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
                                              "Total Paid             :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
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
                                              "Total Due              :  ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            allGetPurchasesData
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
                                ],
                              ),
                            ),
                          ),
                        ),
                )
          :data == 'showAllWithDetails' ? Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
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
                      columns: const [
                        DataColumn(
                          label: Center(
                              child:
                              Text('Invoice No')),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('Date')),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text(
                                  'Supplier Name')),
                        ),
                        DataColumn(
                          label: Center(
                              child:
                              Text('Product Name')),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('Price')),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('Quantity')),
                        ),
                        DataColumn(
                          label: Center(
                              child: Text('Total')),
                        ),
                        // DataColumn(
                        //   label: Center(child: Text('Action')),
                        // ),
                      ],
                      rows: List.generate(
                        allPurchaseRecordData.length,
                            (int index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Center(
                                  child: Text(
                                      '${allPurchaseRecordData[index].purchaseMasterInvoiceNo}')),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                      '${allPurchaseRecordData[index].purchaseMasterOrderDate}')),
                            ),
                            DataCell(
                              Center(
                                  child: Text(
                                      '${allPurchaseRecordData[index].supplierName}')),
                            ),
                            DataCell(
                              Center(
                                  child: SizedBox(
                                    // color: Colors.green,
                                    width: MediaQuery.of(
                                        context)
                                        .size
                                        .width *
                                        0.5,
                                    child: ListView.builder(
                                      scrollDirection:
                                      Axis.vertical,
                                      itemCount:
                                      allPurchaseRecordData[
                                      index]
                                          .purchaseDetails!
                                          .length,
                                      itemBuilder:
                                          (context, j) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                  0.1,
                                                  color: Colors
                                                      .black)),
                                          child: Center(
                                            child: Text(
                                                "${allPurchaseRecordData[index].purchaseDetails![j].productName}"),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ),
                            DataCell(
                              Center(
                                  child: SizedBox(
                                    // color: Colors.green,
                                    width: MediaQuery.of(
                                        context)
                                        .size
                                        .width *
                                        0.5,
                                    child: ListView.builder(
                                      scrollDirection:
                                      Axis.vertical,
                                      itemCount:
                                      allPurchaseRecordData[
                                      index]
                                          .purchaseDetails!
                                          .length,
                                      itemBuilder:
                                          (context, j) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                  0.1,
                                                  color: Colors
                                                      .black)),
                                          child: Center(
                                            child: Text(
                                                "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsRate}"),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ),
                            DataCell(
                              Center(
                                  child: SizedBox(
                                    // color: Colors.green,
                                    width: MediaQuery.of(
                                        context)
                                        .size
                                        .width *
                                        0.5,
                                    child: ListView.builder(
                                      scrollDirection:
                                      Axis.vertical,
                                      itemCount:
                                      allPurchaseRecordData[
                                      index]
                                          .purchaseDetails!
                                          .length,
                                      itemBuilder:
                                          (context, j) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                  0.1,
                                                  color: Colors
                                                      .black)),
                                          child: Center(
                                            child: Text(
                                                "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsTotalQuantity}"),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ),
                            DataCell(
                              Center(
                                  child: SizedBox(
                                    // color: Colors.green,
                                    width: MediaQuery.of(
                                        context)
                                        .size
                                        .width *
                                        0.5,
                                    child: ListView.builder(
                                      scrollDirection:
                                      Axis.vertical,
                                      itemCount:
                                      allPurchaseRecordData[
                                      index]
                                          .purchaseDetails!
                                          .length,
                                      itemBuilder:
                                          (context, j) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width:
                                                  0.1,
                                                  color: Colors
                                                      .black)),
                                          child: Center(
                                            child: Text(
                                                "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsTotalAmount}"),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                            ),
                            // DataCell(
                            //   Center(child: Text('Action')),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
              : data == 'showByCategoryDetails'
                  ? Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: DataTable(
                                          showCheckboxColumn: true,
                                          border: TableBorder.all(
                                              color: Colors.black54, width: 1),
                                          columns: const [
                                            DataColumn(
                                              label:
                                                  Center(child: Text('Invoice No')),
                                            ),
                                            DataColumn(
                                              label: Center(child: Text('Date')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Supplier Name')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Product Name')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Purchases  Rate')),
                                            ),
                                            DataColumn(
                                              label:
                                                  Center(child: Text('Quantity')),
                                            ),
                                          ],
                                          rows: List.generate(
                                            allPurchaseDetailsData.length,
                                            (int index) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].purchaseMasterInvoiceNo}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].purchaseMasterOrderDate}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].supplierName}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].productName}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].purchaseDetailsRate}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allPurchaseDetailsData[index].purchaseDetailsTotalQuantity}')),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 700.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "Total Quantity :  ",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              allPurchaseDetailsData
                                                  .length ==
                                                  0
                                                  ? const Text(
                                                "0",
                                                style: TextStyle(
                                                    fontSize: 14),
                                              )
                                                  : Text(
                                                "${GetStorage().read("totalQuantity")}",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    )
                  : data == 'showByQuantityDetails'
                      ? Expanded(
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: DataTable(
                                              showCheckboxColumn: true,
                                              border: TableBorder.all(
                                                  color: Colors.black54, width: 1),
                                              columns: const [
                                                DataColumn(
                                                  label: Center(
                                                      child: Text('Invoice No')),
                                                ),
                                                DataColumn(
                                                  label:
                                                      Center(child: Text('Date')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child: Text('Supplier Name')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child: Text('Product Name')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child:
                                                          Text('Purchases Rate')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child: Text('Quantity')),
                                                ),
                                              ],
                                              rows: List.generate(
                                                allPurchaseDetailsData.length,
                                                (int index) => DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].purchaseMasterInvoiceNo}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].purchaseMasterOrderDate}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].supplierName}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].productName}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].purchaseDetailsRate}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allPurchaseDetailsData[index].purchaseDetailsTotalQuantity}')),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 600.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "Total Quantity :  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                                allPurchaseDetailsData
                                                    .length ==
                                                    0
                                                    ? const Text(
                                                  "0",
                                                  style: TextStyle(
                                                      fontSize: 14),
                                                )
                                                    : Text(
                                                  "${GetStorage().read("totalQuantity")}",
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : data == 'showByUserWithoutDetails'
                          ? Expanded(
                              child: isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                DataTable(
                                                  showCheckboxColumn: true,
                                                  border: TableBorder.all(
                                                      color: Colors.black54,
                                                      width: 1),
                                                  columns: const [
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Invoice No')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Date')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Supplier Name')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Sub Total')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child:
                                                              Text('Discount')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Transport Cost')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Total')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Paid')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Due')),
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    UserWisePurchaseslist
                                                        .length,
                                                    (int index) => DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterInvoiceNo}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterOrderDate}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].supplierName}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterSubTotalAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterTax}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterDiscountAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterFreight}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterTotalAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${UserWisePurchaseslist[index].purchaseMasterPaidAmount}')),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0 ,bottom: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(//111111
                                                            "Sub Total              :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
                                                              .length ==
                                                              0
                                                              ? const Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          )
                                                              : Text(
                                                            "${GetStorage().read("totalSalesSubtotal")}",
                                                            style: const TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(//2222
                                                            "Total Vat               :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
                                                              .length ==
                                                              0
                                                              ? const Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          )
                                                              : Text(
                                                            "${GetStorage().read("totalVat")}",
                                                            style: const TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(//3333333333
                                                            "Total Discount     :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
                                                              .length ==
                                                              0
                                                              ? const Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          )
                                                              : Text(
                                                            "${GetStorage().read("totalDiscount")}",
                                                            style: const TextStyle(
                                                                fontSize:14),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(//4444444
                                                            "Total Trans.Cost  :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
                                                              .length ==
                                                              0
                                                              ? const Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          )
                                                              : Text(
                                                            "${GetStorage().read("totalTransCost")}",
                                                            style: const TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(//5555555
                                                            "Total                      :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
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
                                                            "Total Paid             :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
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
                                                            "Total Due              :  ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 14),
                                                          ),
                                                          UserWisePurchaseslist
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          : data == 'showByUserWithDetails'
                              ? Expanded(
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Container(
                                                child: DataTable(
                                                  showCheckboxColumn: true,
                                                  border: TableBorder.all(
                                                      color: Colors.black54,
                                                      width: 1),
                                                  columns: const [
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Invoice No')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Date')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Supplier Name')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Product Name')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Price')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child:
                                                              Text('Quantity')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Total')),
                                                    ),
                                                  ],
                                                  rows: List.generate(
                                                    allPurchaseRecordData
                                                        .length,
                                                    (int index) => DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseMasterInvoiceNo}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseMasterOrderDate}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].supplierName}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: SizedBox(
                                                                // color: Colors.green,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.5,
                                                                child: ListView.builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount:
                                                                  allPurchaseRecordData[
                                                                  index]
                                                                      .purchaseDetails!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context, j) {
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width:
                                                                              0.1,
                                                                              color: Colors
                                                                                  .black)),
                                                                      child: Center(
                                                                        child: Text(
                                                                            "${allPurchaseRecordData[index].purchaseDetails![j].productName}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: SizedBox(
                                                                // color: Colors.green,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.5,
                                                                child: ListView.builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount:
                                                                  allPurchaseRecordData[
                                                                  index]
                                                                      .purchaseDetails!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context, j) {
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width:
                                                                              0.1,
                                                                              color: Colors
                                                                                  .black)),
                                                                      child: Center(
                                                                        child: Text(
                                                                            "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsRate}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: SizedBox(
                                                                // color: Colors.green,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.5,
                                                                child: ListView.builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount:
                                                                  allPurchaseRecordData[
                                                                  index]
                                                                      .purchaseDetails!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context, j) {
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width:
                                                                              0.1,
                                                                              color: Colors
                                                                                  .black)),
                                                                      child: Center(
                                                                        child: Text(
                                                                            "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsTotalQuantity}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: SizedBox(
                                                                // color: Colors.green,
                                                                width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.5,
                                                                child: ListView.builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount:
                                                                  allPurchaseRecordData[
                                                                  index]
                                                                      .purchaseDetails!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context, j) {
                                                                    return Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              width:
                                                                              0.1,
                                                                              color: Colors
                                                                                  .black)),
                                                                      child: Center(
                                                                        child: Text(
                                                                            "${allPurchaseRecordData[index].purchaseDetails![j].purchaseDetailsTotalAmount}"),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              )),
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
                              : Container()
        ],
      ),
    );
  }
}
