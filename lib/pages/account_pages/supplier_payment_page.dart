import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_supplier_payment/Api_all_add_supplier_payment.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_bank_accounts/Api_all_bank_accounts.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_suppliers/api_all_suppliers.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/all_bank_account_model_class.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_suppliers_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

class SupplierPaymentPage extends StatefulWidget {
  const SupplierPaymentPage({super.key});

  @override
  State<SupplierPaymentPage> createState() => _SupplierPaymentPageState();
}

class _SupplierPaymentPageState extends State<SupplierPaymentPage> {

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController supplierController = TextEditingController();
  //
  String? firstPickedDate;
  String? backEndFirstDate;

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
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
    }
  }

  String? getTransactionType;
  String? _transactionType = 'Receive';
  final List<String> _transactionTypeList = [
    'Receive',
    'Payment',
  ];
  bool isBankListClicked = false;
  String? _paymentType = 'Cash';
  final List<String> _paymentTypeList = [
    'Cash',
    'Bank',
  ];
  String? _selectedBank;

  String? _selectedSupplier;
  ApiAllBankAccounts? apiAllBankAccounts;
  ApiAllSuppliers? apiAllSuppliers;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    getTransactionType = 'CR';

    Provider.of<CounterProvider>(context, listen: false)
        .getBankAccounts(context);

    Provider.of<CounterProvider>(context, listen: false).getSupplier(context);

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
    // Suppliers
    final allSuppliersData =
        Provider.of<CounterProvider>(context).allSupplierslist;
    print("Suppliers payment list length is==  ${allSuppliersData.length}");
    //Get Supplier Payment
    final allGetSupplierPaymentData =
        Provider.of<CounterProvider>(context).allGetSupplierPaymentlist;
    print(
        "GSP GSP GSP GSP GSP GSP GSP GSP GSP GSP=Lenght is:::::${allGetSupplierPaymentData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Supplier Payment"),
      body: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: isBankListClicked ? 350 : 320.0,
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
                      const SizedBox(height: 3.0),
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
                              "Supplier",
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
                              child: TypeAheadFormField(
                                textFieldConfiguration:
                                TextFieldConfiguration(
                                    onChanged: (value){
                                      if (value == '') {
                                        _selectedSupplier = '';
                                      }
                                    },
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    controller: supplierController,
                                    decoration: InputDecoration(
                                      hintText: 'Select Supplier',
                                      suffix: _selectedSupplier == '' ? null : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            supplierController.text = '';
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
                                  allSuppliersData.removeAt(0);
                                  return allSuppliersData
                                      .where((element) => element.supplierName.toString()
                                      .toLowerCase()
                                      .contains(pattern
                                      .toString()
                                      .toLowerCase()))
                                      .take(allSuppliersData.length)
                                      .toList();
                                  // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: SizedBox(child: Text("${suggestion.supplierName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  );
                                },
                                transitionBuilder:
                                    (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected:
                                    (AllSuppliersClass suggestion) {
                                  supplierController.text = suggestion.supplierName!;
                                  setState(() {
                                    _selectedSupplier =
                                        suggestion.supplierSlNo;
                                    print(
                                        "Customer Wise Category ID ========== > ${suggestion.supplierSlNo} ");
                                  });
                                },
                                onSaved: (value) {},
                              ),

                              // child: DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //     isExpanded: true,
                              //     hint: Text(
                              //       'Select Supplier',
                              //       style: TextStyle(
                              //         fontSize: 14,
                              //       ),
                              //     ), // Not necessary for Option 1
                              //     value: _selectedSupplier,
                              //     onChanged: (newValue) {
                              //       setState(() {
                              //         _selectedSupplier = newValue!.toString();
                              //       });
                              //     },
                              //     items: allSuppliersData.map((location) {
                              //       return DropdownMenuItem(
                              //         child: Text(
                              //           "${location.supplierName}",
                              //           style: TextStyle(
                              //             fontSize: 14,
                              //           ),
                              //         ),
                              //         value: location.supplierSlNo,
                              //       );
                              //     }).toList(),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3.0),
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
                      //           controller: _DuoController,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             focusedBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: Color.fromARGB(255, 7, 125, 180),
                      //               ),
                      //               borderRadius: BorderRadius.circular(10.0),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderSide: BorderSide(
                      //                 color: Color.fromARGB(255, 7, 125, 180),
                      //               ),
                      //               borderRadius: BorderRadius.circular(10.0),
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
                              height: 35.0,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                controller: _descriptionController,
                                decoration: InputDecoration(
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
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
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
                      const SizedBox(height: 7.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              ApiAllAddSupplierPayment.isBtnClk = true;

                              ApiAllAddSupplierPayment
                                  .getApiAllAddSupplierPayment(
                                context,
                                "$_paymentType",
                                "$getTransactionType",
                                _amountController.text,
                                "$_selectedSupplier",
                                "$backEndFirstDate",
                                0,
                                _descriptionController.text,
                                "$_selectedBank",
                              );

                              _descriptionController.text = "";
                              supplierController.text = '';
                              _amountController.text = "";

                              Provider.of<CounterProvider>(context,
                                  listen: false)
                                  .getGetSupplierPayment(
                                  context,
                                  "$backEndFirstDate",
                                  "$backEndFirstDate");
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
                                  child: ApiAllAddSupplierPayment.isBtnClk ? const SizedBox(height: 20,width:20,child: CircularProgressIndicator(color: Colors.white,)) : const Text(
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
                              _descriptionController.text = "";
                              supplierController.text = '';
                              _amountController.text = "";
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
              //   padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
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
                            label: Center(child: Text('Supplier')),
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
                          allGetSupplierPaymentData.length,
                              (int index) => DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].sPaymentInvoice}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].sPaymentDate}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].supplierName}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].transactionType}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].paymentBy}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].sPaymentAmount}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].sPaymentNotes}')),
                              ),
                              DataCell(
                                Center(
                                    child: Text(
                                        '${allGetSupplierPaymentData[index].sPaymentAddby}')),
                              ),
                            ],
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
