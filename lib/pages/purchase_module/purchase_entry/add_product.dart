import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../common_widget/custom_appbar.dart';

class ProductEntry extends StatefulWidget {
  const ProductEntry({super.key});

  @override
  State<ProductEntry> createState() => _ProductEntryState();
}

class _ProductEntryState extends State<ProductEntry> {
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _vatController = TextEditingController();
  final TextEditingController _reOrderLevelController = TextEditingController();
  final TextEditingController _purchaseRateController = TextEditingController();
  final TextEditingController _salesRateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _WholesaleRateController = TextEditingController();
  String? _selectedCategory;
  List<String> _selectedCategoryList = [
    'Paper',
    'Khata',
    'Printing Paper',
    'Tali Khata',
    'Discount',
    'Withdraw',
    'Van Survice',
    'Machine Survice',
    'Factory Rent',
    'Purchase',
    'Truck Vara',
    'Mobile Recharge',
    'Production bill',
    'Interest',
    'Instolment',
  ];
  String? _selectedUnit;
  List<String> _selectedUnitList = [
    'PCS',
    'Reem',
    'K.G',
    'Packet',
  ];
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
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
                            "Product Id",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 28.0,
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              controller: _productIdController,
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
                            "Category",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 9,
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
                                  'Select category',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: Color.fromARGB(255, 231, 251, 255), // Not necessary for Option 1
                                value: _selectedCategory,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCategory = newValue!;
                                  });
                                },
                                items: _selectedCategoryList.map((location) {
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
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        height: 150.0,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 3.0),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    "Category Name:",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromARGB(255, 78, 77, 77)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 12,
                                                  child: Container(
                                                    height: 28.0,
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    child: TextField(
                                                      controller: _categoryController,
                                                      decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                                        hintText: "Category Name",
                                                        border: InputBorder.none,
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(color: Color.fromARGB(255, 7, 125, 180)),
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
                                            SizedBox(height: 3.0),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    "Description:",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromARGB(255, 78, 77, 77)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 12,
                                                  child: Container(
                                                    height: 50.0,
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    child: TextField(
                                                      controller: _descriptionController,
                                                      decoration: InputDecoration(
                                                        hintText: "Category Description",
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
                                            SizedBox(height: 10.0),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(255, 173, 241, 179), width: 2.0),
                                                    color: Color.fromARGB(255, 94, 136, 84),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "Submit",
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
                                    );
                                  });
                            },
                            child: Container(
                              height: 28.0,
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Product Name",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 9,
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
                                dropdownColor: Color.fromARGB(255, 231, 251, 255), // Not necessary for Option 1
                                value: _selectedUnit,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedUnit = newValue!;
                                  });
                                },
                                items: _selectedUnitList.map((location) {
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
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Container(
                                        height: 100.0,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 3.0),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    "Unit Name:",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: Color.fromARGB(255, 78, 77, 77)),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 12,
                                                  child: Container(
                                                    height: 28.0,
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    child: TextField(
                                                      controller: _categoryController,
                                                      decoration: InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                                                        hintText: "Unit Name",
                                                        border: InputBorder.none,
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(color: Color.fromARGB(255, 7, 125, 180)),
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
                                            SizedBox(height: 10.0),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  width: 80.0,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(255, 173, 241, 179), width: 2.0),
                                                    color: Color.fromARGB(255, 94, 136, 84),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "Submit",
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
                                    );
                                  });
                            },
                            child: Container(
                              height: 28.0,
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "VAT",
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                            style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                          style: TextStyle(color: Color.fromARGB(255, 126, 125, 125)),
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
                        onTap: () {},
                        child: Container(
                            height: 30.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 2, 163, 82),
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Color.fromARGB(255, 75, 196, 201), width: 1)),
                            child: Center(
                                child: Text(
                              "Save",
                              style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromARGB(255, 255, 255, 255)),
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                height: 40.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), border: Border.all(color: Colors.black38, width: 1)),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                        },
                      ),
                      hintText: 'Filter...',
                      border: InputBorder.none),
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
                        border: TableBorder.all(color: Colors.black54, width: 1),
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
                          DataColumn(
                            label: Center(child: Text('Action')),
                          ),
                        ],
                        rows: List.generate(
                          30,
                          (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Center(child: Text('Row $index')),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                                    IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                                  ],
                                ),
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
