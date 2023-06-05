import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/salse_record_model_class.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:provider/provider.dart';
import '../../common_widget/custom_appbar.dart';
import '../../provider/sales_module/sales_record/provider_sales_data.dart';

class SalesRecordPage extends StatefulWidget {
  const SalesRecordPage({super.key});
  @override
  State<SalesRecordPage> createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
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

  //main dropdowns logic
  bool isAllTypeClicked = false;
  bool isCustomerWiseClicked = false;
  bool isEmployeeWiseClicked = false;
  bool isCategoryWiseClicked = false;
  bool isQuantityWiseClicked = false;
  bool isSummaryWiseClicked = false;
  bool isUserWiseClicked = false;

  //sub dropdowns logic
  bool isWithoutDetailsClicked = false;
  bool isWithDetailsClicked = false;
  bool iscategoryslect = false;
  bool isQuantitylect = false;

  // dropdown value
  String? _selectedRecordTypes;
  String? _selectedCustomerTypes;
  String? _selectedProductType;
  String? _selectedEmployeeTypes;
  String? _selectedCategoryTypes;
  String? _selectedQuantityTypes;
  String? _selectedSummaryTypes;
  String? _selectedUserTypes;

  // util
  double thFontSize = 10.0;
  String data = '';
  bool selectArea = false;
//
  String? _selectedSearchTypes;
  List<String> _searchTypes = [
    'All',
    'By Customer',
    'By Employee',
    'By Category',
    'By Quantity',
    'By Summary',
    'By User',
  ];
  List<String> _recordType = [
    'Without Details',
    'With Details',
  ];
  // by user
  String? byUserId;
  String? byUserFullname;

