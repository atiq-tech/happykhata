import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_customer_payment/Api_all_add_customer_payment.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_accounts/Api_all_bank_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_customers/Api_all_customers.dart';
import 'package:poss/Api_Integration/Api_Modelclass/Uzzal_All_Model_Class/by_All_customer_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/customer_list_model.dart';

import 'package:poss/common_widget/custom_appbar.dart';

import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/provider_customer_list_with_customer_type.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/utils/utils.dart';

import 'package:provider/provider.dart';

class CustomerPaymentPage extends StatefulWidget {
  const CustomerPaymentPage({super.key});
  @override
  State<CustomerPaymentPage> createState() => _CustomerPaymentPageState();
}

class _CustomerPaymentPageState extends State<CustomerPaymentPage> {
  final TextEditingController _transactionTypeController =
  TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();
  final TextEditingController _DueController = TextEditingController();
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _AmountController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController customerController = TextEditingController();

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

  String? getTransactionType;
  String? _transactionType = "Receive";
  final List<String> _transactionTypeList = [
    'Receive',
    'Payment',
  ];

  bool isBankListClicked = false;
  String? getPaymentType;
  String? _paymentType = 'Cash';
  final List<String> _paymentTypeList = [
    'Cash',
    'Bank',
  ];
  String? _selectedBank;

  String? getCustomerType;
  String? _customerType = "Retail";
  final List<String> _customerTypeList = [
    'Retail',
    'Wholesale',
  ];
  String? _selectedCustomer;

  ApiAllBankAccounts? apiAllBankAccounts;
  ApiAllCustomers? apiAllCustomers;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    getTransactionType = "CR";
    getPaymentType = "cash";
    getCustomerType = "retail";

