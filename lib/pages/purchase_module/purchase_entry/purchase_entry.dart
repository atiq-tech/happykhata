import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/purchase_cart_page.dart';
import 'package:poss/const_page.dart';
import 'package:poss/home_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:provider/provider.dart';
import '../../../common_widget/custom_appbar.dart';
import 'add_supplier_page.dart';

class PurchaseEntryPage extends StatefulWidget {
  const PurchaseEntryPage({super.key});
  @override
  State<PurchaseEntryPage> createState() => _PurchaseEntryPageState();
}

class _PurchaseEntryPageState extends State<PurchaseEntryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _Selling_PriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _VatController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _paidController = TextEditingController();

double TotalVat=0;

  final TextEditingController _transportController = TextEditingController();

  List<String> salesByList = ['A', 'B', 'C', 'D'];
  List<String> supplierList = ['General Supplier', 'Sabbbir Enterprise', 'Bulet', 'Noyon'];
  List<String> categoryList = ['Paper', 'Khata', 'Printing Paper', 'Tissue'];
  List<String> productList = ['Drawing Khata', 'Pencil', 'Notebook', 'Pen'];

  String? categoryId;
  String? _selectedSupplier;
  String? _selectedCategory;
  String? _selectedProduct;
  String level = "Retails";
  String availableStock = "41 reem";

  double h1TextSize = 16.0;
  double h2TextSize = 12.0;

  bool isVisible = false;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _quantityController.text="1";
    firstPickedDate=DateFormat('yyyy-MM-dd').format(DateTime.now());

  }
  Widget build(BuildContext context) {

    final All_Supplier=Provider.of<CounterProvider>(context).allSupplierslist;
    final All_Category=Provider.of<CategoryWiseStockProvider>(context).provideCategoryWiseStockList;
    final CategoryWiseProductList=Provider.of<AllProductProvider>(context).CategoryWiseProductList;

    print("All_Supplier List ======== >${All_Supplier.length}");
    print("All_Category List ======== >${All_Category.length}");
    print("CategoryWiseProduc List ======== >${CategoryWiseProductList.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Purchase Entry"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                color: Color.fromARGB(255, 7, 125, 180),
                child: Center(
                  child: Text(
                    'Supplier & Product Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 70.0,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Invoice no",
                          style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("123456789"),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _firstSelectedDate();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                        height: 32,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
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
                                  ? Jiffy(DateTime.now()).format("dd - MMM - yyyy")
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
              Container(
                height: 185.0,
                width: double.infinity,
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Supplier",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5, right: 5),
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
                                  'Select Supplier',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedSupplier,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedSupplier = newValue.toString();
                                    _selectedSupplier == "General Supplier" ? isVisible = true : isVisible = false;
                                    _selectedSupplier == "General Supplier" ? isEnabled = true : isEnabled = false;
                                    print(newValue);
                                    print(isVisible);
                                    supplierId=newValue;
                                  final results = [
                                    All_Supplier
                                      .where((m) =>
                                  m.supplierSlNo!.contains('$newValue'))// or Testing 123
                                      .toList(),
                                  ];
                                    results.forEach((element) async{
                                      element.add(element.first);
                                      print("supplierSlNo  ${element[0].supplierSlNo}");
                                      print("supplierMobile  ${element[0].supplierMobile}");
                                      print("supplierName  ${element[0].supplierName}");
                                      print("supplierAddress  ${element[0].supplierAddress}");
                                      print("previousDue  ${element[0].previousDue}");

                                      Previousdue =double.parse("${element[0].previousDue}");
                                      _nameController.text="${element[0].supplierName}";
                                      _mobileNumberController.text="${element[0].supplierMobile}";
                                      _addressController.text="${element[0].supplierAddress}";
                                    });
                                });
                                  },
                                items: All_Supplier.map((location) {
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
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddSupplierPage()));
                            },
                            child: Container(
                              height: 28.0,
                              margin: EdgeInsets.only(bottom: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Color.fromARGB(255, 75, 196, 201), width: 1)),
                              child: Icon(
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
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Name",
                              style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                    ), // drop down
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Mobile No",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              controller: _mobileNumberController,
                              enabled: isEnabled,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isEnabled == true ? Colors.white : Colors.grey[200],
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                                fillColor: isEnabled == true ? Colors.white : Colors.grey[200],
                                contentPadding: EdgeInsets.only(left: 10, top: 10),
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
                height: 240.0,
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                padding: EdgeInsets.only(top: 10.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Color.fromARGB(255, 7, 125, 180), width: 1.0),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                                    categoryId=newValue;


                                      final results = [
                                        All_Category
                                          .where((m) =>
                                      m.productCategorySlNo!.contains('$newValue'))// or Testing 123
                                          .toList(),
                                      ];
                                      results.forEach((element) async{
                                      element.add(element.first);
                                      print("dfhsghdfkhgkh");
                                      productCategoryName="${element[0].productCategoryName}";});
                                    print(productCategoryName);

                                    Provider.of<AllProductProvider>(context,listen: false).CategoryWiseProduct("false", newValue);
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
                    ), // category
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Product",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                                    _selectedProduct = newValue!;
                                    print("Category Product Si No=========> ${newValue}");

                                    final results = [
                                      CategoryWiseProductList
                                          .where((m) =>
                                          m.productSlNo!.contains('$newValue'))// or Testing 123
                                          .toList(),
                                    ];
                                    results.forEach((element) async{
                                      element.add(element.first);
                                      print("dfhsghdfkhgkh");
                                      productId="${element[0].productSlNo}";
                                      print("productSlNo===> ${element[0].productSlNo}");
                                      print("productCategoryName===> ${element[0].productCategoryName}");
                                      productname="${element[0].productName}";
                                      print("productName===> ${element[0].productName}");
                                      _Selling_PriceController.text= "${element[0].productSellingPrice}";
                                      print("productSellingPrice===> ${element[0].productSellingPrice}");
                                      print("vat===> ${element[0].vat}");
                                      print("_quantityController ===> ${_quantityController.text}");
                                      print("productPurchaseRate===> ${element[0].productPurchaseRate}");

                                      _salesRateController.text="${element[0].productPurchaseRate}";

                                      Amount=double.parse("${_salesRateController.text}");
                                      print(Amount);
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
                    ),// product
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Pur. Rate",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              controller: _salesRateController,
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
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Qty",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(right: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if(_quantityController.text=="0"){
                                    _quantityController.text="1";
                                    Amount=double.parse("${_salesRateController.text}") * double.parse("${_quantityController.text}");
                                  }else{
                                    Amount=double.parse("${_salesRateController.text}") * double.parse("${_quantityController.text}");
                                  }
                                });
                              },
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
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
                    ), // quantity
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Amount",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$Amount",
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Selling Price",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              controller: _Selling_PriceController,
                              keyboardType: TextInputType.number,
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 6, 118, 170),
                          ),
                          onPressed: () {
                            setState(() {
                              PurchaseCartList.add(
                                  PurchaseApiModelClass(
                                      productId:"$productId" ,
                                      quantity: "${_quantityController.text}",
                                      categoryId:"$categoryId" ,
                                      categoryName: "$productCategoryName",
                                      name: "$productname",
                                      purchaseRate:"${_Selling_PriceController.text}",
                                      salesRate:"${_salesRateController.text}" ,
                                      total: "$Amount",
                                  ));
                                  CartTotal+=Amount;
                              _VatController.text="0";
                              afterVatTotal=CartTotal;
                               discountTotal=afterVatTotal;

                              Paid=discountTotal;
                              // AfteraddVatTotal=CartTotal;
                              // DiccountTotal=AfteraddVatTotal;
                              // TransportTotal=DiccountTotal;
                              // print("CartTotal ----------------- ${CartTotal}");
                            });
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
                            child: Text(
                              "Catg",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "P. Name",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Qty",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Rate",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "Amount",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                        itemCount: PurchaseCartList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.blue[50],
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${PurchaseCartList[index].categoryName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${PurchaseCartList[index].name}",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${PurchaseCartList[index].quantity}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${PurchaseCartList[index].salesRate}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "${PurchaseCartList[index].total}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: h2TextSize,
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  TotalVat=CartTotal*(double.parse(_VatController.text) / 100);
                                  afterVatTotal=CartTotal-TotalVat;
                                  discountTotal=afterVatTotal;
                                  Transport=discountTotal;
                                  Paid=Transport;
                                 });
                              },
                              controller: _VatController,
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
                        Text(
                          "%",
                          style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5, right: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {

                                  discountTotal=afterVatTotal-double.parse(_discountController.text);
                                  Transport=discountTotal;
                                  Paid=Transport;
                                });
                              },
                              controller: _discountController,
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  Transport=discountTotal-double.parse(_transportController.text);

                                });
                              },
                              controller: _transportController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Total",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$Transport",
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
                            "Paid",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 28.0,
                            margin: EdgeInsets.only(bottom: 5),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  Paid=Transport-double.parse(_paidController.text);

                                });
                              },
                              controller: _paidController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Previous Due",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "$Previousdue",
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
                            "Due",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                              height: 30,
                              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "${Paid + Previousdue}",
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

                              if((Paid + Previousdue) ==0){
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Add to Cart")));
                              }else{
                                AddPuschase();
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                    title: Text("Purchase Successfull"),
                                    actions: [
                                      ActionChip(label: Text("Back"),onPressed: () {
                                        Navigator.pop(context);
                                      },),

                                      ActionChip(label: Text("Home"),onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(name:""),));
                                      },),
                                    ],
                                  );
                                },);
                                PurchaseCartList.clear();
                                Paid=0;
                                Previousdue=0;
                              }

                            },
                            child: Text("Purchase")),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 6, 118, 170),
                            ),
                            onPressed: () {},
                            child: Text("New Purchase")),
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


  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }
  }

  double Total=0;
  double afterVatTotal=0;
  double Amount=0;
  double Transport=0;
  double CartTotal=0;
  double discountTotal=0;
  double  pTotal=0;
  String ? productId;
  String ? productCategoryName;
  String ? productname;
  String ? purchaseRate;
  String ? supplierId;

  double Previousdue=0;
  double Paid=0;
 List<PurchaseApiModelClass> PurchaseCartList =[];



  AddPuschase()async{
    String link="${BaseUrl}api/v1/addPurchase";
    try{
      var studentsmap = PurchaseCartList.map((e){
        return {
          "productId": e.productId,
          "name": e.name,
          "categoryId": e.categoryId,
          "categoryName": e.categoryName,
          "purchaseRate": e.purchaseRate,
          "salesRate": e.salesRate,
          "quantity": e.quantity,
          "total": e.total,
        };
      }).toList();
      print(studentsmap);
      Response response=await Dio().post(link,data:{
        "purchase": {
          "purchaseId": 0,
          "invoice": "2023000070",
          "purchaseFor": "1",
          "purchaseDate": "$firstPickedDate",
          "supplierId": "$supplierId",
          "subTotal": CartTotal,
          "vat": TotalVat,
          "discount": "${double.parse(_discountController.text)}",
          "freight": "${double.parse(_transportController.text)}",
          "total":  Paid + Previousdue,
          "paid":  "${double.parse(_paidController.text)}",
          "due": "${Paid + Previousdue}",
          "previousDue": "$Previousdue",
          "note": " "
        },
        "cartProducts": studentsmap
      },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      var item=jsonDecode(response.data);
      print("${item["message"]}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text("${item["message"]}")));
      // _nameController.text="";
      // _paidController.text="";
      // _mobileNumberController.text="";
      // _addressController.text="";
      // _salesRateController.text="";
      // _discountController.text="";
      // _VatController.text="";
      // _quantityController.text="";
      // _transportController.text="";
      // discountTotal=0;
      // Previousdue=0;
      // TotalVat=0;
      // CartTotal=0;
    }catch(e){print(e);}
  }


}
