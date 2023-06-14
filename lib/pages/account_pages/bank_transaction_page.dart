import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_bank_transaction/Api_all_add_bank_transaction.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_accounts/Api_all_bank_accounts.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

class BankTransactionPage extends StatefulWidget {
  const BankTransactionPage({super.key});

  @override
  State<BankTransactionPage> createState() => _BankTransactionPageState();
}

class _BankTransactionPageState extends State<BankTransactionPage> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _transactionTypeController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
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

  String? paymentType;
  String? _transactionType = 'Deposit';
  final List<String> _transactionTypeList = [
    'Deposit',
    'Withdraw',
  ];
  bool isLoading = false; //for loading circulerprogressindicator

  ApiAllBankAccounts? apiAllBankAccounts;
  ApiAllAddBankTransactions? apiAllAddBankTransactions;
  @override
  void initState() {
    paymentType = "deposit";
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    //bank ACCOUNTS
    getBankTrasectionData(backEndFirstDate);
    Provider.of<CounterProvider>(context, listen: false)
        .getBankAccounts(context);
    // TODO: implement initState
    super.initState();
  }

  getBankTrasectionData(backEndFirstDate){
    Provider.of<CounterProvider>(context,
        listen: false)
        .getGetBankTransactions(context,
        "$backEndFirstDate", "$backEndFirstDate");
  }

  @override
  Widget build(BuildContext context) {
    //bank accounts
    final allBankAccountsData =
        Provider.of<CounterProvider>(context).allBankAccountlist;
    print(
        "BankAccounts Accounts bank Accounts =Lenght is:::::${allBankAccountsData.length}");
    //Get Bank Transaction
    final allGetBankTransactionData =
        Provider.of<CounterProvider>(context).allGetBankTransactionslist;
    print(
        "GBT GBT GBT GBT GBT GBT GBT GBT GBT =Lenght is:::::${allGetBankTransactionData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Bank Transaction"),
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: 225.0,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
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
                              "Date",
                              style: TextStyle(
                                  fontSize: 14.0,
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
                                    hintText:firstPickedDate,
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
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Account",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: Container(
                              height: 41.0,
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
                                            .where((element) => element.accountName!
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
                                          title: SizedBox(child: Text("${suggestion.accountName} - ${suggestion.accountNumber} (${suggestion.bankName})",style: const TextStyle(fontSize: 11), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                        );
                                      },
                                      transitionBuilder:
                                          (context, suggestionsBox, controller) {
                                        return suggestionsBox;
                                      },
                                      onSuggestionSelected:
                                          (AllBankAccountModelClass suggestion) {
                                            accountController.text = "${suggestion.accountName}-${suggestion.accountNumber} (${suggestion.bankName})";
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
                              //           fontSize: 14,
                              //           color:
                              //               Color.fromARGB(255, 170, 167, 167)),
                              //     ), // Not necessary for Option 1
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
                              //               fontSize: 14,
                              //               color: Color.fromARGB(
                              //                   255, 31, 30, 30)),
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
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Transaction Type",
                              style: TextStyle(
                                  fontSize: 14.0,
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
                                    'Select Type',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54
                                    ),
                                  ), // Not necessary for Option 1
                                  value: _transactionType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _transactionType = newValue!;
                                      if (newValue == "Deposit") {
                                        paymentType = "deposit";
                                      }
                                      if (newValue == "Withdraw") {
                                        paymentType = "withdraw";
                                      }
                                    });
                                  },
                                  items: _transactionTypeList.map((location) {
                                    return DropdownMenuItem(
                                      value: location,
                                      child: Text(
                                        location,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
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
                              "Amount",
                              style: TextStyle(
                                  fontSize: 14.0,
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
                                controller: _amountController,
                                keyboardType: TextInputType.number,
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
                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Text(
                              "Note",
                              style: TextStyle(
                                  fontSize: 14.0,
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
                                controller: _noteController,
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
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            print("asjdfnhkasjfn $paymentType");
                              ApiAllAddBankTransactions
                                  .GetApiAllAddBankTransactions(
                                context,
                                "$_selectedAccount",
                                _amountController.text,
                                _noteController.text,
                                "$backEndFirstDate",
                                0,
                                "$paymentType",
                              );

                              getBankTrasectionData(backEndFirstDate);

                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() {
                                isLoading = false;
                              });
                            });
                            _amountController.text='';
                            accountController.text='';
                            _noteController.text='';
                          },
                          child: Container(
                            height: 35.0,
                            width: 180.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(255, 131, 224, 146),
                                  width: 2.0),
                              color: const Color.fromARGB(255, 5, 120, 165),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Center(
                                child: Text(
                              "SAVE TRANSACTIONS",
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                              // color: Colors.red,
                              // padding:EdgeInsets.only(bottom: 16.0),
                              child: DataTable(
                                showCheckboxColumn: true,
                                border: TableBorder.all(
                                    color: Colors.black54, width: 1),
                                columns: [
                                  const DataColumn(
                                    label:
                                        Center(child: Text('Transaction Date')),
                                  ),
                                  const DataColumn(
                                    label: Center(child: Text('Account Name')),
                                  ),
                                  const DataColumn(
                                    label:
                                        Center(child: Text('Account Number')),
                                  ),
                                  const DataColumn(
                                    label: Center(child: Text('Bank Name')),
                                  ),
                                  const DataColumn(
                                    label:
                                        Center(child: Text('Transaction Type')),
                                  ),
                                  const DataColumn(
                                    label: Center(child: Text('Note')),
                                  ),
                                  const DataColumn(
                                    label: Center(child: Text('Amount')),
                                  ),
                                ],
                                rows: List.generate(
                                  allGetBankTransactionData.length,
                                  (int index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].transactionDate}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].accountName}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].accountNumber}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].bankName}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].transactionType}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].note}')),
                                      ),
                                      DataCell(
                                        Center(
                                            child: Text(
                                                '${allGetBankTransactionData[index].amount}')),
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
}
