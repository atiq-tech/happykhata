import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_customers/Api_all_customers.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_profit&loss/Api_all_profit_&_loss.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_customers_Class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfitLossReportPage extends StatefulWidget {
  const ProfitLossReportPage({super.key});

  @override
  State<ProfitLossReportPage> createState() => _ProfitLossReportPageState();
}

class _ProfitLossReportPageState extends State<ProfitLossReportPage> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();
  String? firstPickedDate;
  var toDay = DateTime.now();

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatDate(toDay);
        print("Firstdateee $firstPickedDate");
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
        firstPickedDate = Utils.formatDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }else{
      setState(() {
        firstPickedDate = Utils.formatDate(toDay);
        print("Firstdateee $firstPickedDate");
      });
    }
  }

  var customerNameController = TextEditingController();
  var customer = '';

  String? _selectedType;
  List<String> _selectedTypeList = [
    'Received',
    'Payment',
  ];
  String? _selectedAccount;

  ApiAllCustomers? apiAllCustomers;
  ApiAllProfitLoss? apiAllProfitLoss;

  bool isLoading = false;
  @override
  void initState() {
    //Customers
    firstPickedDate = Utils.formatDate(DateTime.now());
    secondPickedDate = Utils.formatDate(DateTime.now());
    ApiAllCustomers apiAllCustomers;
    Provider.of<CounterProvider>(context, listen: false).getCustomers(context);

    // TODO: implement initState
    super.initState();
  }

  final List selesDetailslist = [];
  @override
  Widget build(BuildContext context) {
    //Customers
    final allCustomersData =
        Provider.of<CounterProvider>(context).allCustomerslist;
    print(
        "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=Lenght is:::::${allCustomersData.length}");
    //
    //Profit^& LOSS
    final allProfitLossData =
        Provider.of<CounterProvider>(context).allProfitLosslist;
    print(
        "plplplplplplplplpplpplplplp=Lenght is:::::${allProfitLossData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Profit & Loss"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: Text(
                            "Customer",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2,
                            padding: const EdgeInsets.only(left: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 5, 107, 155),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: FutureBuilder(
                              future: Provider.of<CounterProvider>(context).getCustomers(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllCustomersClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          if (value == '') {
                                            customer = '';
                                          }
                                        },
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: customerNameController,
                                        decoration: const InputDecoration(
                                            hintText: 'Select Customer')),
                                    suggestionsCallback: (pattern) {
                                      return snapshot.data!
                                          .where((element) => element.displayName!
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(allCustomersData.length)
                                          .toList();
                                      // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: SizedBox(child: Text("${suggestion.displayName}",style: TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (AllCustomersClass suggestion) {
                                      customerNameController.text = suggestion.displayName!;
                                      setState(() {
                                        _selectedAccount = suggestion.customerSlNo.toString();
                                      });
                                    },
                                    onSaved: (value) {},
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Date :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 35,
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
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: firstPickedDate,
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
                          child: const Text("to"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 35,
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
                                  fillColor: Colors.blue[50],
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: secondPickedDate,
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
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getProfitLoss(
                                    context,
                                    "${_selectedAccount}",
                                    "${firstPickedDate}",
                                    "${secondPickedDate}");

                            print("firstDate ++++++=====::${firstPickedDate}");
                            print(
                                "secondPickedDate ++++++=====::${secondPickedDate}");

                            // for (int i = 0;
                            //     i <= allProfitLossData.length;
                            //     i++) {
                            //   for (int k = 0;
                            //       k < allProfitLossData[i].saleDetails!.length;
                            //       k++) {
                            //     selesDetailslist
                            //         .add(allProfitLossData[i].saleDetails![k]);
                            //     print(
                            //         "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh${selesDetailslist[k].productName}");
                            //   }
                            //   print(
                            //       "ddddddddddddddddddddddddddddddddddddddddddd${allProfitLossData[i].saleDetails![0].productName}");
                            //
                       // }
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Container(
                          height: 35.0,
                          width: 85.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 75, 196, 201),
                                width: 2.0),
                            color: const Color.fromARGB(255, 87, 113, 170),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
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
            ),
            const SizedBox(height: 10.0),
           isLoading? const Center(
             child: CircularProgressIndicator(),
           ):
           allProfitLossData.isNotEmpty
               ? Container(
                    height: MediaQuery.of(context).size.height / 1.43,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              columns: const [
                                DataColumn(
                                  label: Center(child: Text('Product Id')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Product')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Sold Quantity')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Purchase Rate')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Purchased Total')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Sold Amount')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Profit/Loss')),
                                ),
                              ],
                              rows: List.generate(
                                allProfitLossData.length,
                                //allProfitLossData[0].saleDetails!.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].productCode}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].productIDNo}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].productName}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].productName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].saleDetailsTotalQuantity}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].saleDetailsTotalQuantity}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].purchaseRate}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].purchaseRate}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].purchasedAmount}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].purchasedAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].saleDetailsTotalAmount}"),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),
                                      // Center(
                                      //     child: Text(
                                      //         '${allProfitLossData[0].saleDetails![index].saleDetailsTotalAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Container(
                                            // color: Colors.green,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.5,
                                            child: ListView.builder(
                                              scrollDirection:
                                              Axis.vertical,
                                              itemCount:
                                              allProfitLossData[
                                              index]
                                                  .saleDetails!
                                                  .length,
                                              itemBuilder: (context, j) {
                                                return Container(
                                                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                  child: Center(
                                                    child: Text(
                                                        "${allProfitLossData[index].saleDetails![j].profitLoss}"),
                                                  ),
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
               : const Align(alignment: Alignment.center,child: Center(child: Text("No Data Found",style: TextStyle(fontSize: 16,color: Colors.red),),))
          ],
        ),
      ),
    );
  }
}
