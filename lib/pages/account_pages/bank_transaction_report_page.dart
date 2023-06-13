import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:intl/intl.dart';

import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_accounts/Api_all_bank_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_transaction/Api_all_bank_transaction.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_transaction_model_class.dart';

import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

class BankTransactionReportPage extends StatefulWidget {
  const BankTransactionReportPage({super.key});

  @override
  State<BankTransactionReportPage> createState() =>
      _BankTransactionReportPageState();
}

class _BankTransactionReportPageState extends State<BankTransactionReportPage> {
  String? _selectedAccount;
//
  String? paymentType;
  String? _selectedType;
  List<String> _selectedTypeList = [
    'All',
    'Deposit',
    'Withdraw',
  ];

  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();
  final TextEditingController accountController = TextEditingController();
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

  bool isLoading = false;

  ApiAllBankAccounts? apiAllBankAccounts;
  ApiAllBankTransactions? apiAllBankTransactions;
  @override
  void initState() {
    // TODO: implement initState
    firstPickedDate = Utils.formatDate(DateTime.now());
    secondPickedDate = Utils.formatDate(DateTime.now());
    //bank ACCOUNTS
    ApiAllBankAccounts apiAllBankAccounts;
    Provider.of<CounterProvider>(context, listen: false)
        .getBankAccounts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bank accounts
    final allBankAccountsData =
        Provider.of<CounterProvider>(context).allBankAccountlist;
    print(
        "BankAccounts Accounts bank Accounts =Lenght is:::::${allBankAccountsData.length}");
    //bank transactions
    final allBankTransactionData =
        Provider.of<CounterProvider>(context).allBankTransactionslist;
    print(
        "BT BT BT BT BT BT BT BT BT BT =Lenght is:::::${allBankAccountsData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Bank Transaction Report"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 170.0,
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
                              future: Provider.of<CounterProvider>(context).getBankAccounts(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllBankAccountModelClass>> snapshot) {
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
                                          .where((element) => element.bankName
                                          .toString()
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(allBankAccountsData.length)
                                          .toList();
                                      // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: SizedBox(child: Text("${suggestion.accountNumber} (${suggestion.bankName})",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (AllBankAccountModelClass suggestion) {
                                      accountController.text = "${suggestion.accountNumber} ${suggestion.bankName}";
                                      setState(() {
                                        _selectedAccount = suggestion.accountId.toString();
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
                            //         _selectedAccount = newValue!.toString();
                            //       });
                            //     },
                            //     items: allBankAccountsData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.bankName}",
                            //           style: TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.accountId,
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
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
                                    if (newValue == "Deposit") {
                                      paymentType = "deposit";
                                    }
                                    if (newValue == "Withdraw") {
                                      paymentType = "withdraw";
                                    }
                                  });
                                },
                                items: _selectedTypeList.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      location,
                                      style: const TextStyle(
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
                    const SizedBox(height: 10),
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
                            height: 35,
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
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          Provider.of<CounterProvider>(context, listen: false)
                              .getBankTransactions(
                            context,
                           accountId: "${_selectedAccount}",
                            dateFrom: "${firstPickedDate}",
                            dateTo: "${secondPickedDate}",
                             transactionType: "${paymentType}",
                          );

                          print("CashTransactions ::${_selectedAccount}");
                          print(
                              "firstDate CashTransactions+++++=====::${firstPickedDate}");
                          print(
                              "secondPickedDate +CashTransactions+++++=====::${secondPickedDate}");
                          print(
                              "CashTransactions selectedType::${paymentType}");
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
                                  label: Center(child: Text('SI')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Description')),
                                ),
                                const DataColumn(
                                  label:
                                      Center(child: Text('Transaction Date')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Account Name')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Account Number')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Bank Name')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Note')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Deposit')),
                                ),
                                const DataColumn(
                                  label: Center(child: Text('Withdraw')),
                                )
                              ],
                              rows: List.generate(
                                allBankTransactionData.length,
                                (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(child: Text('${index + 1}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].description}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].transactionDate}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].accountName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].accountNumber}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].bankName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allBankTransactionData[index].note}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: allBankTransactionData[index]
                                                      .transactionType ==
                                                  "deposit"
                                              ? Text(
                                                  '${allBankTransactionData[index].amount}')
                                              : const Text(" ")),
                                    ),
                                    DataCell(
                                      Center(
                                          child: allBankTransactionData[index]
                                                      .transactionType ==
                                                  "withdraw"
                                              ? Text(
                                                  '${allBankTransactionData[index].amount}')
                                              : const Text(" ")),
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
