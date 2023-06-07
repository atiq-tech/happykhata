import 'package:flutter/material.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:provider/provider.dart';

class Customer_Due_List extends StatefulWidget {
  const Customer_Due_List({Key? key}) : super(key: key);

  @override
  State<Customer_Due_List> createState() => _Customer_Due_ListState();
}

class _Customer_Due_ListState extends State<Customer_Due_List> {
  bool isCategoryWiseClicked = false;
  bool isProductWiseClicked = false;
  bool isselectByAll = false;
  bool isselectByCustomer = false;
  double thFontSize = 10.0;
  //String data = 'By all';

  List<String> _types = [
    'By all',
    'By Customer',
  ];
  bool isLoading = false; //loading circularprogress indicator
  String? _selectedTypes;
  String? _selectedCustomer;
  @override
  void initState() {
    // Provider.of<AllProductProvider>(context, listen: false)
    //     .Fatch_By_all_Customer(context, userFullName: "", productId: "", employeeId: "",dateTo: "", dateFrom: "", customerId: "");
    // Provider.of<AllProductProvider>(context, listen: false)
    //     .FetchOneCustomerDueListCustomerDueList(
    //   context,
    //   "",
    // );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final get_all_customer =
        Provider.of<AllProductProvider>(context).by_all_customer_list;
    final CustomerDueList =
        Provider.of<AllProductProvider>(context).AllCustomerDueListList;
    final CustomerDueListt = Provider.of<AllProductProvider>(context)
        .OneCustomerDueListCustomerDueListList;

    print("get_all_customer======== ${get_all_customer.length}");
    print("CustomerDueList============= ${CustomerDueList.length}");
    print("CustomerDueListt================= ${CustomerDueListt.length}");

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
                              value: _selectedTypes,
                              onChanged: (newValue) {
                                // setState(() {
                                //   isLoading = true;
                                // });
                                setState(() {
                                  _selectedTypes = newValue!;
                                  if (_selectedTypes== "By Customer") {
                                    isselectByAll = false;
                                    isselectByCustomer = false;
                                  } else {
                                    isselectByAll = true;
                                  }
                                  // Provider.of<AllProductProvider>(context, listen: false)
                                  //      .Fatch_By_all_Customer(context,
                                  //     userFullName: "",
                                  //     productId: "",
                                  //     employeeId: "",
                                  //     dateTo: "",
                                  //     dateFrom: "",
                                  //     customerId: "");
                                });
                                // Future.delayed(Duration(seconds: 3), () {
                                //   setState(() {
                                //     isLoading = false;
                                //   });
                                // });
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
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          isselectByCustomer == true
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
                                        // setState(() {
                                        //   isLoading = true;
                                        // });
                                        _selectedCustomer = newValue.toString();

                                        // Future.delayed(Duration(seconds: 3),
                                        //     () {
                                        //   setState(() {
                                        //     isLoading = false;
                                        //   });
                                        // });
                                      },
                                      items: get_all_customer.map((location) {
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
                   Provider.of<AllProductProvider>(
                       context,
                       listen: false)
                       .FetchAllCustomerDueList(
                     context,
                     "$_selectedCustomer",
                   );
                   print(
                       "Customer due report======================::${_selectedCustomer}");
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
          if (isselectByCustomer == false)
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
                                CustomerDueListt.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].customerCode}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].customerName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].customerMobile}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].billAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              "${CustomerDueListt[index].paidAmount}")),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].cashReceived}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].returnedAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueListt[index].dueAmount}')),
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
          else if (isselectByCustomer == true)
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
                                CustomerDueList.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].customerCode}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].customerName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].customerMobile}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].billAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              "${CustomerDueList[index].paidAmount}")),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].cashReceived}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].returnedAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${CustomerDueList[index].dueAmount}')),
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
