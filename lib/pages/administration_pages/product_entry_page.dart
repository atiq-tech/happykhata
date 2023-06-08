import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_products/Api_all_add_products.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_getUnits/Api_all_getUnits.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_products/api_all_products.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/category_wise_stock_model.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/const_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:provider/provider.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _vatController = TextEditingController();
  final TextEditingController _reOrderLevelController = TextEditingController();
  final TextEditingController _purchaseRateController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _WholesaleRateController =
      TextEditingController();

  String? productCategorySlNo;

  String? _selectedCategory;
  String? _selectedUnit;

  bool? check1 = false;
  ApiAllProducts? apiAllProducts;
  ApiAllGetUnits? apiAllGetUnits;
  @override
  void initState() {
    //get Products
    ApiAllProducts apiAllProducts;
    Provider.of<CounterProvider>(context, listen: false).getProducts(context);
    //get Products><get unit
    ApiAllGetUnits apiAllGetUnits;
    Provider.of<CounterProvider>(context, listen: false).getUnits(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _productNameController.dispose();
    _vatController.dispose();
    _reOrderLevelController.dispose();
    _purchaseRateController.dispose();
    _salesRateController.dispose();
    _WholesaleRateController.dispose();
    super.dispose();
  }

  var categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final allCategoryListData = Provider.of<CategoryWiseStockProvider>(context)
        .provideCategoryWiseStockList;
    //get Units
    final allUnitsData = Provider.of<CounterProvider>(context).allUnitslist;
    print(
        "Units===Units===Units===Units===Lenght is:::::${allUnitsData.length}");
    //get Products
    final allProductsData =
        Provider.of<CounterProvider>(context).allProductslist;
    print(
        "Product===Product===Product===Product===Lenght is:::::${allProductsData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Product Entry"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              child: Container(
                height: 400.0,
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 6.0,
                  left: 8.0,
                  right: 8.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Category",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 40.0,
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 5, 107, 155),
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
                                            _selectedCategory = '';
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: categoryController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Category',
                                          suffix: _selectedCategory == '' ? null : GestureDetector(
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
                                          .take(allCategoryListData.length)
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
                                        _selectedCategory = suggestion.productCategorySlNo.toString();
                                        getProductCode();
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
                            //       'Select category',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     dropdownColor: Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedCategory,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedCategory = newValue!.toString();
                            //         getProductCode();
                            //       });
                            //     },
                            //     items: allCategoryListData.map((location) {
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
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Product Name",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _productNameController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Unit",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
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
                                  'Select unit',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: Color.fromARGB(255, 231, 251,
                                    255), // Not necessary for Option 1
                                value: _selectedUnit,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedUnit = newValue!.toString();
                                  });
                                },
                                items: allUnitsData.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.unitName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.unitSlNo,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "VAT",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _vatController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Re-order level",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _reOrderLevelController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Purchase Rate",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _purchaseRateController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Sales Rate",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _salesRateController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Wholesale Rate",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _WholesaleRateController,
                              decoration: InputDecoration(
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Text(
                          "Is Service :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Checkbox(
                            //only check box
                            value: check1, //unchecked
                            onChanged: (bool? value) {
                              //value returned when checkbox is clicked
                              setState(() {
                                check1 = value;
                              });
                            }),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          ApiAllAddProduct.GetApiAllAddProduct(
                              context,
                              "$_selectedCategory",
                              "$iitem",
                              "${_productNameController.text}",
                              "${_purchaseRateController.text}",
                              "${_reOrderLevelController.text}",
                              "${_salesRateController.text}",
                              "",
                              "${_WholesaleRateController.text}",
                              "$_selectedUnit",
                              "",
                              check1,
                              "${_vatController.text}");

                          Provider.of<CounterProvider>(context, listen: false)
                              .getProducts(context);
                        },
                        child: Container(
                            height: 30.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 2, 163, 82),
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: Color.fromARGB(255, 75, 196, 201),
                                    width: 1)),
                            child: Center(
                                child: Text(
                              "Save",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Container(
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
                    child: Container(
                      // color: Colors.red,
                      // padding:EdgeInsets.only(bottom: 16.0),
                      child: DataTable(
                        showCheckboxColumn: true,
                        border:
                            TableBorder.all(color: Colors.black54, width: 1),
                        columns: [
                          DataColumn(
                            label: Center(child: Text('Product Id')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Product Name')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Category')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Purchase Price')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Sales Price')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Wholesale Price')),
                          ),
                          DataColumn(
                            label: Center(child: Text('VAT')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Is Service')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Unit')),
                          ),
                        ],
                        rows: List.generate(
                          allProductsData.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productCode}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productCategoryName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productPurchaseRate}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productSellingPrice}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].productWholesaleRate}')),
                              ),
                              DataCell(
                                Center(
                                    child:
                                        Text('${allProductsData[index].vat}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].isService}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allProductsData[index].unitName}')),
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

  String? iitem;
  getProductCode() async {
    String link = "${BaseUrl}api/v1/getProductCode";
    try {
      Response response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      iitem = jsonDecode(response.data);
      print("Product Code===========> $iitem");
    } catch (e) {
      print(e);
    }
  }
}
