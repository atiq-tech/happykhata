import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_suppliers/api_all_suppliers.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_supplier_due/api_all_supplier_due.dart';

import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class SupplierDueReport extends StatefulWidget {
  const SupplierDueReport({Key? key}) : super(key: key);

  @override
  State<SupplierDueReport> createState() => _SupplierDueReportState();
}

class _SupplierDueReportState extends State<SupplierDueReport> {
  bool isSupplierListClicked = false;
  String? _searchType;

  List<String> _searchTypeList = [
    'All',
    'By Supplier',
  ];
  bool isLoading = false;

  String? _selectedSupplier;
  ApiAllSuppliers? apiAllSuppliers;
  ApiAllSupplierDue? apiAllSupplierDue;
  @override
  void initState() {
    ApiAllSuppliers apiAllSuppliers;
    Provider.of<CounterProvider>(context, listen: false).getSupplier(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Suppliers
    final allSuppliersData =
        Provider.of<CounterProvider>(context).allSupplierslist;
    print("ssssssssssssssssssssssssssssssssssssss  ${allSuppliersData.length}");

    // Supplier due
    final allSupplierDueData =
        Provider.of<CounterProvider>(context).allSupplierDuelist;
    print(
        "supplier due ssssssssssssssssssdddddduuuuuuueeeeee  ${allSupplierDueData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Supplier Due Report"),
      body: Container(
        padding: EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 130.0,
                width: double.infinity,
                padding: EdgeInsets.only(top: 6.0, left: 10.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Search Type",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          //
                          Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 30.0,
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
                                    'All',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  dropdownColor: Color.fromARGB(255, 231, 251,
                                      255), // Not necessary for Option 1
                                  value: _searchType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _searchType = newValue!;
                                      _selectedSupplier=null;
                                      if (_searchType == "By Supplier") {

                                        isSupplierListClicked = true;
                                      } else {
                                        isSupplierListClicked = false;
                                      }
                                    });
                                  },
                                  items: _searchTypeList.map((location) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        maxLines: 1,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 6.0),
                    isSupplierListClicked == true
                        ? Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Supplier",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 126, 125, 125)),
                                  ),
                                ),
                                Expanded(flex: 1, child: Text(":")),
                                Expanded(
                                  flex: 11,
                                  child: Container(
                                    height: 30.0,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromARGB(255, 5, 107, 155),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Supplier',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        dropdownColor: Color.fromARGB(
                                            255,
                                            231,
                                            251,
                                            255), // Not necessary for Option 1
                                        value: _selectedSupplier,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedSupplier =
                                                newValue.toString();
                                          });
                                        },
                                        items: allSuppliersData.map((location) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              overflow: TextOverflow.visible,
                                              maxLines: 1,
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
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getSupplierDue(context, _selectedSupplier??"");

                            print(
                                "Supplier due repot======================::${_selectedSupplier}");
                          });
                           Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                        },
                        child: Container(
                          height: 35.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 75, 196, 201),
                                width: 2.0),
                            color: Color.fromARGB(255, 87, 113, 170),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                              child: Text(
                            "Search",
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
              SizedBox(height: 10.0),
             isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
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
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.red,
                            // padding:EdgeInsets.only(bottom: 16.0),
                            child: DataTable(
                              showCheckboxColumn: true,
                              border:
                                  TableBorder.all(color: Colors.black54, width: 1),
                              columns: [
                                DataColumn(
                                  label: Center(child: Text('Supplier Code')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Supplier Name')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Bill Amount')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Paid Amount')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Returned Amount')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Due')),
                                ),
                              ],
                              rows: List.generate(
                                allSupplierDueData.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].supplierCode}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].supplierName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].bill}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].paid}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].returned}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSupplierDueData[index].due}')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 650,bottom: 50.0,top: 10.0),
                            child: Row(
                              children: [
                                Text(//77777777
                                  "Total Due            :      ",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 14),
                                ),
                                allSupplierDueData
                                    .length ==
                                    0
                                    ? Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 14),
                                )
                                    : Text(
                                  "${GetStorage().read("totalDue")}",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
