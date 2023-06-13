import 'package:flutter/material.dart';
import 'package:poss/provider/sales_module/stock/provider_customer_list.dart';
import 'package:provider/provider.dart';

import '../../common_widget/custom_appbar.dart';

class Customer_List extends StatefulWidget {
  const Customer_List({Key? key}) : super(key: key);

  @override
  State<Customer_List> createState() => _Customer_ListState();
}

class _Customer_ListState extends State<Customer_List> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<CustomerListProvider>(context, listen: false).getCustomerListData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provideCustomerList = Provider.of<CustomerListProvider>(context).provideCustomerList;
    return Scaffold(
        appBar: CustomAppBar(title: "Customer List"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   height: 40.0,
            //   margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            //   child: TextField(
            //     controller: _searchController,
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white,
            //       border: InputBorder.none,
            //       hintText: "Search",
            //       contentPadding: EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Color.fromARGB(255, 7, 125, 180),
            //         ),
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //           color: Color.fromARGB(255, 7, 125, 180),
            //         ),
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //   ),
            // ),
            FutureBuilder(
              future: Provider.of<CustomerListProvider>(context, listen: false).getCustomerListData(context),
              builder: (context, snapshot) {
              if(snapshot.hasData){
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: DataTable(
                          showCheckboxColumn: true,
                          border: TableBorder.all(color: Colors.black54, width: 1),
                          columns: [
                            const DataColumn(
                              label: Center(child: Text('SI.')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Customer Id')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Customer Name')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Address')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Contact No')),
                            ),
                          ],
                          rows: List.generate(
                            provideCustomerList.length,
                                (int index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Center(child: Text("${index + 1}")),
                                ),
                                DataCell(
                                  Center(child: Text(provideCustomerList[index].customerCode!)),
                                ),
                                DataCell(
                                  Center(child: Text(provideCustomerList[index].customerName!)),
                                ),
                                DataCell(
                                  Center(child: Text(provideCustomerList[index].customerAddress!)),
                                ),
                                DataCell(
                                  Center(child: Text(provideCustomerList[index].customerMobile!)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
            }
              else if(snapshot.connectionState == ConnectionState.waiting){
                return  Center(child: CircularProgressIndicator(),);
              }
              else{
                return SizedBox();
              }
            },)
          ],
        ));
  }
}
