import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_customers/Api_all_customers.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:provider/provider.dart';

class Customer_Due_List extends StatefulWidget {
  const Customer_Due_List({Key? key}) : super(key: key);

  @override
  State<Customer_Due_List> createState() => _Customer_Due_ListState();
}

class _Customer_Due_ListState extends State<Customer_Due_List> {
  bool isCustomerListClicked = false;
  String? _searchType;

  List<String> _searchTypeList = [
    'By all',
    'By Customer',
  ];
  bool isLoading = false; //loading circularprogress indicator
  String? _selectedCustomer;
  ApiAllCustomers? apiAllCustomers;
  @override
  void initState() {

    //Customers/////////////
    ApiAllCustomers apiAllCustomers;
    Provider.of<CounterProvider>(context, listen: false).getCustomers(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allGetCustomer =
        Provider.of<CounterProvider>(context).allCustomerslist;

    final aLLCustomerDueList =
        Provider.of<AllProductProvider>(context).AllCustomerDueListList;


    print("get_all_customer======== ${allGetCustomer.length}");
    print("CustomerDueList============= ${aLLCustomerDueList.length}");


    return Scaffold(
      appBar: CustomAppBar(title: "Customer Due"),
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
                          "Search Type",
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
                                'By all',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ), // Not necessary for Option 1
                              value: _searchType,
                              onChanged: (newValue) {
                                setState(() {
                                  _searchType = newValue!;
                                  _selectedCustomer=null;
                                  if (_searchType== "By Customer") {
                                    isCustomerListClicked = true;
                                  } else {
                                    isCustomerListClicked = false;
                                  }
                                });
                              },
                              items: _searchTypeList.map((location) {
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
                    ],
                  ),
                )
              ],
            ),
          ),
          isCustomerListClicked == true
              ? Container(
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
                                "Customer : ",
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
                                        'Please select Customer',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ), // Not necessary for Option 1
                                      value: _selectedCustomer,
                                      onChanged: (newValue) {
                                        _selectedCustomer = newValue.toString();
                                      },
                                      items: allGetCustomer.map((location) {
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
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin:EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              color: const Color.fromARGB(255, 3, 91, 150),
              padding: const EdgeInsets.all(1.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                 setState(() {
                   Provider.of<AllProductProvider>(
                       context,
                       listen: false)
                       .FetchAllCustomerDueList(
                     context,
                     _selectedCustomer??"",
                   );
                   print(
                       "Customer due report======================::${_selectedCustomer}");
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
                    color: const Color.fromARGB(255, 4, 113, 185),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: const Center(
                      child: Text(
                        "Show Report",
                        style: TextStyle(color: Colors.white),
                      )),
                ),

              )
            ),
          ),

          Divider(
            color: Color.fromARGB(255, 92, 90, 90),
          ),
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
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.red,
                                // padding:EdgeInsets.only(bottom: 16.0),
                                child: DataTable(
                                  showCheckboxColumn: true,
                                  border: TableBorder.all(
                                      color: Colors.black54, width: 1),
                                  columns: [
                                    DataColumn(
                                      label: Center(child: Text('Product Id')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Customer Name')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Customer Mobile')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Total Bill')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Total Paid')),
                                    ),
                                    DataColumn(
                                      label:
                                          Center(child: Text('Paid to Customer')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Sales Returned')),
                                    ),
                                    DataColumn(
                                      label: Center(child: Text('Due Amount')),
                                    ),
                                  ],
                                  rows: List.generate(
                                    aLLCustomerDueList.length,
                                    (int index) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].customerCode}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].customerName}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].customerMobile}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].billAmount}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  "${aLLCustomerDueList[index].paidAmount}")),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].cashReceived}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].returnedAmount}')),
                                        ),
                                        DataCell(
                                          Center(
                                              child: Text(
                                                  '${aLLCustomerDueList[index].dueAmount}')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 1000,bottom: 50.0,top: 10.0),
                                child: Row(
                                  children: [
                                    Text(//77777777
                                      "Total Due        :  ",
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    aLLCustomerDueList
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
                  )

        ],
      ),
    );
  }
}
