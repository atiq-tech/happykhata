import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:intl/intl.dart';

import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_cash_transaction/Api_all_cash_transaction.dart';

import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';

import 'package:provider/provider.dart';

class CashTransactionReportPage extends StatefulWidget {
  const CashTransactionReportPage({super.key});

  @override
  State<CashTransactionReportPage> createState() =>
      _CashTransactionReportPageState();
}

class _CashTransactionReportPageState extends State<CashTransactionReportPage> {
  String? paymentType;
  String? _selectedType;
  List<String> _selectedTypeList = [
    'All',
    'Received',
    'Payment',
  ];

  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();
  String? firstPickedDate;

  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
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
        secondPickedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  bool isLoading = false;

  String? _selectedAccount;
  ApiAllAccounts? apiAllAccounts;
  ApiAllCashTransactions? apiAllCashTransactions;
  @override
  void initState() {
    firstPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    secondPickedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
              padding: EdgeInsets.all(6.0),
              child: Container(
                height: 170.0,
                width: double.infinity,
                padding: EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0),
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
                            "Transaction Type",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
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
                                isExpanded: true,
                                hint: Text(
                                  'All',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: Color.fromARGB(255, 231, 251,
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
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Text(
                            "Accounts",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
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
                                isExpanded: true,
                                hint: Text(
                                  'Select account',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                dropdownColor: Color.fromARGB(255, 231, 251,
                                    255), // Not necessary for Option 1
                                value: _selectedAccount,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedAccount = newValue.toString();
                                  });
                                },
                                items: allAccountsData.map((location) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${location.accName}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    value: location.accSlNo,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(
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
                                      EdgeInsets.only(top: 10, left: 10),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: firstPickedDate == null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                      : firstPickedDate,
                                  hintStyle: TextStyle(
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
                          child: Text("to"),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(
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
                                      EdgeInsets.only(top: 10, left: 10),
                                  filled: true,
                                  fillColor: Colors.blue[50],
                                  suffixIcon: Icon(
                                    Icons.calendar_month,
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: secondPickedDate == null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                      : secondPickedDate,
                                  hintStyle: TextStyle(
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
                    SizedBox(height: 3),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          setState(() {
                            Provider.of<CounterProvider>(context, listen: false)
                                .getCashTransactions(
                                    context,
                                    "${paymentType}",
                                    "${_selectedAccount}",
                                    "${firstPickedDate}",
                                    "${secondPickedDate}");
                            print(
                                "CashTransactions selectedType::${paymentType}");
                            print("CashTransactions ::${_selectedAccount}");
                            print(
                                "firstDate CashTransactions+++++=====::${firstPickedDate}");
                            print(
                                "secondPickedDate +CashTransactions+++++=====::${secondPickedDate}");
                          });
                          Future.delayed(Duration(seconds: 3), () {
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
                          child: Container(
                            child: DataTable(
                              showCheckboxColumn: true,
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1),
                              columns: [
                                DataColumn(
                                  label: Center(child: Text('Tr.Id')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Date')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Tr.Type')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Account Name')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Received Amount')),
                                ),
                                DataColumn(
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