  String customerId = "";
  String employeeId = "";
  String productId = "";
  String userFullName = "";
  String categoryId = "";
  final provideSalesdetailsRecordList = [];
  List<SaleDetails> provideSalesdetailsRecordListt = [];
  bool isLoading = false;
  @override
  void initState() {
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Provider.of<AllProductProvider>(context, listen: false)
        .getAllSalesRecordData(context, firstPickedDate, secondPickedDate,
            customerId, employeeId, productId, userFullName);
    Provider.of<AllProductProvider>(context, listen: false)
        .Fatch_By_all_Employee(context, firstPickedDate, secondPickedDate,
            customerId, employeeId, productId, userFullName);
    Provider.of<AllProductProvider>(context, listen: false)
        .getAllSalesRecordbyemployeeData(context, firstPickedDate,
            secondPickedDate, customerId, employeeId, productId, userFullName);
    Provider.of<CategoryWiseStockProvider>(context, listen: false)
        .getCategoryWiseStockData(context, categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Sales
    final allGetSalesData = Provider.of<CounterProvider>(context).getSaleslist;
    print("Get Sales length=====> ${allGetSalesData.length} ");
    //get Sales Record
    final allGetSalesRecordData =
        Provider.of<CounterProvider>(context).getSalesRecordlist;
    print("Get Sales record length=====> ${allGetSalesRecordData.length} ");
    //get Sale_details
    final allGetSaleDetailsData =
        Provider.of<CounterProvider>(context).getSaleDetailslist;
    print("Get Sale_Details length=====> ${allGetSaleDetailsData.length} ");
    //get customer_products
    final Allcustomer_productsbyProduct =
        Provider.of<CounterProvider>(context).getCustomerProductslist;
    print(
        "Allcustomer_productsbyProduct =====length> ${Allcustomer_productsbyProduct.length} ");
    //get customer_categories
    final Allcustomer_CategoriesbyCategories =
        Provider.of<CounterProvider>(context).getCustomerCategorieslist;
    print(
        "Allcustomer_CategoriesbyCategories =====length> ${Allcustomer_CategoriesbyCategories.length} ");
    //get sale_summary
    final allGetSaleSummaryData =
        Provider.of<CounterProvider>(context).getSaleSummarylist;
    print(
        "allGetSaleSummaryData =====length> ${allGetSaleSummaryData.length} ");
    final get_all_customer =
        Provider.of<AllProductProvider>(context).by_all_customer_list;
    final get_all_Employee = Provider.of<AllProductProvider>(context)
        .By_all_employee_ModelClass_List;
    final FetchAllProductList =
        Provider.of<AllProductProvider>(context).AllProductModelClassList;
    final FetchUserBySummaryProductlist =
        Provider.of<AllProductProvider>(context).Datalistt;
    final FetchCustomerwiseCategory =
        Provider.of<AllProductProvider>(context).CustomerCategoriesList;
    final CategoryWiseSaleDetailsList =
        Provider.of<AllProductProvider>(context).FetchCategoryySalseDataListt;
    print(
        "CategoryWiseSaleDetailsList======> ${CategoryWiseSaleDetailsList.length} ");

    // for (int j = 0; j < allGetSalesRecordData[index].saleDetails![0].length; j++) {

    // }
    return Scaffold(
      appBar: CustomAppBar(title: "Sales Record"),
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
                                isExpanded: true,
                                hint: const Text(
                                  'Please select a type',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedSearchTypes,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSearchTypes = newValue.toString();
                                    _selectedSearchTypes == "All"
                                        ? isAllTypeClicked = true
                                        : isAllTypeClicked = false;

                                    _selectedSearchTypes == "By Customer"
                                        ? isCustomerWiseClicked = true
                                        : isCustomerWiseClicked = false;

                                    _selectedSearchTypes == "By Employee"
                                        ? isEmployeeWiseClicked = true
                                        : isEmployeeWiseClicked = false;

                                    _selectedSearchTypes == "By Category"
                                        ? isCategoryWiseClicked = true
                                        : isCategoryWiseClicked = false;

                                    _selectedSearchTypes == "By Quantity"
                                        ? isQuantityWiseClicked = true
                                        : isQuantityWiseClicked = false;

                                    _selectedSearchTypes == "By Summary"
                                        ? isSummaryWiseClicked = true
                                        : isSummaryWiseClicked = false;

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

                isCustomerWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        'Please select a customer',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedCustomerTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          print(
                                              "Customerttttttttttttttttttttttttttt $newValue");
                                          _selectedCustomerTypes =
                                              newValue.toString();
                                          customerId = "$newValue";
                                          Provider.of<CounterProvider>(context,
                                                  listen: false)
                                              .getCustomer_products(
                                            context,
                                            customerId,
                                          );
                                          // Provider.of<AllProductProvider>(
                                          //         context,
                                          //         listen: false)
                                          //     .getAllSalesRecordData(
                                          //         context,
                                          //         firstPickedDate,
                                          //         secondPickedDate,
                                          //         customerId,
                                          //         employeeId,
                                          //         productId,
                                          //         userFullName);
                                          print(
                                              "Customerttttttttttttttttttttttttttt $newValue");
                                          // for (int i = 0;
                                          //     i <=
                                          //         provideSalesRecordList.length;
                                          //     i++) {
                                          //   print(
                                          //       "provideSaccccccccclesRecordList  ${provideSalesRecordList[i].customerName}");
                                          //   for (int j = 0;
                                          //       j <=
                                          //           provideSalesRecordList[i]
                                          //               .saleDetails!
                                          //               .length;
                                          //       j++) {
                                          //     provideSalesdetailsRecordListt
                                          //         .add(provideSalesRecordList[i]
                                          //             .saleDetails![j]);
                                          //   }
                                          // }
                                        });
                                      },
                                      items: get_all_customer.map((location) {
                                        return DropdownMenuItem(
                                          value: location.customerSlNo,
                                          child: Text(
                                            "${location.customerName}",
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
                          ), //Customer
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
                                        "Please select a product",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      value: _selectedProductType,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedProductType =
                                              newValue.toString();
                                          //productId = "$newValue";
                                          print(
                                              "Produccccccccccccccccccccccc $newValue");
                                          // Provider.of<CounterProvider>(context,
                                          //         listen: false)
                                          //     .getCustomer_products(
                                          //   context,
                                          //   productId,
                                          // );
                                          // Provider.of<AllProductProvider>(
                                          //         context,
                                          //         listen: false)
                                          //     .getAllSalesRecordData(
                                          //         context,
                                          //         firstPickedDate,
                                          //         secondPickedDate,
                                          //         customerId,
                                          //         employeeId,
                                          //         productId,
                                          //         userFullName);
                                        });
                                      },
                                      items: Allcustomer_productsbyProduct.map(
                                          (location) {
                                        return DropdownMenuItem(
                                          value: location.productSlNo,
                                          child: Text(
                                            "${location.productName}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.visible,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ), //Product
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
                                        isExpanded: true,
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
                                            Provider.of<AllProductProvider>(
                                                    context,
                                                    listen: false)
                                                .getAllSalesRecordData(
                                                    context,
                                                    firstPickedDate,
                                                    secondPickedDate,
                                                    customerId,
                                                    employeeId,
                                                    productId,
                                                    userFullName);
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
                          ), //Record Type
                        ],
                      )
                    : Container(),

                isEmployeeWiseClicked == true
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text(
                                  "Employee:",
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
                                        'Please select an Employee',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedEmployeeTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedEmployeeTypes =
                                              newValue.toString();
                                          employeeId = "$newValue";
                                          print(
                                              "Employeeeeeeeeeeeeeeeeeeee  id :${newValue}");
                                          print(
                                              "Employeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee  id :${_selectedEmployeeTypes}");
                                        });
                                      },
                                      items: get_all_Employee.map((location) {
                                        return DropdownMenuItem(
                                          value: location.employeeSlNo,
                                          child: Text(
                                            "${location.employeeName}",
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
                          // Employee
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
                                        isExpanded: true,
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
                          ), // Record Type
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
                                        'Please select a Customer',
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
                                              "Customer wise Id : =  $newValue");
                                          customerId = "${newValue}";
                                          Provider.of<AllProductProvider>(
                                                  context,
                                                  listen: false)
                                              .FetchCustomerCategoriesSaleProduct(
                                                  context,
                                                  customerId,
                                                  firstPickedDate,
                                                  secondPickedDate);
                                        });
                                      },
                                      items: get_all_customer.map((location) {
                                        return DropdownMenuItem(
                                          value: location.customerSlNo,
                                          child: Text(
                                            "${location.customerName}",
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
                          ), // Employee
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
                                        'Please select a Category',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedCategoryTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedCategoryTypes =
                                              newValue.toString();
                                          print(
                                              "Customer Wise Category ID========== > $newValue ");
                                          categoryId =
                                              "$_selectedCategoryTypes";
                                        });
                                      },
                                      items: FetchCustomerwiseCategory.map(
                                          (location) {
                                        return DropdownMenuItem(
                                          value: location.productCategorySlNo,
                                          child: Text(
                                            "${location.productCategoryName}",
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
                        ],
                      )
                    : Container(),

                isQuantityWiseClicked == true
                    ? Row(
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
                                    'Please select a Product',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ), // Not necessary for Option 1
                                  value: _selectedQuantityTypes,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedQuantityTypes =
                                          newValue.toString();
                                      print(
                                          "ProductID============>by quantity?  ${_selectedQuantityTypes}");
                                      print(
                                          "ProductID============>SINO?  ${_selectedQuantityTypes}");
                                      print(
                                          "ProductID============>SINO?  ${_selectedQuantityTypes}");
                                      print(
                                          "ProductID============>SINO?  ${_selectedQuantityTypes}");
                                    });
                                  },
                                  items: FetchAllProductList.map((location) {
                                    return DropdownMenuItem(
                                      value: location.productSlNo,
                                      child: Text(
                                        "${location.productName}",
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
                      )
                    : Container(),

                isSummaryWiseClicked == true
                    ? Row(
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
                                    'Please select a Product',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ), // Not necessary for Option 1
                                  value: _selectedSummaryTypes,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSummaryTypes =
                                          newValue.toString();
                                      productId = "${_selectedSummaryTypes}";
                                    });
                                  },

                                  items: FetchAllProductList.map((location) {
                                    return DropdownMenuItem(
                                      value: location.productSlNo,
                                      child: Text(
                                        "${location.productName}",
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
                                        'Please select a Product',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedUserTypes,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedUserTypes =
                                              newValue.toString();
                                          userFullName =
                                              "${_selectedUserTypes}";

                                          print(
                                              "Usser sNo==============> ${newValue}");
                                          print(
                                              "Usser sNo=====_selectedUserTypes=========> ${userFullName}");
                                          final results = [
                                            FetchUserBySummaryProductlist.where(
                                                    (m) => m.userSlNo!.contains(
                                                        '$newValue')) // or Testing 123
                                                .toList(),
                                          ];
                                          results.forEach((element) async {
                                            element.add(element.first);
                                            print(
                                                "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
                                            byUserId = "${element[0].userSlNo}";
                                            print(
                                                "byUserId=========> ${element[0].userSlNo}");
                                            byUserFullname =
                                                "${element[0].fullName}";
                                            print(
                                                "byUserFullname===> ${element[0].fullName}");
                                          });
                                        });
                                      },
                                      items: FetchUserBySummaryProductlist.map(
                                          (location) {
                                        return DropdownMenuItem(
                                          value: location.userSlNo,
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       flex: 1,
                          //       child: Text(
                          //         "Type:",
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 3,
                          //       child: Container(
                          //         margin: EdgeInsets.only(top: 5, bottom: 5),
                          //         height: 30,
                          //         padding: EdgeInsets.only(left: 5, right: 5),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: Color.fromARGB(255, 7, 125, 180),
                          //             width: 1.0,
                          //           ),
                          //           borderRadius: BorderRadius.circular(10.0),
                          //         ),
                          //         child: DropdownButtonHideUnderline(
                          //           child: DropdownButton(
                          //             isExpanded: true,
                          //             hint: Text(
                          //               'By Category',
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //               ),
                          //             ), // Not necessary for Option 1
                          //             value: _selectedCategoryyTypes,
                          //             onChanged: (newValue) {
                          //               setState(() {
                          //                 _selectedCategoryyTypes =
                          //                     newValue.toString();
                          //                 if ("${newValue}" == "By Category") {
                          //                   iscategoryslect = true;
                          //                 } else {
                          //                   iscategoryslect = false;
                          //                 }
                          //               });
                          //             },
                          //             items: Typelist.map((location) {
                          //               return DropdownMenuItem(
                          //                 child: Text(
                          //                   location,
                          //                   style: TextStyle(
                          //                     fontSize: 14,
                          //                   ),
                          //                 ),
                          //                 value: location,
                          //               );
                          //             }).toList(),
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // iscategoryslect == true
                          //     ? Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Expanded(
                          //             flex: 1,
                          //             child: Text(
                          //               "Category:",
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //               ),
                          //             ),
                          //           ),
                          //           Expanded(
                          //             flex: 3,
                          //             child: Container(
                          //               margin:
                          //                   EdgeInsets.only(top: 5, bottom: 5),
                          //               height: 30,
                          //               padding:
                          //                   EdgeInsets.only(left: 5, right: 5),
                          //               decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 border: Border.all(
                          //                   color: Color.fromARGB(
                          //                       255, 7, 125, 180),
                          //                   width: 1.0,
                          //                 ),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.0),
                          //               ),
                          //               child: DropdownButtonHideUnderline(
                          //                 child: DropdownButton(
                          //                   isExpanded: true,
                          //                   hint: Text(
                          //                     'Please select a Category',
                          //                     style: TextStyle(
                          //                       fontSize: 14,
                          //                     ),
                          //                   ), // Not necessary for Option 1
                          //                   value: _selectedCategoryTypes,
                          //                   onChanged: (newValue) {
                          //                     setState(() {
                          //                       _selectedCategoryTypes =
                          //                           newValue.toString();

                          //                       print(
                          //                           "Proguct Category SI No========== ${newValue}");
                          //                     });
                          //                   },
                          //                   items:
                          //                       AllCategoryList.map((location) {
                          //                     return DropdownMenuItem(
                          //                       child: Text(
                          //                         "${location.productCategoryName}",
                          //                         style: TextStyle(
                          //                           fontSize: 14,
                          //                         ),
                          //                       ),
                          //                       value: location
                          //                           .productCategorySlNo,
                          //                     );
                          //                   }).toList(),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       )
                          //     : Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Expanded(
                          //             flex: 1,
                          //             child: Text(
                          //               "Quantity:",
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //               ),
                          //             ),
                          //           ),
                          //           Expanded(
                          //             flex: 3,
                          //             child: Container(
                          //               margin:
                          //                   EdgeInsets.only(top: 5, bottom: 5),
                          //               height: 30,
                          //               padding:
                          //                   EdgeInsets.only(left: 5, right: 5),
                          //               decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 border: Border.all(
                          //                   color: Color.fromARGB(
                          //                       255, 7, 125, 180),
                          //                   width: 1.0,
                          //                 ),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10.0),
                          //               ),
                          //               child: DropdownButtonHideUnderline(
                          //                 child: DropdownButton(
                          //                   isExpanded: true,
                          //                   hint: Text(
                          //                     'Please select a Quantity',
                          //                     style: TextStyle(
                          //                       fontSize: 14,
                          //                     ),
                          //                   ), // Not necessary for Option 1
                          //                   value: _selectedCategoryyyTypes,
                          //                   onChanged: (newValue) {
                          //                     setState(() {
                          //                       _selectedCategoryyyTypes =
                          //                           newValue.toString();

                          //                       print(
                          //                           "Quantity SI No========== ${newValue}");
                          //                     });
                          //                   },
                          //                   items: FetchAllProductList.map(
                          //                       (location) {
                          //                     return DropdownMenuItem(
                          //                       child: Text(
                          //                         "${location.productSlNo}",
                          //                         style: TextStyle(
                          //                           fontSize: 14,
                          //                         ),
                          //                       ),
                          //                       value: location.productSlNo,
                          //                     );
                          //                   }).toList(),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       flex: 1,
                          //       child: Text(
                          //         "Product:",
                          //         style: TextStyle(
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       flex: 3,
                          //       child: Container(
                          //         margin: EdgeInsets.only(top: 5, bottom: 5),
                          //         height: 30,
                          //         padding: EdgeInsets.only(left: 5, right: 5),
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           border: Border.all(
                          //             color: Color.fromARGB(255, 7, 125, 180),
                          //             width: 1.0,
                          //           ),
                          //           borderRadius: BorderRadius.circular(10.0),
                          //         ),
                          //         child: DropdownButtonHideUnderline(
                          //           child: DropdownButton(
                          //             isExpanded: true,
                          //             hint: Text(
                          //               'Please select a Product',
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //               ),
                          //             ), // Not necessary for Option 1
                          //             value: _selectedQuantityTypes,
                          //             onChanged: (newValue) {
                          //               setState(() {
                          //                 _selectedQuantityTypes =
                          //                     newValue.toString();

                          //                 print(
                          //                     "Product Srial No =========== > ${newValue}");
                          //               });
                          //             },
                          //             items:
                          //                 FetchAllProductList.map((location) {
                          //               return DropdownMenuItem(
                          //                 child: Text(
                          //                   "${location.productName}",
                          //                   style: TextStyle(
                          //                     fontSize: 14,
                          //                   ),
                          //                 ),
                          //                 value: location.productSlNo,
                          //               );
                          //             }).toList(),
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          //   ],
                          // ),

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
                                        isExpanded: true,
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
                                hintText: firstPickedDate ?? DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()),
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
                                hintText: secondPickedDate ?? DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now()),
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
                /////////////////////////////////////////////////////////////////////////////////////////////////// // Date Picker
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
                          if (isAllTypeClicked && isWithoutDetailsClicked) {
                            data = 'showAllWithoutDetails';
                            //get sales api AllType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSales(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "",
                              "",
                            );
                          } else if (isAllTypeClicked && isWithDetailsClicked) {
                            data = 'showAllWithDetails';
                            //get sales Record api AllType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSalesRecord(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "",
                              "",
                            );
                          }
                          // By Customer
                          else if (isCustomerWiseClicked &&
                              isWithoutDetailsClicked) {
                            data = 'showByCustomerWithoutDetails';
                            //get sales api CustomerType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSales(
                              context,
                              "$customerId",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "$_selectedProductType",
                              "",
                            );
                          } else if (isCustomerWiseClicked &&
                              isWithDetailsClicked) {
                            data = 'showByCustomerWithDetails';
                            //get sales Record api CustomerType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSalesRecord(
                              context,
                              "$customerId",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "$_selectedProductType",
                              "",
                            );
                          }
                          // By Employee
                          else if (isEmployeeWiseClicked &&
                              isWithoutDetailsClicked) {
                            data = 'showByEmployeeWithoutDetails';
                            //get sales api EmployeeType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSales(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "$_selectedEmployeeTypes",
                              "",
                              "",
                            );
                          } else if (isEmployeeWiseClicked &&
                              isWithDetailsClicked) {
                            data = 'showByEmployeeWithDetails';
                            //get sales Record api  EmployeeType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSalesRecord(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "$_selectedEmployeeTypes",
                              "",
                              "",
                            );
                          }
                          // By Category
                          else if (isCategoryWiseClicked) {
                            data = 'showByCategoryDetails';
                            //get sale_details categoryType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSaleDetails(
                              context,
                              "${categoryId}",
                              "${customerId}",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                            );
                          }
                          // By Quantity
                          else if (isQuantityWiseClicked) {
                            data = 'showByQuantityDetails';
                            //get sale_details QuantityType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSaleDetails(
                              context,
                              "${categoryId}",
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "${_selectedQuantityTypes}",
                            );
                          }
                          // By Summary
                          else if (isSummaryWiseClicked) {
                            data = 'showBySummaryDetails';
                            //get sale Summary api SummaryType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSaleSummary(
                              context,
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "$productId",
                            );
                          }

                          // By User
                          else if (isUserWiseClicked &&
                              isWithoutDetailsClicked) {
                            data = 'showByUserWithoutDetails';
                            //get sales api UserType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSales(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "",
                              "$byUserFullname",
                            );
                          } else if (isUserWiseClicked &&
                              isWithDetailsClicked) {
                            data = 'showByUserWithDetails';
                            //get sales Record api UserType
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSalesRecord(
                              context,
                              "",
                              "${firstPickedDate}",
                              "${secondPickedDate}",
                              "",
                              "",
                              "$byUserFullname",
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
                      : SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
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
                                              Center(child: Text('Customer Name')),
                                        ),
                                        DataColumn(
                                          label:
                                          Center(child: Text('Employee Name')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Saved By')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Sub Total')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Vat')),
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
                                        allGetSalesData.length,
                                        (int index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      "${allGetSalesData[index].saleMasterInvoiceNo}")),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterSaleDate}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].customerName}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].employeeName}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].addBy}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      "${allGetSalesData[index].saleMasterSubTotalAmount}")),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterTaxAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterTotalDiscountAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterFreight}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterTotalSaleAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterDueAmount}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesData[index].saleMasterPaidAmount}')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      children: [
                                        Text(//111111
                                          "Sub Total:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//2222
                                          "Total Vat:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//3333333333
                                          "Total Discount:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize:14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//4444444
                                          "Total TC.:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//5555555
                                          "Total:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//6666666
                                          "Total Paid:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")},",
                                          style: TextStyle(
                                              fontSize: 14),
                                        ),
                                        SizedBox(width: 5.0),
                                        Text(//77777777
                                          "Total Due:",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        allGetSalesData
                                            .length ==
                                            0
                                            ? Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 14),
                                        )
                                            : Text(
                                          "${GetStorage().read("totalSalesSubtotal")}",
                                          style: TextStyle(
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
              : data == 'showAllWithDetails'
                  ? Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
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
                                          label:
                                              Center(child: Text('Invoice No')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Date')),
                                        ),
                                        DataColumn(
                                          label: Center(
                                              child: Text('Customer Name')),
                                        ),
                                        DataColumn(
                                          label: Center(
                                              child: Text('Employee Name')),
                                        ),
                                        DataColumn(
                                          label:
                                              Center(child: Text('Saved By')),
                                        ),
                                        DataColumn(
                                          label: Center(
                                              child: Text('Product Name')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Price')),
                                        ),
                                        DataColumn(
                                          label:
                                              Center(child: Text('Quantity')),
                                        ),
                                        DataColumn(
                                          label: Center(child: Text('Total')),
                                        ),
                                      ],
                                      rows: List.generate(
                                        allGetSalesRecordData.length,
                                        (int index) => DataRow(
                                          cells: <DataCell>[
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      "${allGetSalesRecordData[index].saleMasterInvoiceNo}")),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesRecordData[index].saleMasterSaleDate}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesRecordData[index].customerName}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesRecordData[index].employeeName}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: Text(
                                                      '${allGetSalesRecordData[index].addBy}')),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: SizedBox(
                                                // color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      allGetSalesRecordData[
                                                              index]
                                                          .saleDetails!
                                                          .length,
                                                  itemBuilder: (context, j) {
                                                    return Center(
                                                      child: Text(
                                                          "${allGetSalesRecordData[index].saleDetails![j].productName}"),
                                                    );
                                                  },
                                                ),
                                              )),
                                            ),
                                            DataCell(
                                              Center(
                                                child: SizedBox(
                                                  // color: Colors.green,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        allGetSalesRecordData[
                                                                index]
                                                            .saleDetails!
                                                            .length,
                                                    itemBuilder: (context, j) {
                                                      return Center(
                                                        child: Text(
                                                            "${allGetSalesRecordData[index].saleDetails![j].saleDetailsRate}"),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: SizedBox(
                                                // color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      allGetSalesRecordData[
                                                              index]
                                                          .saleDetails!
                                                          .length,
                                                  itemBuilder: (context, j) {
                                                    return Center(
                                                      child: Text(
                                                          "${allGetSalesRecordData[index].saleDetails![j].saleDetailsTotalQuantity}"),
                                                    );
                                                  },
                                                ),
                                              )),
                                            ),
                                            DataCell(
                                              Center(
                                                  child: SizedBox(
                                                // color: Colors.green,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      allGetSalesRecordData[
                                                              index]
                                                          .saleDetails!
                                                          .length,
                                                  itemBuilder: (context, j) {
                                                    return Center(
                                                      child: Text(
                                                          "${allGetSalesRecordData[index].saleDetails![j].saleDetailsTotalAmount}"),
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
                  : data == 'showByCustomerWithoutDetails'
                      ? Expanded(
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
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
                                                  child: Text('Customer Name')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Employee Name')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Saved By')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Sub Total')),
                                            ),
                                            DataColumn(
                                              label: Center(child: Text('Vat')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child: Text('Discount')),
                                            ),
                                            DataColumn(
                                              label: Center(
                                                  child:
                                                      Text('Transport Cost')),
                                            ),
                                            DataColumn(
                                              label:
                                                  Center(child: Text('Total')),
                                            ),
                                            DataColumn(
                                              label:
                                                  Center(child: Text('Paid')),
                                            ),
                                            DataColumn(
                                              label: Center(child: Text('Due')),
                                            ),
                                          ],
                                          rows: List.generate(
                                            allGetSalesData.length,
                                            (int index) => DataRow(
                                              cells: <DataCell>[
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          "${allGetSalesData[index].saleMasterInvoiceNo}")),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].saleMasterSaleDate}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].customerName}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          "${allGetSalesRecordData[index].employeeName}" ?? '')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].addBy}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          "${allGetSalesData[index].saleMasterSubTotalAmount}")),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          "${allGetSalesData[index].saleMasterTaxAmount}")),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].saleMasterTotalDiscountAmount}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          "${allGetSalesData[index].saleMasterFreight}")),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].saleMasterTotalSaleAmount}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].saleMasterPaidAmount}')),
                                                ),
                                                DataCell(
                                                  Center(
                                                      child: Text(
                                                          '${allGetSalesData[index].saleMasterDueAmount}')),
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
                      : data == 'showByCustomerWithDetails'
                          ? Expanded(
                              child: isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : SizedBox(
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
                                                          'Customer Name')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child: Text(
                                                          'Employee Name')),
                                                ),
                                                DataColumn(
                                                  label: Center(
                                                      child: Text('Saved By')),
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
                                              ],
                                              rows: List.generate(
                                                  allGetSalesRecordData.length,
                                                  (int index) {
                                                return DataRow(
                                                  cells: <DataCell>[
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              "${allGetSalesRecordData[index].saleMasterInvoiceNo}")),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allGetSalesRecordData[index].saleMasterSaleDate}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allGetSalesRecordData[index].customerName}')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              "${allGetSalesRecordData[index].employeeName}" ?? '')),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: Text(
                                                              '${allGetSalesRecordData[index].addBy}')),
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
                                                              allGetSalesRecordData[
                                                                      index]
                                                                  .saleDetails!
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
                                                                    "${allGetSalesRecordData[index].saleDetails![j].productName}"),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              allGetSalesRecordData[
                                                                      index]
                                                                  .saleDetails!
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
                                                                    "${allGetSalesRecordData[index].saleDetails![j].saleDetailsRate}"),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: SizedBox(
                                                        //color: Colors.green,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              allGetSalesRecordData[
                                                                      index]
                                                                  .saleDetails!
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
                                                                    "${allGetSalesRecordData[index].saleDetails![j].saleDetailsTotalQuantity}"),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                    ),
                                                    DataCell(
                                                      Center(
                                                          child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              allGetSalesRecordData[
                                                                      index]
                                                                  .saleDetails!
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
                                                                    "${allGetSalesRecordData[index].saleDetails![j].saleDetailsTotalAmount}"),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      )),
                                                    ),
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          : data == 'showByEmployeeWithoutDetails'
                              ? Expanded(
                                  child: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : SizedBox(
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
                                                              'Customer Name')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Employee Name')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child:
                                                              Text('Saved By')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text(
                                                              'Sub Total')),
                                                    ),
                                                    DataColumn(
                                                      label: Center(
                                                          child: Text('Vat')),
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
                                                    allGetSalesData.length,
                                                    (int index) => DataRow(
                                                      cells: <DataCell>[
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterInvoiceNo}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterSaleDate}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].customerName}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].employeeName}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].addBy}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterSubTotalAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterTaxAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterTotalDiscountAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterFreight}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterTotalSaleAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterPaidAmount}')),
                                                        ),
                                                        DataCell(
                                                          Center(
                                                              child: Text(
                                                                  '${allGetSalesData[index].saleMasterDueAmount}')),
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
                              : data == 'showByEmployeeWithDetails'
                                  ? Expanded(
                                      child: isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    // color: Colors.red,
                                                    // padding:EdgeInsets.only(bottom: 16.0),
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
                                                              child:
                                                                  Text('Date')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Customer Name')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Employee Name')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Saved By')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Product Name')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Price')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Quantity')),
                                                        ),
                                                        DataColumn(
                                                          label: Center(
                                                              child: Text(
                                                                  'Total')),
                                                        ),
                                                      ],
                                                      rows: List.generate(
                                                        allGetSalesRecordData
                                                            .length,
                                                        (int index) => DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      "${allGetSalesRecordData[index].saleMasterInvoiceNo}")),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].saleMasterSaleDate}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].customerName}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].employeeName}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].addBy}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].saleDetails![0].productName}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].saleDetails![0].saleDetailsRate}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].saleDetails![0].saleDetailsTotalQuantity}')),
                                                            ),
                                                            DataCell(
                                                              Center(
                                                                  child: Text(
                                                                      '${allGetSalesRecordData[index].saleDetails![0].saleDetailsTotalAmount}')),
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
                                  : data == 'showByCategoryDetails'
                                      ? Expanded(
                                          child: isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Container(
                                                        // color: Colors.red,
                                                        // padding:EdgeInsets.only(bottom: 16.0),
                                                        child: DataTable(
                                                          showCheckboxColumn:
                                                              true,
                                                          border:
                                                              TableBorder.all(
                                                                  color: Colors
                                                                      .black54,
                                                                  width: 1),
                                                          columns: const [
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Invoice No')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Date')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Customer Name')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Product Name')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Sales Rate')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Quantity')),
                                                            ),
                                                            DataColumn(
                                                              label: Center(
                                                                  child: Text(
                                                                      'Total')),
                                                            ),
                                                          ],
                                                          rows: List.generate(
                                                            allGetSaleDetailsData
                                                                .length,
                                                            (int index) =>
                                                                DataRow(
                                                              cells: <DataCell>[
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].saleMasterInvoiceNo}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].saleMasterSaleDate}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].customerName}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].productName}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].saleDetailsRate}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].saleDetailsTotalQuantity}')),
                                                                ),
                                                                DataCell(
                                                                  Center(
                                                                      child: Text(
                                                                          '${allGetSaleDetailsData[index].saleDetailsTotalAmount}')),
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
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : SizedBox(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Container(
                                                            // color: Colors.red,
                                                            // padding:EdgeInsets.only(bottom: 16.0),
                                                            child: DataTable(
                                                              showCheckboxColumn:
                                                                  true,
                                                              border: TableBorder.all(
                                                                  color: Colors
                                                                      .black54,
                                                                  width: 1),
                                                              columns: const [
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Invoice No')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Date')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Customer Name')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Product Name')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Sales Rate')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Quantity')),
                                                                ),
                                                                DataColumn(
                                                                  label: Center(
                                                                      child: Text(
                                                                          'Total')),
                                                                ),
                                                              ],
                                                              rows:
                                                                  List.generate(
                                                                allGetSaleDetailsData
                                                                    .length,
                                                                (int index) =>
                                                                    DataRow(
                                                                  cells: <DataCell>[
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].saleMasterInvoiceNo}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].saleMasterSaleDate}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].customerName}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].productName}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].saleDetailsRate}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].saleDetailsTotalQuantity}')),
                                                                    ),
                                                                    DataCell(
                                                                      Center(
                                                                          child:
                                                                              Text('${allGetSaleDetailsData[index].saleDetailsTotalAmount}')),
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
                                          : data == 'showBySummaryDetails'
                                              ? Expanded(
                                                  child: isLoading
                                                      ? const Center(
                                                          child:
                                                              CircularProgressIndicator())
                                                      : SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Container(
                                                                child:
                                                                    DataTable(
                                                                  showCheckboxColumn:
                                                                      true,
                                                                  border: TableBorder.all(
                                                                      color: Colors
                                                                          .black54,
                                                                      width: 1),
                                                                  columns: const [
                                                                    DataColumn(
                                                                      label: Center(
                                                                          child:
                                                                              Text('Product Code')),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Center(
                                                                          child:
                                                                              Text('Product Name')),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Center(
                                                                          child:
                                                                              Text('Total Quantity')),
                                                                    ),
                                                                    DataColumn(
                                                                      label: Center(
                                                                          child:
                                                                              Text('Total Amount')),
                                                                    ),
                                                                  ],
                                                                  rows: List
                                                                      .generate(
                                                                    allGetSaleSummaryData
                                                                        .length,
                                                                    (int index) =>
                                                                        DataRow(
                                                                      cells: <DataCell>[
                                                                        DataCell(
                                                                          Center(
                                                                              child: Text('${allGetSaleSummaryData[index].productCode}')),
                                                                        ),
                                                                        DataCell(
                                                                          Center(
                                                                              child: Text('${allGetSaleSummaryData[index].productName}')),
                                                                        ),
                                                                        DataCell(
                                                                          Center(
                                                                              child: Text('${allGetSaleSummaryData[index].totalSaleQty}')),
                                                                        ),
                                                                        DataCell(
                                                                          Center(
                                                                              child: Text('${allGetSaleSummaryData[index].totalSaleAmount}')),
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
                                              : data ==
                                                      'showByUserWithoutDetails'
                                                  ? Expanded(
                                                      child: isLoading
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child:
                                                                      Container(
                                                                    // color: Colors.red,
                                                                    // padding:EdgeInsets.only(bottom: 16.0),
                                                                    child:
                                                                        DataTable(
                                                                      showCheckboxColumn:
                                                                          true,
                                                                      border: TableBorder.all(
                                                                          color: Colors
                                                                              .black54,
                                                                          width:
                                                                              1),
                                                                      columns: const [
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Invoice No')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Date')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Customer Name')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Employee Name')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Saved By')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Sub Total')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Vat')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Discount')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Transport Cost')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Total')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Paid')),
                                                                        ),
                                                                        DataColumn(
                                                                          label:
                                                                              Center(child: Text('Due')),
                                                                        ),
                                                                      ],
                                                                      rows: List
                                                                          .generate(
                                                                        allGetSalesData
                                                                            .length,
                                                                        (int index) =>
                                                                            DataRow(
                                                                          cells: <DataCell>[
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterInvoiceNo}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterSaleDate}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].customerName}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].employeeName}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].addBy}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterSubTotalAmount}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterTaxAmount}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterTotalDiscountAmount}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterFreight}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterTotalSaleAmount}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterPaidAmount}')),
                                                                            ),
                                                                            DataCell(
                                                                              Center(child: Text('${allGetSalesData[index].saleMasterDueAmount}')),
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
                                                  : data ==
                                                          'showByUserWithDetails'
                                                      ? Expanded(
                                                          child: isLoading
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Container(
                                                                        // color: Colors.red,
                                                                        // padding:EdgeInsets.only(bottom: 16.0),
                                                                        child:
                                                                            DataTable(
                                                                          showCheckboxColumn:
                                                                              true,
                                                                          border: TableBorder.all(
                                                                              color: Colors.black54,
                                                                              width: 1),
                                                                          columns: const [
                                                                            DataColumn(
                                                                              label: Center(child: Text('Invoice No')),
                                                                            ),
                                                                            DataColumn(
                                                                              label: Center(child: Text('Date')),
                                                                            ),
                                                                            DataColumn(
                                                                              label: Center(child: Text('Customer Name')),
                                                                            ),
                                                                            DataColumn(
                                                                              label: Center(child: Text('Employee Name')),
                                                                            ),
                                                                            DataColumn(
                                                                              label: Center(child: Text('Saved By')),
                                                                            ),
                                                                            // DataColumn(
                                                                            //   label: Center(child: Text('Product Name')),
                                                                            // ),
                                                                            // DataColumn(
                                                                            //   label: Center(child: Text('Price')),
                                                                            // ),
                                                                            // DataColumn(
                                                                            //   label: Center(child: Text('Quantity')),
                                                                            // ),
                                                                            // DataColumn(
                                                                            //   label: Center(child: Text('Total')),
                                                                            // ),
                                                                            DataColumn(
                                                                              label: Center(child: Text('Total')),
                                                                            ),
                                                                          ],
                                                                          rows:
                                                                              List.generate(
                                                                            allGetSalesRecordData.length,
                                                                            (int index) =>
                                                                                DataRow(
                                                                              cells: <DataCell>[
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].saleMasterInvoiceNo}')),
                                                                                ),
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].saleMasterSaleDate}')),
                                                                                ),
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].customerName}')),
                                                                                ),
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].employeeName}')),
                                                                                ),
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].addBy}')),
                                                                                ),
                                                                                // DataCell(
                                                                                //   Center(child: Text('Row $index')),
                                                                                // ),
                                                                                // DataCell(
                                                                                //   Center(child: Text('Row $index')),
                                                                                // ),
                                                                                // DataCell(
                                                                                //   Center(child: Text('Row $index')),
                                                                                // ),
                                                                                // DataCell(
                                                                                //   Center(child: Text('Row $index')),
                                                                                // ),
                                                                                DataCell(
                                                                                  Center(child: Text('${allGetSalesRecordData[index].saleMasterTotalSaleAmount}')),
                                                                                )
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
