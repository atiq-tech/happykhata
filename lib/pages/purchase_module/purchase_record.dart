import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
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
  bool isAllTypeClicked = false;
  bool isCategoryWiseClicked = false;
  bool isQuantityWiseClicked = false;
  bool isUserWiseClicked = false;

  //sub dropdowns logic
  bool isWithoutDetailsClicked = false;
  bool isWithDetailsClicked = false;

  // dropdown value
  String? userFullName;
  String? _selectedSearchTypes;
  String? _selectedRecordTypes;
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
  ApiAllProducts? apiAllProducts;
  @override
  void initState() {
    Provider.of<CounterProvider>(context, listen: false).getProducts(context);
    Provider.of<AllProductProvider>(context, listen: false)
        .Purchases_All_Provider(context);
    //firstPickedDate = "2000-03-23";
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          "Search Type:",
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
                                  'All',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedSearchTypes,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSearchTypes = newValue!;

                                    _selectedSearchTypes == "All"
                                        ? data = "showAllWithoutDetails"
                                        : "";

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
                            )),
                      ),
                    ],
                  ),
                ),
                isCategoryWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
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
                                        'Please select a Category',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedCustomerTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedCustomerTypes =
                                              newValue.toString();

                                          print(
                                              "Category Si No ==== > ${newValue}");
                                        });
                                      },
                                      items: All_Actegory_List.map((location) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            "${location.productCategoryName}",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: location.productCategorySlNo,
                                        );
                                      }).toList(),
                                    ),
                                  ),
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
                              Expanded(
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
                                        'Please select a Supplier',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedQuantitySupplierTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedQuantitySupplierTypes =
                                              newValue.toString();
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
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
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
                                        'Please select a Product',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedQuantityProductTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedQuantityProductTypes =
                                              newValue!.toString();
                                        });
                                      },
                                      items: AllGetProducts.map((location) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            "${location.productName}",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: location.productSlNo,
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                    ),
                                  ),
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
                              Expanded(
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
                                          userFullName = "${newValue}";
                                          print(
                                              "User Full name No =====> ${userFullName}");
                                          print(
                                              "User Full name No =====> ${firstPickedDate}");
                                          print(
                                              "User Full name No =====> ${secondPickedDate}");
                                          Provider.of<AllProductProvider>(
                                                  context,
                                                  listen: false)
                                              .GetUserWisePurchase(
                                                  userFullName,
                                                  firstPickedDate,
                                                  secondPickedDate);
                                        });
                                      },
                                      items: All_User_List.map((location) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            "${location.fullName}",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          value: location.fullName,
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
                              Expanded(
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
                    color: Color.fromARGB(255, 3, 91, 150),
                    padding: EdgeInsets.all(1.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });

                        setState(() {
                          // AllType
                          if (isAllTypeClicked && isWithoutDetailsClicked) {
                            data = 'showAllWithoutDetails';
                          } else if (isAllTypeClicked && isWithDetailsClicked) {
                            data = 'showAllWithoutDetails';
                          }

                          // By Category
                          else if (isCategoryWiseClicked) {
                            data = 'showByCategoryDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseDetails(
                                    context,
                                    "${_selectedCustomerTypes}",
                                    "$firstPickedDate",
                                    "${secondPickedDate}",
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
                                    "$firstPickedDate",
                                    "${secondPickedDate}",
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
                                    firstPickedDate, secondPickedDate);
                          } else if (isUserWiseClicked &&
                              isWithDetailsClicked) {
                            data = 'showByUserWithDetails';
                            Provider.of<CounterProvider>(context, listen: false)
                                .getPurchaseRecord(
                              context,
                              "$firstPickedDate",
                              "${secondPickedDate}",
                              "${_selectedUserTypes}",
                            );
                          }
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      child: Container(
                        height: 30.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 113, 185),
                          borderRadius: BorderRadius.circular(3.0),
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
          data == 'showAllWithoutDetails'
              ? Expanded(
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
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
                                  columns: [
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
                                    // DataColumn(
                                    //   label: Center(child: Text('Action')),
                                    // ),
                                  ],
                                  rows: List.generate(
                                    All_Purchase_list.length,
                                    (int index) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterInvoiceNo}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterOrderDate}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].supplierName}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterSubTotalAmount}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterTax}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterDiscountAmount}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterFreight}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterTotalAmount}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${All_Purchase_list[index].purchaseMasterPaidAmount}')),
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
                          ? Center(child: CircularProgressIndicator())
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
                                          color: Colors.black54, width: 1),
                                      columns: [
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
                                ),
                              ),
                            ),
                    )
                  : data == 'showByQuantityDetails'
                      ? Expanded(
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
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
                                              color: Colors.black54, width: 1),
                                          columns: [
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
                                    ),
                                  ),
                                ),
                        )
                      : data == 'showByUserWithoutDetails'
                          ? Expanded(
                              child: isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            child: Column(
                                              children: [
                                                DataTable(
                                                  showCheckboxColumn: true,
                                                  border: TableBorder.all(
                                                      color: Colors.black54,
                                                      width: 1),
                                                  columns: [
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
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Total:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    UserWisePurchaseslist
                                                                .length ==
                                                            0
                                                        ? Text(
                                                            "0",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          )
                                                        : Text(
                                                            "${GetStorage().read("totalSales")}",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                  ],
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
                                      ? Center(
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
                                                  columns: [
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
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseDetails![index].productName}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseDetails![index].purchaseDetailsRate}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseDetails![index].purchaseDetailsTotalQuantity}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allPurchaseRecordData[index].purchaseDetails![index].purchaseDetailsTotalAmount}')),
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