    //bank ACCOUNTS
    Provider.of<CounterProvider>(context, listen: false)
        .getBankAccounts(context);
    //Customers
    ApiAllCustomers apiAllCustomers;
    Provider.of<CustomerListByCustomerTypeProvider>(context, listen: false).getCustomerListByCustomerTypeData(context,customerType: getCustomerType);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bank accounts
    final allBankAccountsData =
        Provider.of<CounterProvider>(context).allBankAccountlist;
    print(
        "BankAccounts Accounts bank Accounts =Lenght is:::::${allBankAccountsData.length}");
    //Customers
    final allCustomersData =
        Provider.of<CustomerListByCustomerTypeProvider>(context).provideCustomerListByCustomerType;
    print("Customers new Customers =Lenght is:::::${allCustomersData.length}");
    //Get CustomerPayment
    final allGetCustomerPaymentData =
        Provider.of<CounterProvider>(context).allGetCustomerPaymentlist;
   print(
        "GCP GCP GCP GCP GCP GCP GCP GCP=Lenght is:::::${allGetCustomerPaymentData.length}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "Customer Payment",
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: isBankListClicked ? 350.0 : 320,
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
                                  hint: const Text(
                                    'Select Type',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  dropdownColor: const Color.fromARGB(255, 231, 251,
                                      255), // Not necessary for Option 1
                                  value: _transactionType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _transactionType = newValue!;
                                      if (newValue == "Receive") {
                                        getTransactionType = "CR";
                                      }
                                      if (newValue == "Payment") {
                                        getTransactionType = "CP";
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
                      Container(
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 6,
                              child: Text(
                                "Payment Type",
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
                                    value: _paymentType,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _paymentType = newValue!;

                                        if (newValue == "Cash") {
                                          getPaymentType = "cash";
                                        }
                                        if (newValue == "Bank") {
                                          getPaymentType = "bank";
                                        }
                                        _paymentType == "Bank"
                                            ? isBankListClicked = true
                                            : isBankListClicked = false;
                                      });
                                    },
                                    items: _paymentTypeList.map((location) {
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
                      ),
                      const SizedBox(height: 3.0),
                      isBankListClicked == true
                          ? Container(
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 6,
                              child: Text(
                                "Bank account",
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        255, 126, 125, 125)),
                              ),
                            ),
                            const Expanded(flex: 1, child: Text(":")),
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 40.0,
                                width:
                                MediaQuery.of(context).size.width / 2,
                                padding: const EdgeInsets.only(left: 5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    const Color.fromARGB(255, 5, 107, 155),
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(10.0),
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
                                                _selectedBank = '';
                                              }
                                            },
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                            controller: bankController,
                                            decoration: InputDecoration(
                                              hintText: 'Select Account',
                                              suffix: _selectedBank == '' ? null : GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    bankController.text = '';
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
                                            title: SizedBox(child: Text("${suggestion.accountName} - ${suggestion.accountNumber} (${suggestion.bankName})",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                          );
                                        },
                                        transitionBuilder:
                                            (context, suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected:
                                            (AllBankAccountModelClass suggestion) {
                                              bankController.text = "${suggestion.accountName}-${suggestion.accountNumber} (${suggestion.bankName})";
                                          setState(() {
                                            _selectedBank = suggestion.accountId.toString();
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
                                //     dropdownColor: Color.fromARGB(
                                //         255,
                                //         231,
                                //         251,
                                //         255), // Not necessary for Option 1
                                //     value: _selectedBank,
                                //     onChanged: (newValue) {
                                //       setState(() {
                                //         _selectedBank =
                                //             newValue!.toString();
                                //       });
                                //     },
                                //     items: allBankAccountsData
                                //         .map((location) {
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
                      )
                          : Container(),

                      const SizedBox(height: 3.0),
                      Row(
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text(
                              "Customer Type",
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
                                  value: _customerType,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _customerType = newValue!;
                                      if (newValue == "Retail") {
                                        getCustomerType = "retail";
                                        Provider.of<CustomerListByCustomerTypeProvider>(context, listen: false).getCustomerListByCustomerTypeData(context,customerType: getCustomerType);

                                      }
                                      if (newValue == "Wholesale") {
                                        getCustomerType = "wholesale";
                                        Provider.of<CustomerListByCustomerTypeProvider>(context, listen: false).getCustomerListByCustomerTypeData(context,customerType: getCustomerType);
                                      }
                                    });
                                  },
                                  items: _customerTypeList.map((location) {
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
                      const SizedBox(height: 6.0),

                      Row(
                        children: [
                          const Expanded(
                            flex: 6,
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
                              height: 40.0,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 5, 107, 155),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TypeAheadFormField(
                                textFieldConfiguration:
                                TextFieldConfiguration(
                                  onChanged: (value){
                                    if (value == '') {
                                      _selectedCustomer = '';
                                    }
                                  },
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                  controller: customerController,
                                  decoration: InputDecoration(
                                    hintText: 'Select Customer',
                                    suffix: _selectedCustomer == '' ? null : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          customerController.text = '';
                                        });
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 3),
                                        child: Icon(Icons.close,size: 14,),
                                      ),
                                    ),
                                  ),
                                ),
                                suggestionsCallback: (pattern) {
                                  allCustomersData.removeAt(0);
                                  return allCustomersData
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
                                    title: SizedBox(child: Text("${suggestion.displayName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected:
                                    (CustomerListModel suggestion) {
                                  customerController.text = suggestion.displayName!;
                                  setState(() {
                                    _selectedCustomer = suggestion.customerSlNo.toString();
                                  });
                                },
                                onSaved: (value) {},
                              ),

                              // child: DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //     isExpanded: true,
                              //     hint: Text(
                              //       'Select Customer',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //       ),
                              //     ), // Not necessary for Option 1
                              //     value: _selectedCustomer,
                              //     onChanged: (newValue) {
                              //       setState(() {
                              //         _selectedCustomer = newValue!.toString();
                              //       });
                              //     },
                              //     items: allCustomersData.map((location) {
                              //       return DropdownMenuItem(
                              //         child: Text(
                              //           "${location.customerName}",
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         value: location.customerSlNo,
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                         // SizedBox(height: 5.0),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 6,
                      //       child: Text(
                      //         "Due",
                      //         style: TextStyle(
                      //             color: Color.fromARGB(255, 126, 125, 125)),
                      //       ),
                      //     ),
                      //     Expanded(flex: 1, child: Text(":")),
                      //     Expanded(
                      //       flex: 11,
                      //       child: Container(
                      //         height: 28.0,
                      //         width: MediaQuery.of(context).size.width / 2,
                      //         child: TextField(
                      //           controller: _DueController,
                      //           decoration: InputDecoration(
                      //             contentPadding: EdgeInsets.symmetric(
                      //                 vertical: 5.0, horizontal: 10.0),
                      //             border: InputBorder.none,
                      //             focusedBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: Color.fromARGB(255, 7, 125, 180),
                      //               ),
                      //               borderRadius: BorderRadius.circular(12.0),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: Color.fromARGB(255, 7, 125, 180),
                      //               ),
                      //               borderRadius: BorderRadius.circular(12.0),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Row(
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text(
                              "Payment Date",
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
                      Row(
                        children: [
                          const Expanded(
                            flex: 6,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: SizedBox(
                              height: 28.0,
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
                            flex: 6,
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 125, 125)),
                            ),
                          ),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 11,
                            child: SizedBox(
                              height: 28.0,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                controller: _AmountController,
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
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('jkasdfgjkas $_paymentType rsfgasdf $getTransactionType sdgfsdfg $_selectedCustomer');

                              FocusScope.of(context).requestFocus(FocusNode());

                              ApiAllAddCustomerPayment.isBtnClk = true;

                              ApiAllAddCustomerPayment
                                  .getApiAllAddCustomerPayment(
                                context,
                                "$_paymentType",
                                "$getTransactionType",
                                _AmountController.text,
                                "$_selectedCustomer",
                                "$backEndFirstDate",
                                0,
                                _DescriptionController.text,
                                _DueController.text,
                                "$_selectedBank",
                              );

                              _DescriptionController.text = "";
                              customerController.text = '';
                              _AmountController.text = "";

                              Provider.of<CounterProvider>(context,
                                  listen: false)
                                  .getGetCustomerPayment(
                                  context,
                                  backEndFirstDate,
                                  backEndFirstDate);
                            },
                            child: Container(
                              height: 35.0,
                              width: 85.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 88, 204, 91),
                                    width: 2.0),
                                color: const Color.fromARGB(255, 5, 114, 165),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                  child: ApiAllAddCustomerPayment.isBtnClk ? const SizedBox(height: 20,width:20,child: CircularProgressIndicator(color: Colors.white,)) : const Text(
                                    "Save",
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
                              _DescriptionController.text = "";
                              customerController.text = '';
                              _AmountController.text = "";
                            },
                            child: Container(
                              height: 35.0,
                              width: 85.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(255, 88, 204, 91),
                                    width: 2.0),
                                color: const Color.fromARGB(255, 252, 33, 4),
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
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: DataTable(
                          showCheckboxColumn: true,
                          border:
                          TableBorder.all(color: Colors.black54, width: 1),
                          columns: const [
                            DataColumn(
                              label: Center(child: Text('Transaction Id')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Date')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Customer Name')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Customer Type')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Transaction Type')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Payment by')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Amount')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Description')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Save By')),
                            ),
                          ],
                          rows: List.generate(
                            allGetCustomerPaymentData.length,
                                (int index) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].cPaymentInvoice}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].cPaymentDate}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].customerName}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].customerType}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].transactionType}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].paymentBy}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].cPaymentAmount}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].cPaymentNotes}')),
                                ),
                                DataCell(
                                  Center(
                                      child: Text(
                                          '${allGetCustomerPaymentData[index].cPaymentAddby}')),
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