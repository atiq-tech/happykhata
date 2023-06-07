import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/all_product_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/category_wise_stock_model.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:poss/provider/sales_module/stock/provider_total_stock.dart';
import 'package:provider/provider.dart';
import '../../common_widget/custom_appbar.dart';
import '../../provider/sales_module/stock/provider_current_stock.dart';
import '../../provider/sales_module/stock/provider_product_wise_stock.dart';

class StockReportPage extends StatefulWidget {
  const StockReportPage({super.key});

  @override
  State<StockReportPage> createState() => _StockReportPageState();
}

class _StockReportPageState extends State<StockReportPage> {
  bool isCategoryWiseClicked = false;
  bool isProductWiseClicked = false;
  double thFontSize = 10.0;
  String data = '';
  List<String> _types = ['Current Stock', 'Total Stock', 'Category Wise Stock', 'Product Wise Stock'];
  String? _selectedTypes;
  String? _selectedCategory;
  String? _selectedProduct;

  String categoryId = "";
  String productId = "";
  var categoryController = TextEditingController();
  var productAllController = TextEditingController();

  bool isLoading = false;//for loading circulerprogressindicator
  @override
  void initState() {
    Provider.of<CurrentStockProvider>(context, listen: false).getAllCurrentStockData(context);
    Provider.of<TotalStockProvider>(context, listen: false).getAllTotalStockData(context);
    Provider.of<CategoryWiseStockProvider>(context, listen: false).getCategoryWiseStockData(context, categoryId: categoryId);
    Provider.of<ProductWiseStockProvider>(context, listen: false).getProductWiseStockData(context, productId);
    // Provider.of<TotalStockWithCategoryProvider>(context, listen: false)
    //     .getAllTotalStockWithCategoryData(context, categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provideCurrentStockList = Provider.of<CurrentStockProvider>(context).provideCurrentStockList;
    final provideTotalStockList = Provider.of<CurrentStockProvider>(context).provideCurrentStockList;
    final provideCategoryWiseStockList = Provider.of<CategoryWiseStockProvider>(context).provideCategoryWiseStockList;
    final provideTotalStockWithCategoryList =
        Provider.of<TotalStockWithCategoryProvider>(context).provideTotalStockWithCategoryList;
    final provideProductWiseStockList = Provider.of<ProductWiseStockProvider>(context).provideProductWiseStockList;
    final provideTotalStockWithProductList =
        Provider.of<TotalStockWithProductProvider>(context).provideTotalStockWithProductList;

    // for (var i = 0; i <= provideTotalStockWithCategoryList.length; i++) {
    //   print(provideTotalStockWithCategoryList[i].productName);
    // }
    return Scaffold(
      appBar: CustomAppBar(title: "Stock Report"),
      body: Column(
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
                          "Select Type:",
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
                                  'Please select a type',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ), // Not necessary for Option 1
                                value: _selectedTypes,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedTypes = newValue!;
                                    _selectedTypes == "Category Wise Stock"
                                        ? isCategoryWiseClicked = true
                                        : isCategoryWiseClicked = false;

                                    _selectedTypes == "Product Wise Stock"
                                        ? isProductWiseClicked = true
                                        : isProductWiseClicked = false;
                                  });
                                },
                                items: _types.map((location) {
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
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Select Category:",
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
                                              .take(provideCategoryWiseStockList.length)
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
                                                      categoryId = '${suggestion.productCategorySlNo}';
                                                      Provider.of<CategoryWiseStockProvider>(context, listen: false)
                                                          .getCategoryWiseStockData(context, categoryId: categoryId);

                                                      _selectedCategory = suggestion.productCategorySlNo.toString();

                                                      Provider.of<TotalStockWithCategoryProvider>(context, listen: false)
                                                          .getAllTotalStockWithCategoryData(context, categoryId);
                                                      print("first index =====${provideTotalStockWithCategoryList[0].productName}");
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
                                //       'Please select a category',
                                //       style: TextStyle(
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //     value: _selectedCategory,
                                //     onChanged: (newValue) {
                                //       setState(() {
                                //         categoryId = "$newValue";
                                //         Provider.of<CategoryWiseStockProvider>(context, listen: false)
                                //             .getCategoryWiseStockData(context, categoryId: categoryId);
                                //
                                //         print("Category Id============$newValue");
                                //         _selectedCategory = newValue.toString();
                                //         print("dropdown value================$newValue");
                                //
                                //         Provider.of<TotalStockWithCategoryProvider>(context, listen: false)
                                //             .getAllTotalStockWithCategoryData(context, categoryId);
                                //         print("first index =====${provideTotalStockWithCategoryList[0].productName}");
                                //       });
                                //     },
                                //     items: provideCategoryWiseStockList.map((location) {
                                //       return DropdownMenuItem(
                                //         child: Text(
                                //           location.productCategoryName!,
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
                        ),
                      )
                    : Container(),
                isProductWiseClicked == true
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                "Select Product",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                height: 38,
                                padding: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color.fromARGB(255, 7, 125, 180),
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
                                                _selectedProduct = '';
                                              }
                                            },
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            controller: productAllController,
                                            decoration: InputDecoration(
                                              hintText: 'Select Product',
                                              suffix: _selectedProduct == '' ? null : GestureDetector(
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
                                              .take(provideProductWiseStockList.length)
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
                                                      productId = "${suggestion.productSlNo}";
                                                      Provider.of<ProductWiseStockProvider>(context, listen: false)
                                                          .getProductWiseStockData(context, productId);

                                                      _selectedProduct = suggestion.productSlNo.toString();

                                                      Provider.of<TotalStockWithProductProvider>(context, listen: false)
                                                          .getAllTotalStockWithProductData(context, productId);
                                                      print("first index =====${provideTotalStockWithProductList[0].productName}");
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
                                //       "Please select a product",
                                //       style: TextStyle(
                                //         fontSize: 14,
                                //       ),
                                //     ),
                                //     value: _selectedProduct,
                                //     onChanged: (newValue) {
                                //       setState(() {
                                //         productId = "$newValue";
                                //         Provider.of<ProductWiseStockProvider>(context, listen: false)
                                //             .getProductWiseStockData(context, productId);
                                //
                                //         print("Product Id============$newValue");
                                //         _selectedProduct = newValue.toString();
                                //         print("dropdown value================$newValue");
                                //
                                //         Provider.of<TotalStockWithProductProvider>(context, listen: false)
                                //             .getAllTotalStockWithProductData(context, productId);
                                //         print("first index =====${provideTotalStockWithProductList[0].productName}");
                                //       });
                                //     },
                                //     items: provideProductWiseStockList.map((location) {
                                //       return DropdownMenuItem(
                                //         child: Text(
                                //           location.productName!,
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
                            )
                          ],
                        ),
                      )
                    : Container(),
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
                          _selectedTypes == "Current Stock"
                              ? data = 'current stock'
                              : _selectedTypes == "Total Stock"
                                  ? data = 'Total Stock'
                                  : _selectedTypes == "Category Wise Stock"
                                      ? data = "Category Wise Stock"
                                      : _selectedTypes == "Product Wise Stock"
                                          ? data = "Product Wise Stock"
                                          : data = '';
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
          if (data == 'current stock')
            isLoading
                    ? Center(child: CircularProgressIndicator())
                    :Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // color: Colors.red,
                    // padding:EdgeInsets.only(bottom: 16.0),
                    child: DataTable(
                      showCheckboxColumn: true,
                      columnSpacing: 20,
                      border: TableBorder.all(color: Colors.black54, width: 1),
                      columns: const [
                        DataColumn(
                          label: Center(child: Text('Product Id',textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Product Name',textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Category',textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Current Quantity',textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Stock Value',textAlign: TextAlign.center)),
                        ),
                      ],
                      rows: List.generate(
                        provideCurrentStockList.length,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              SizedBox(
                                  width: 50, child: Center(child: Text('${provideCurrentStockList[index].productCode}',textAlign: TextAlign.center,))),
                            ),
                            DataCell(
                              SizedBox(width: 200, child: Text('${provideCurrentStockList[index].productName}',textAlign: TextAlign.center)),
                            ),
                            DataCell(
                              SizedBox(width: 200, child: Text('${provideCurrentStockList[index].productCategoryName}',textAlign: TextAlign.center)),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 80,
                                  child: Center(child: Text('${provideCurrentStockList[index].currentQuantity}',textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 80,
                                  child: Center(child: Text('${provideCurrentStockList[index].stockValue}',textAlign: TextAlign.center))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (data == 'Total Stock')
           isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // color: Colors.red,
                    // padding:EdgeInsets.only(bottom: 16.0),
                    child: DataTable(
                      showCheckboxColumn: true,
                      border: TableBorder.all(color: Colors.black54, width: 1),
                      columns: const [
                        DataColumn(
                          label: Center(child: Text('Product Id', textAlign: TextAlign.center,)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Product Name', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Category', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Production Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Purchased Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Purchase Returned Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Damaged Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Sold Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Sales Returned Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Transferred In Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Transferred Out Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Current Quantity', textAlign: TextAlign.center)),
                        ),
                        DataColumn(
                          label: Center(child: Text('Stock Value', textAlign: TextAlign.center)),
                        ),
                      ],
                      rows: List.generate(
                        provideTotalStockList.length,
                        (int index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              SizedBox(
                                  width: 50, child: Center(child: Text('${provideTotalStockList[index].productCode}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(width: 100, child: Text('${provideTotalStockList[index].productName}', textAlign: TextAlign.center)),
                            ),
                            DataCell(
                              SizedBox(width: 80, child: Text('${provideTotalStockList[index].productCategoryName}', textAlign: TextAlign.center)),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideTotalStockList[index].productionQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideTotalStockList[index].purchaseQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child:
                                      Center(child: Text('${provideCurrentStockList[index].purchaseReturnQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].damageQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].salesQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].salesReturnQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].transferFromQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].transferToQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].currentQuantity}', textAlign: TextAlign.center))),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 50,
                                  child: Center(child: Text('${provideCurrentStockList[index].stockValue}', textAlign: TextAlign.center))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          else if (data == 'Category Wise Stock')
           isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
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
                                border: TableBorder.all(color: Colors.black54, width: 1),
                                columns: const [
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
                                    label: Center(child: Text('Production Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Purchased Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Purchase Returned Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Damaged Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Sold Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Sales Returned Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Transferred In Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Transferred Out Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Current Quantity')),
                                  ),
                                  DataColumn(
                                    label: Center(child: Text('Stock Value')),
                                  ),
                                ],
                                rows: List.generate(
                                  provideTotalStockWithCategoryList.length,
                                  (int index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].productCode}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].productName}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].productCategoryName}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].productionQuantity}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].purchasedQuantity}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child:
                                                Text(' ${provideTotalStockWithCategoryList[index].purchaseReturnedQuantity}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].damagedQuantity}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].soldQuantity}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text('${provideTotalStockWithCategoryList[index].salesReturnedQuantity}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child:
                                                Text('${provideTotalStockWithCategoryList[index].transferredFromQuantity}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text('${provideTotalStockWithCategoryList[index].transferredToQuantity}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].currentQuantity}')),
                                      ),
                                      DataCell(
                                        Center(child: Text('${provideTotalStockWithCategoryList[index].stockValue}')),
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
          else if (data == 'Product Wise Stock')
            isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
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
                        border: TableBorder.all(color: Colors.black54, width: 1),
                        columns: const [
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
                            label: Center(child: Text('Production Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Purchased Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Purchase Returned Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Damaged Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Sold Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Sales Returned Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Transferred In Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Transferred Out Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Current Quantity')),
                          ),
                          DataColumn(
                            label: Center(child: Text('Stock Value')),
                          ),
                        ],
                        rows: List.generate(
                          provideTotalStockWithProductList.length,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].productCode}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].productName}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].productCategoryName}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].productionQuantity}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].purchasedQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child:
                                        Text(' ${provideTotalStockWithProductList[index].purchaseReturnedQuantity}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].damagedQuantity}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].soldQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(' ${provideTotalStockWithProductList[index].salesReturnedQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(' ${provideTotalStockWithProductList[index].transferredFromQuantity}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(' ${provideTotalStockWithProductList[index].transferredToQuantity}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].currentQuantity}')),
                              ),
                              DataCell(
                                Center(child: Text(' ${provideTotalStockWithProductList[index].stockValue}')),
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
        ],
      ),
    );
  }
}
