import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:intl/intl.dart';

import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_cash_transaction/Api_all_cash_transaction.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_accounts_model_class.dart';

import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';

import 'package:provider/provider.dart';

class CashTransactionReportPage extends StatefulWidget {
  const CashTransactionReportPage({super.key});

  @override
  State<CashTransactionReportPage> createState() =>
      _CashTransactionReportPageState();
}

class _CashTransactionReportPageState extends State<CashTransactionReportPage> {
  String? paymentType;
  String? _selectedType = 'All';
  final List<String> _selectedTypeList = [
    'All',
    'Received',
    'Payment',
  ];

  final TextEditingController accountController = TextEditingController();

  String? firstPickedDate;
  String? backEndFirstDate;
  String? backEndSecondDate;
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

  String? secondPickedDate;
  void _secondSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndSecondDate = Utils.formatBackEndDate(selectedDate);
        print("First Selected date $secondPickedDate");
      });
    }
    else{
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondDate = Utils.formatBackEndDate(toDay);
        print("First Selected date $secondPickedDate");
      });
    }
  }
  bool isLoading = false;

  String? _selectedAccount;
  ApiAllAccounts? apiAllAccounts;
  ApiAllCashTransactions? apiAllCashTransactions;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    paymentType = '';
    // ACCOUNTS
    ApiAllAccounts apiAllAccounts;
    Provider.of<CounterProvider>(context, listen: false).getAccounts(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Account
    final allAccountsData =
        Provider.of<CounterProvider>(context).allAccountslist;
    print(
        "Accounts Accounts Accounts =Lenght is:::::${allAccountsData.length}");
    //
    //Cash Transaction
    final allCashTransactionData =
        Provider.of<CounterProvider>(context).allCashTransactionslist;
    print(
        "CT CT CT CT CT CT CT CT CT CT CT=Lenght is:::::${allCashTransactionData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Cash Transaction Report"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 180.0,
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
                          flex: 6,
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
                                isExpanded: true,
                                hint: const Text(
                                  'All',
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
                                    if (newValue == "All") {
                                      paymentType = "";
                                    }
                                    if (newValue == "Received") {
                                      paymentType = "received";
                                    }
                                    if (newValue == "Payment") {
                                      paymentType = "paid";
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
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Accounts",
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
                                        controller: accountController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Account',
                                          suffix: _selectedAccount == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                accountController.text = '';
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
                                          .where((element) => element.accName.toString()
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
                                      accountController.text = "${suggestion.accName}";
                                      setState(() {
                                        _selectedAccount = suggestion.accSlNo.toString();
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
                            //         _selectedAccount = newValue.toString();
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
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 5,
                              top: 5,
                              bottom: 5,
                            ),
                            height: 40,
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
                        Container(
                          child: const Text("to"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                              left: 5,
                              top: 5,
                              bottom: 5,
                            ),
                            child: GestureDetector(
                              onTap: (() {
                                _secondSelectedDate();
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
                    const SizedBox(height: 3),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          print(
                              "CashTransactions selectedType::$paymentType");
                          print("CashTransactions ::${_selectedAccount.toString()=='null'?'dd':_selectedAccount}");
                          print(
                              "firstDate CashTransactions+++++=====::$backEndFirstDate");
                          print(
                              "secondPickedDate +CashTransactions+++++=====::$backEndSecondDate");
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getCashTransactions(
                                    context,
                                    paymentType??"",
                                    _selectedAccount.toString()=='null' ? '' : _selectedAccount.toString(),
                                    backEndFirstDate??'',
                                    backEndSecondDate??'');

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
                            borderRadius: BorderRadius.circular(6.0),
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
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
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
                            child: DataTable(
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1),
                              columns: [
                                const DataColumn(
                                  label: Center(child: Text('Tr.Id')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Date')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Tr.Type')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Account Name')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Received Amount')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Payment Amount')),
                                ),
                              ],
                              rows: List.generate(
                                allCashTransactionData.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].trId}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].trDate}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].trType}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].accName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].inAmount}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allCashTransactionData[index].outAmount}')),
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
