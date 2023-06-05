import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/sales_cart_model_class.dart';
import 'package:poss/const_page.dart';
import 'package:poss/hive/hive/product.dart';
import 'package:poss/home_page.dart';
import 'package:poss/pages/administration_pages/customer_entry_page.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:provider/provider.dart';
import '../../../common_widget/custom_appbar.dart';
import 'add_customer.dart';

class SalesEntryPage extends StatefulWidget {
  const SalesEntryPage({super.key});
  @override
  State<SalesEntryPage> createState() => _SalesEntryPageState();
}

class _SalesEntryPageState extends State<SalesEntryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _discountPercentController =
      TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _DiscountController = TextEditingController();
  final TextEditingController _VatController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _transportController = TextEditingController();

  List<String> salesByList = ['A', 'B', 'C', 'D'];
  List<String> customerList = ['General Customer', 'C0123', 'C0456', 'C0789'];
  List<String> categoryList = ['Paper', 'Khata', 'Printing Paper', 'Tissue'];
  List<String> productList = ['Drawing Khata', 'Pencil', 'Notebook', 'Pen'];

  String? Salling_Rate = "0.0";
  String? customerMobile;
  String? customerAddress;
  String? categoryId;
  String? _selectedSalesBy;
  String? _selectedCustomer;
  String? _selectedCategory;
  String? _selectedProduct;
  String? customerSlNo;
  String? employeeSlNo;
  String? previousDue;
  String level = "retail";
  String availableStock = "0";
  double subtotal = 0;
  double CartTotal = 0;
  double TotalVat = 0;
  double totalDue = 0;
  double totalDueTc = 0;
  double Totaltc = 0;
  double DiccountTotal = 0;
  double TransportTotal = 0;
  double Diccountper = 0;
  double AfteraddVatTotal = 0;
  List<SalesApiModelClass> SalesCartList = [];

  String? cproductId;
  String? ccategoryName;
  String? cname;
  String? csalesRate;
  String? cvat;
  String? cquantity;
  String? ctotal;
  String? cpurchaseRate;

  double h1TextSize = 16.0;
  double h2TextSize = 12.0;
  double Total = 0.0;

  bool isVisible = false;
  bool isEnabled = false;

  late final Box box;

  @override
  void initState() {
    super.initState();
    _quantityController.text = "1";
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Response? response;
  void totalStack(String? cproductId) async {
    response = await Dio().post("${BaseUrl}api/v1/getProductStock",
        data: {"productId": "$cproductId"},
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }));
    setState(() {
      availableStock = "${response!.data}";
    });

    print("response========> ${response!.data}");
  }

  @override
  Widget build(BuildContext context) {
    final All_Employee = Provider.of<AllProductProvider>(context)
        .By_all_employee_ModelClass_List;
    final All_Customer =
        Provider.of<AllProductProvider>(context).by_all_customer_list;
    final All_Category = Provider.of<CategoryWiseStockProvider>(context)
        .provideCategoryWiseStockList;

    ////////
    ///
    ///
    ///
    final CategoryWiseProductList =
        Provider.of<AllProductProvider>(context).CategoryWiseProductList;
    print("All_Employee List ======== >${All_Employee.length}");
    print("All_Customer List ======== >${All_Customer.length}");
    print("All_Category List ======== >${All_Category.length}");
    print(
        "CategoryWiseProduc List ======== >${CategoryWiseProductList.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Sales Entry"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                color: Color.fromARGB(255, 7, 125, 180),
                child: Center(
                  child: Text(
                    'Sales Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 110.0,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Invoice no",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("123456789"),
                      ],
                    ), // Invoice no drop down
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Sales By",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
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
                                  'Select Employee',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedSalesBy,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSalesBy = newValue!;
                                    print(
                                        "Employee Si No ===============> ${newValue}");
                                    employeeSlNo = newValue.toString();
                                  });
                                },
                                items: All_Employee.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.employeeName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.employeeSlNo,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), // Sales by drop down
                    GestureDetector(
                      onTap: () {
                        _selectedDate();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        height: 32,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 5, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 7, 125, 180),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              firstPickedDate == null
                                  ? Jiffy(DateTime.now())
                                      .format("dd - MMM - yyyy")
                                  : firstPickedDate!,
                            ),
                            Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ////
              ///
              ///my practice
              ///
              Container(
                height: 225.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sales Type",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.15,
                              child: Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 5, 114, 165),
                                  ),
                                  value: "retail",
                                  groupValue: level,
                                  onChanged: (value) {
                                    setState(() {
                                      level = value.toString();
                                      print(level);
                                    });
                                  }),
                            ),
                            Text("retail"),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.15,
                              child: Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 5, 114, 165),
                                  ),
                                  value: "wholesale",
                                  groupValue: level,
                                  onChanged: (value) {
                                    setState(() {
                                      level = value.toString();
                                      print(level);
                                    });
                                  }),
                            ),
                            Text("wholesale"),
                          ],
                        ),
                      ],
                    ), // radio button
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Customer",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
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
                                  'Select Customer',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedCustomer,
                                onChanged: (newValue) {
                                  setState(() {
                                    print("customerSlNo ======> ${newValue}");
                                    _selectedCustomer = newValue.toString();
                                    customerSlNo = newValue.toString();
                                    if (_selectedCustomer ==
                                        "General Customer") {
                                      isVisible = true;
                                      isEnabled = true;
                                    } else {
                                      isEnabled = false;
                                      isVisible = false;
                                    }
                                    //  print(_selectedCustomer);
                                    print(isVisible);

                                    final results = [
                                      All_Customer.where((m) => m.customerSlNo!
                                              .contains(
                                                  '$newValue')) // or Testing 123
                                          .toList(),
                                    ];
                                    results.forEach((element) {
                                      element.add(element.first);
                                      print("dfhsghdfkhgkh");
                                      print(
                                          "productSlNo===> ${element[0].displayName}");
                                      print(
                                          "productCategoryName===> ${element[0].customerName}");
                                      customerMobile =
                                          "${element[0].customerMobile}";
                                      _mobileNumberController.text =
                                          "${element[0].customerMobile}";
                                      print(
                                          "customerMobile===> ${element[0].customerMobile}");
                                      customerAddress =
                                          "${element[0].customerAddress}";
                                      _addressController.text =
                                          "${element[0].customerAddress}";
                                      print(
                                          "customerAddress===> ${element[0].customerAddress}");
                                      previousDue = "${element[0].previousDue}";
                                      _previousDueController.text =
                                          "${element[0].previousDue}";
                                      print(
                                          "previousDue===> ${element[0].previousDue}");
                                    });
                                  });
                                },
                                items: All_Customer.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.customerName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.customerSlNo,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CustomerEntryPage2()));
                            },
                            child: Container(
                              height: 28.0,
                              margin:
                                  EdgeInsets.only(left: 5, bottom: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 75, 196, 201),
                                      width: 1)),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), // drop down
                    Visibility(
                      visible: isVisible,
                      child: Row(
                        children: [
                          Expanded(
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
                              margin: EdgeInsets.only(bottom: 5),
                              child: TextField(
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 125, 180),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Mobile",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              enabled: isEnabled,
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isEnabled == true
                                    ? Colors.white
                                    : Colors.grey[200],
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                        Expanded(
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
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              maxLines: 3,
                              controller: _addressController,
                              enabled: isEnabled,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isEnabled == true
                                    ? Colors.white
                                    : Colors.grey[200],
                                contentPadding:
                                    EdgeInsets.only(left: 10, top: 10),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                height: 200.0,
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                padding: EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Category",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            margin: EdgeInsets.only(bottom: 5),
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
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedCategory,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategory = newValue.toString();
                                    categoryId = newValue;
                                    Provider.of<AllProductProvider>(context,
                                            listen: false)
                                        .CategoryWiseProduct("false", newValue);
                                  });
                                },
                                items: All_Category.map((location) {
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
                        ),
                      ],
                    ),
                    // category
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Product",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 5, right: 5),
                            margin: EdgeInsets.only(bottom: 5),
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
                                  'Select Product',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedProduct,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedProduct = newValue.toString();
                                    print(
                                        "Category Product Si No=========> $newValue");

                                    final results = [
                                      CategoryWiseProductList.where((m) =>
                                              m.productSlNo!.contains(
                                                  '$newValue')) // or Testing 123
                                          .toList(),
                                    ];
                                    results.forEach((element) async {
                                      element.add(element.first);
                                      print("dfhsghdfkhgkh");
                                      cproductId = "${element[0].productSlNo}";
                                      print(
                                          "productSlNo===> ${element[0].productSlNo}");
                                      ccategoryName =
                                          "${element[0].productCategoryName}";
                                      print(
                                          "productCategoryName===> ${element[0].productCategoryName}");
                                      cname = "${element[0].productName}";
                                      print(
                                          "productName===> ${element[0].productName}");
                                      print(
                                          "productSellingPrice===> ${element[0].productSellingPrice}");
                                      cvat = "${element[0].vat}";
                                      print("vat===> ${element[0].vat}");
                                      print(
                                          "_quantityController ===> ${_quantityController.text}");
                                      print(
                                          "_quantityController ===> ${_quantityController.text}");
                                      cpurchaseRate =
                                          "${element[0].productPurchaseRate}";
                                      print(
                                          "productPurchaseRate===> ${element[0].productPurchaseRate}");
                                      _VatController.text = "${element[0].vat}";
                                      _salesRateController.text =
                                          "${element[0].productSellingPrice}";
                                      Total = (double.parse(
                                              _quantityController.text) *
                                          double.parse(
                                              _salesRateController.text));
                                      totalStack(cproductId);
                                    });
                                  });
                                },
                                items: CategoryWiseProductList.map((location) {
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), // product

                    Row(
                      children: [
                        Text(
                          "Sales Rate",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 28.0,
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                              controller: _salesRateController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Qty",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                              // onTap: () {
                              //  setState(() {
                              //    Total=(double.parse(_quantityController.text) * double.parse(_salesRateController.text));
                              //  });
                              // },
                              controller: _quantityController,
                              onChanged: (value) {
                                setState(() {
                                  Total = (double.parse(
                                          _quantityController.text) *
                                      double.parse(_salesRateController.text));
                                });
                                // setState(() {
                                //   Total = (double.parse(
                                //           _quantityController.text) *
                                //       double.parse(_salesRateController.text));
                                // });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 6),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Amount",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5, right: 5),
                            height: 30,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 7, 125, 180),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "$Total",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125),
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Available Stock,",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$availableStock",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 6, 118, 170),
                          ),
                          onPressed: () {
                            setState(() {
                              SalesCartList.add(SalesApiModelClass(
                                  productId: "$cproductId",
                                  categoryName: "$ccategoryName",
                                  name: "$cname",
                                  salesRate: "${_salesRateController.text}",
                                  vat: "${_VatController.text}",
                                  quantity: "${_quantityController.text}",
                                  total: "$Total",
                                  purchaseRate: "$cpurchaseRate"));
//
                              CartTotal += Total;
                              AfteraddVatTotal = CartTotal;
                              DiccountTotal = AfteraddVatTotal;
                              TransportTotal = DiccountTotal;
                              print("CartTotal ----------------- ${CartTotal}");
                            });
                            totalStack(cproductId);
                          },
                          child: Text("Add to cart")),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Divider(thickness: 2),
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
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Category",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h2TextSize,
                              ),
                            )),
                        Expanded(
                            flex: 6,
                            child: Text(
                              "Product Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h2TextSize,
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Qty",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h2TextSize,
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Rate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h2TextSize,
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Amount",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h2TextSize,
                              ),
                            )),
                      ],
                    ),
                    Divider(thickness: 2),
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
                        itemCount: SalesCartList.length,
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
                                            flex: 4,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${SalesCartList[index].categoryName}",
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
                                            flex: 6,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  "${SalesCartList[index].name}",
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                  "${SalesCartList[index].quantity}",
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
                                                  "${SalesCartList[index].salesRate}",
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
                                                  "${SalesCartList[index].total}",
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
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: double.infinity,
                      color: Color.fromARGB(255, 7, 125, 180),
                      child: Center(
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
                        Expanded(
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
                                  EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$CartTotal",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
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
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _VatController,
                              onChanged: (value) {
                                setState(() {
                                  TotalVat = CartTotal *
                                      (double.parse(_VatController.text) / 100);
                                  AfteraddVatTotal = CartTotal - TotalVat;
                                  DiccountTotal = AfteraddVatTotal;
                                  TransportTotal = DiccountTotal;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$TotalVat",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Discount",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _DiscountController,
                              onChanged: (value) {
                                setState(() {
                                  Diccountper = AfteraddVatTotal *
                                      (double.parse(_DiscountController.text) /
                                          100);
                                  _discountPercentController.text =
                                      "${Diccountper}";
                                  DiccountTotal =
                                      AfteraddVatTotal - Diccountper;
                                  TransportTotal = DiccountTotal;
                                  Totaltc = TransportTotal +
                                      double.parse(_transportController.text);
                                });
                                // setState(() {
                                //   Diccountper = AfteraddVatTotal *
                                //       (double.parse(_DiscountController.text) /
                                //           100);
                                //   _discountPercentController.text =
                                //       "${Diccountper}";
                                //   DiccountTotal =
                                //       AfteraddVatTotal - Diccountper;
                                //   TransportTotal = DiccountTotal;
                                // });
                                //  setState(() {
                                //   Diccountper = AfteraddVatTotal *
                                //       (double.parse(_DiscountController.text) /
                                //           100);
                                //   // _discountPercentController.text =
                                //   //     "${Diccountper}";
                                //   DiccountTotal =
                                //       AfteraddVatTotal - Diccountper;
                                //   TransportTotal = DiccountTotal;
                                //   Totaltc = TransportTotal +
                                //       double.parse(_transportController.text);
                                // });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 6),
                                hintText: "0.00",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              enabled: false,
                              controller: _discountPercentController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Transport",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _transportController,
                              // onChanged: (value) {
                              //   setState(() {
                              //     TransportTotal = DiccountTotal +
                              //         double.parse(_transportController.text);
                              //   });
                              // },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 5, left: 5),
                                hintText: "0",
                                // hintText: "$DiccountTotal",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                        Expanded(
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
                                  EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$Totaltc",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 126, 125, 125)),
                                //"$TransportTotal",
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
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
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              controller: _paidController,
                              onChanged: (value) {
                                setState(() {
                                  totalDue = DiccountTotal -
                                      double.parse(_paidController.text);
                                  totalDueTc = totalDue +
                                      double.parse(_transportController.text);

                                  // DiccountTotal -=
                                  //     double.parse(_paidController.text);
                                });
                                // setState(() {
                                //   DiccountTotal -=
                                //       double.parse(_paidController.text);
                                // });
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 6),
                                hintText: "0",
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                        Expanded(
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
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 236, 6, 6),
                              ),
                              controller: _previousDueController,
                              //keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                hintText: "0",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 236, 6, 6),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                      children: [
                        Expanded(
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
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            height: 30,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(255, 7, 125, 180),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "$totalDueTc",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                              // "$DiccountTotal"
                            ),
                          ),
                        ),
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
                                    SnackBar(
                                        content: Text("Please Add to Cart")));
                              } else {
                                AddSales();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Sales Successfull"),
                                      actions: [
                                        ActionChip(
                                          label: Text("Back"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ActionChip(
                                          label: Text("Home"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(name: "",),
                                                ));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                SalesCartList.clear();
                                DiccountTotal = 0;
                              }
                            },
                            child: Text("Sale")),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 6, 118, 170),
                            ),
                            onPressed: () {},
                            child: Text("New Sale")),
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

  String? firstPickedDate;

  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

        print("Firstdateee $firstPickedDate");
      });
    }
  }

  AddSales() async {
    String link = "${BaseUrl}api/v1/addSales";
    try {
      var studentsmap = SalesCartList.map((e) {
        return {
          "productId": e.productId,
          "categoryName": e.categoryName,
          "name": e.name,
          "salesRate": e.salesRate,
          "vat": e.vat,
          "quantity": e.quantity,
          "total": e.total,
          "purchaseRate": e.purchaseRate,
        };
      }).toList();
      print(studentsmap);
      Response response = await Dio().post(
        link,
        data: {
          "sales": {
            "salesId": 0,
            "invoiceNo": "",
            "salesBy": GetStorage().read("name"),
            "salesType": level,
            "salesFrom": "1",
            "salesDate": "${firstPickedDate}",
            "customerId": "$customerSlNo",
            "employeeId": "$employeeSlNo",
            "subTotal": "$CartTotal",
            "discount": _discountPercentController.text,
            "vat": "$TotalVat",
            "transportCost": _transportController.text,
            "total": "$Totaltc",
            //"total": "$DiccountTotal",
            "paid": _paidController.text,
            "previousDue": "$previousDue",
            "due": "$totalDueTc",
            //"due": "$DiccountTotal",
            "isService": "false",
            "note": "Note Here"
          },
          "cart": studentsmap
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      var item = jsonDecode(response.data);
      print("${item["message"]}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1), content: Text("${item["message"]}")));
      _nameController.text = "";
      _paidController.text = "";
      _discountPercentController.text = "";
      _mobileNumberController.text = "";
      _addressController.text = "";
      _salesRateController.text = "";
      _DiscountController.text = "";
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
}
