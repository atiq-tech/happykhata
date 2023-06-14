import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_cash_transaction/Api_all_add_cash_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_cash_transaction/Api_all_get_cash_transaction.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_accounts_model_class.dart';

import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/const_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';

import 'package:provider/provider.dart';

class CashTransactionPage extends StatefulWidget {
  const CashTransactionPage({super.key});

  @override
  State<CashTransactionPage> createState() => _CashTransactionPageState();
}

class _CashTransactionPageState extends State<CashTransactionPage> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _transactionTypeController =
      TextEditingController();

  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _AmountController = TextEditingController();
  final TextEditingController tnxIdNoController = TextEditingController();


  String? paymentType;
  String? _selectedType;
  final List<String> _selectedTypeList = [
    'Cash Receive',
    'Cash Payment',
  ];
  String? _selectedAccount;
  String? firstPickedDate;
  var backEndFirstDate;
  var toDay = DateTime.now();

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
        print("First Selected date $firstPickedDate");
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
        print("First Selected date $firstPickedDate");
      });
    }
  }

  ApiAllAccounts? apiAllAccounts;
  ApiAllAddCashTransactions? apiAllAddCashTransactions;
  ApiAllGetCashTransactions? apiAllGetCashTransactions;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    _selectedType = 'Cash Receive';
    getCashTransactionId();
    // ACCOUNTS
    getCashTransectionData(backEndFirstDate);
    Provider.of<CounterProvider>(context, listen: false).getAccounts(context);
    // TODO: implement initState
    super.initState();
  }

  getCashTransectionData(backEndFirstDate){
    Provider.of<CounterProvider>(context,
        listen: false)
        .getGetCashTransactions(context,
        "$backEndFirstDate", "$backEndFirstDate"
      // "${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
      // "${DateFormat('yyyy-MM-dd').format(DateTime.now())}"
    );
  }


  final  _accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Account
    final allAccountsData =
        Provider.of<CounterProvider>(context).allAccountslist;
    print(
        "Cash transactions Accounts Accounts =Lenght is:::::${allAccountsData.length}");
    //Get Cash Transaction
    final allGetCashTransactionData =
        Provider.of<CounterProvider>(context).allGetCashTransactionslist;
    print(
        "GCT GCT GCT GCT GCT GCT GCT GCT GCT GCT GCT=Lenght is:::::${allGetCashTransactionData.length}");

    return Scaffold(
      appBar: CustomAppBar(title: "Cash Transaction"),
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 300.0,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 6.0, left: 10.0, right: 8.0),
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
                            flex: 5,
                            child: Text(
                              "Transaction Id",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          Expanded(flex: 1, child: Text(':')),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 28.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: const Color.fromARGB(255, 7, 125, 180))),
                              child: TextField(
                                controller: tnxIdNoController,
                                decoration: InputDecoration(
                                  enabled: false,
                                  filled: true,
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 7, 125, 180),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
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
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              margin: const EdgeInsets.only(
                                right: 5,
                                top: 5,
                                bottom: 5,
                              ),
                              height: 30,
                              child: GestureDetector(
                                onTap: (() {
                                  _firstSelectedDate();
                                }),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(top: 10, left: 10),
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
                        ],
                      ),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Transaction Type",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 28.0,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 5, 107, 155),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text(
                                    'Select Type',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  dropdownColor: const Color.fromARGB(255, 231, 251,
                                      255), // Not necessary for Option 1
                                  value: _selectedType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedType = newValue!;
                                      if (newValue == "Cash Receive") {
                                        paymentType = "In Cash";
                                      }
                                      if (newValue == "Cash Payment") {
                                        paymentType = "Out Cash";
                                      }
                                    });
                                  },
                                  items: _selectedTypeList.map((location) {
                                    return DropdownMenuItem(
                                      value: location,
                                      child: Text(
                                        location,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Account",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 38.0,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 5, 107, 155),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: FutureBuilder(
                                future: Provider.of<CounterProvider>(context).getAccounts(context),
                                builder: (context,
                                    AsyncSnapshot<List<AllAccountsModelClass>> snapshot) {
                                  if (snapshot.hasData) {
                                    return TypeAheadFormField(
                                      textFieldConfiguration:
                                      TextFieldConfiguration(
                                          onChanged: (value){
                                            if (value == '') {
                                              _selectedAccount = '';
                                            }
                                          },
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                          controller: _accountController,
                                          decoration: InputDecoration(
                                            hintText: 'Select account',
                                            suffix: _selectedAccount == '' ? null : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _accountController.text = '';
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Icon(Icons.close,size: 14,),
                                              ),
                                            ),
                                          )
                                      ),
                                      suggestionsCallback: (pattern) {
                                        return snapshot.data!
                                            .where((element) => element.accName!
                                            .toLowerCase()
                                            .contains(pattern
                                            .toString()
                                            .toLowerCase()))
                                            .take(allAccountsData.length)
                                            .toList();
                                        // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title: SizedBox(child: Text("${suggestion.accName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                        );
                                      },
                                      transitionBuilder:
                                          (context, suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected:
                                          (AllAccountsModelClass suggestion) {
                                            _accountController.text = suggestion.accName!;
                                        setState(() {
                                          _selectedAccount = suggestion.accSlNo.toString();
                                          // getCashTransactionId();
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
                              //       'Select account',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //       ),
                              //     ),
                              //     dropdownColor: Color.fromARGB(255, 231, 251,
                              //         255), // Not necessary for Option 1
                              //     value: _selectedAccount,
                              //     onChanged: (newValue) {
                              //       setState(() {
                              //         _selectedAccount = newValue!.toString();
                              //
                              //         getCashTransactionId();
                              //       });
                              //     },
                              //     items: allAccountsData.map((location) {
                              //       return DropdownMenuItem(
                              //         child: Text(
                              //           "${location.accName}",
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         value: location.accSlNo,
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 45.0,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                controller: _DescriptionController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 7, 125, 180),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
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
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 28.0,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                controller: _AmountController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 7, 125, 180),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
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
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              // setState(() {
                              ApiAllAddCashTransactions
                                  .GetApiAllAddCashTransactions(
                                "$_selectedAccount",
                                0,
                                int.parse(_AmountController.text),
                                "${_DescriptionController.text}",
                                "${tnxIdNoController.text}",
                                0,
                                "$paymentType",
                                "Official",
                                "$backEndFirstDate",
                              );
                              getCashTransectionData(backEndFirstDate);
                              // });
                            },
                            child: Container(
                              height: 35.0,
                              width: 85.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 75, 196, 201),
                                    width: 2.0),
                                color: const Color.fromARGB(255, 105, 170, 88),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                  child: Text(
                                "SAVE",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          InkWell(
                            onTap: () {
                              _AmountController.text = '';
                              _DescriptionController.text = '';
                              _selectedAccount = "";
                              _accountController.text = "";
                            },
                            child: Container(
                              height: 35.0,
                              width: 85.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 75, 196, 201),
                                    width: 2.0),
                                color: const Color.fromARGB(255, 196, 81, 65),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(
                                  child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              //   child: Container(
              //     height: 40.0,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8.0),
              //         border: Border.all(color: Colors.black38, width: 1)),
              //     child: TextField(
              //       decoration: InputDecoration(
              //           prefixIcon: const Icon(Icons.search),
              //           suffixIcon: IconButton(
              //             icon: const Icon(Icons.clear),
              //             onPressed: () {
              //               /* Clear the search field */
              //             },
              //           ),
              //           hintText: 'Filter...',
              //           border: InputBorder.none),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 10.0),
              Container(
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
                          border:
                              TableBorder.all(color: Colors.black54, width: 1),
                          columns: [
                            const DataColumn(
                              label: Center(child: Text('Transaction Id')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Account Name')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Date')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Description')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Received Amount ')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Paid Amount ')),
                            ),
                            const DataColumn(
                              label: Center(child: Text('Saved By ')),
                            ),
                          ],
                          rows: List.generate(
                            allGetCashTransactionData.length,
                            (int index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].trId}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].accName}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].trDate}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].trDescription}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].inAmount}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].outAmount}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCashTransactionData[index].addBy}')),
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
      ),
    );
  }

  //getCashTransaction_Id
  String? TransactionId;
  getCashTransactionId() async {
    String link = "${BaseUrl}api/v1/getCashTransactionCode";
    try {
      var response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      tnxIdNoController.text = jsonDecode(response.data);
      print("getCashTransactionId Code===========> $TransactionId");
    } catch (e) {
      print(e);
    }
  }
}
