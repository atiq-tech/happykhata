import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_customers/Api_all_customers.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_districes/Api_all_get_districes.dart';
import 'package:poss/Api_Integration/Api_Modelclass/all_get_districes_class.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/const_page.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CustomerEntryPage2 extends StatefulWidget {
  const CustomerEntryPage2({super.key});

  @override
  State<CustomerEntryPage2> createState() => _CustomerEntryPage2State();
}

class _CustomerEntryPage2State extends State<CustomerEntryPage2> {
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _OwnerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _officePhoneController = TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();

  String? _Get_customerType;
  String? _selectedArea;

  ApiAllGetDistricts? apiAllGetDistricts;
  ApiAllCustomers? apiAllCustomers;
  @override
  void initState() {
    //get Products><get unit
    ApiAllGetDistricts apiAllGetDistricts;
    Provider.of<CounterProvider>(context, listen: false).getDistricts(context);
    //get customers
    ApiAllCustomers apiAllCustomers;
    getCustomer();
    // TODO: implement initState
    super.initState();
  }

  getCustomer(){
    Provider.of<CounterProvider>(context, listen: false).getCustomers(context);
  }

  var areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get Districts area
    final allDistrictsData =
        Provider.of<CounterProvider>(context).allDistrictslist;
    print(
        "Districts Districts Districts=======Lenght is:::::${allDistrictsData.length}");
    //get Customer
    final allCustomerData =
        Provider.of<CounterProvider>(context).allCustomerslist;
    print(
        "Customers Customers Customers=======Lenght is:::::${allCustomerData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Customer Entry"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 360.0,
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 6.0,
                  left: 8.0,
                  right: 8.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 6,
                    //       child: Text(
                    //         "Customer Id",
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
                    //           controller: _customerIdController,
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
                    // SizedBox(height: 3.0),

                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Customer Name",
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
                              controller: _customerNameController,
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
                            "Owner Name",
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
                              controller: _OwnerNameController,
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
                            "Address",
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
                              controller: _addressController,
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
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Area",
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
                            child: FutureBuilder(
                              future: Provider.of<CounterProvider>(context).getDistricts(context),
                              builder: (context,
                                  AsyncSnapshot<List<AllGetDistricesClass>> snapshot) {
                                if (snapshot.hasData) {
                                  return TypeAheadFormField(
                                    textFieldConfiguration:
                                    TextFieldConfiguration(
                                        onChanged: (value){
                                          if (value == '') {
                                            _selectedArea = '';
                                          }
                                        },
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                        controller: areaController,
                                        decoration: InputDecoration(
                                          hintText: 'Select Distric',
                                          suffix: _selectedArea == '' ? null : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                areaController.text = '';
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
                                          .where((element) => element.districtName!
                                          .toLowerCase()
                                          .contains(pattern
                                          .toString()
                                          .toLowerCase()))
                                          .take(allDistrictsData.length)
                                          .toList();
                                      // return placesSearchResult.where((element) => element.name.toLowerCase().contains(pattern.toString().toLowerCase())).take(10).toList();
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: SizedBox(child: Text("${suggestion.districtName}",style: const TextStyle(fontSize: 12), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                      );
                                    },
                                    transitionBuilder:
                                        (context, suggestionsBox, controller) {
                                      return suggestionsBox;
                                    },
                                    onSuggestionSelected:
                                        (AllGetDistricesClass suggestion) {
                                      areaController.text = suggestion.districtName!;
                                      setState(() {
                                        _selectedArea =
                                            suggestion.districtSlNo.toString();

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
                            //       'Select area',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //     dropdownColor: Color.fromARGB(255, 231, 251,
                            //         255), // Not necessary for Option 1
                            //     value: _selectedArea,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         _selectedArea = newValue!.toString();
                            //         //getCustomerCode();
                            //       });
                            //     },
                            //     items: allDistrictsData.map((location) {
                            //       return DropdownMenuItem(
                            //         child: Text(
                            //           "${location.districtName}",
                            //           style: TextStyle(
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         value: location.districtSlNo,
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
                          flex: 6,
                          child: Text(
                            "Mobile",
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
                              controller: _mobileController,
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
                            "Office Phone",
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
                              controller: _officePhoneController,
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
                            "Previous Due",
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
                              controller: _previousDueController,
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
                            "Credit Limit",
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
                              controller: _creditLimitController,
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
                    //
                    // Row(
                    //   children: [
                    //     Text(
                    //       "Customer Type      :",
                    //       style: TextStyle(
                    //           color: Color.fromARGB(255, 126, 125, 125)),
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.15,
                    //           child: Radio(
                    //               fillColor: MaterialStateColor.resolveWith(
                    //                 (states) =>
                    //                     Color.fromARGB(255, 5, 114, 165),
                    //               ),
                    //               value: _Get_customerType,
                    //               groupValue: lavel,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   lavel = value.toString();
                    //                   if (value == "Retails") {
                    //                     _Get_customerType = "retail";
                    //                   }
                    //                   if (value == "Wholesale") {
                    //                     _Get_customerType = "wholesale";
                    //                   }
                    //                 });
                    //               }),
                    //         ),
                    //         Text("Retails"),
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.15,
                    //           child: Radio(
                    //               fillColor: MaterialStateColor.resolveWith(
                    //                 (states) =>
                    //                     Color.fromARGB(255, 5, 114, 165),
                    //               ),
                    //               value: _Get_customerType,
                    //               groupValue: lavel,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   lavel = value.toString();
                    //                   if (value == "Wholesale") {
                    //                     _Get_customerType = "wholesale";
                    //                   }
                    //                   if (value == "Retail") {
                    //                     _Get_customerType = "retail";
                    //                   }
                    //                 });
                    //               }),
                    //         ),
                    //         Text("Wholesale"),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    //

                    // SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Customer Type       :",
                          style: TextStyle(
                              color: Color.fromARGB(255, 126, 125, 125)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Radio(
                                value: "retail",
                                groupValue: _Get_customerType,
                                activeColor: const Color.fromARGB(255, 84, 107, 241),
                                onChanged: (value) {
                                  setState(() {
                                    _Get_customerType = value;
                                    print(
                                        "Get_customerType============>$value");
                                  });
                                },
                              ),
                              const Text("Retail"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Radio(
                                value: "wholesale",
                                groupValue: _Get_customerType,
                                activeColor: const Color.fromARGB(255, 84, 107, 241),
                                onChanged: (value) {
                                  setState(() {
                                    _Get_customerType = value;
                                    print(
                                        "Get_customerType============>$value");
                                  });
                                },
                              ),
                              const Text("Wholesale"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            getCustomerCode();
                          });
                          _AddCustomer(context);
                          getCustomer();
                        },
                        child: Container(
                          height: 35.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 173, 241, 179),
                                width: 2.0),
                            color: const Color.fromARGB(255, 94, 136, 84),
                            borderRadius: BorderRadius.circular(8.0),
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
            // Align(
            //   alignment: Alignment.center,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Card(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //             side: BorderSide(
            //                 color: Color.fromARGB(255, 46, 46, 46), width: 2),
            //           ),
            //           elevation: 10.0,
            //           child: images == null
            //               ? Image.network(
            //                   "https://cdn-icons-png.flaticon.com/512/2748/2748558.png",
            //                   height: 150,
            //                   width: 150,
            //                   fit: BoxFit.cover,
            //                 )
            //               : Image.file(
            //                   File(images!.path),
            //                   height: 150,
            //                   width: 150,
            //                   fit: BoxFit.cover,
            //                 )),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Color.fromARGB(255, 68, 82, 146)),
            //           onPressed: () {
            //             _imageSource = ImageSource.gallery;
            //             chooseImageFrom();
            //           },
            //           child: const Text(
            //             "Select Image",
            //             style: TextStyle(
            //               color: Color.fromARGB(255, 249, 254, 255),
            //               fontWeight: FontWeight.w600,
            //               fontSize: 18,
            //             ),
            //           )),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 10.0),
            ///
            FutureBuilder(
              future: Provider.of<CounterProvider>(context, listen: false).getCustomers(context),
                builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(
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
                          // color: Colors.red,
                          // padding:EdgeInsets.only(bottom: 16.0),
                          child: DataTable(
                            showCheckboxColumn: true,
                            border:
                            TableBorder.all(color: Colors.black54, width: 1),
                            columns: [
                              const DataColumn(
                                label: Center(child: Text('Added Date')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Customer Id')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Customer Name')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Owner Name')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Area')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Contact Number')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Customer Type')),
                              ),
                              const DataColumn(
                                label: Center(child: Text('Credit Limit')),
                              ),
                              // DataColumn(
                              //   label: Center(child: Text('Image')),
                              // ),
                            ],
                            rows: List.generate(
                              allCustomerData.length,
                                  (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(
                                        child: Text(
                                            "${DateFormat('dd-MM-yyyy').format(DateTime.parse('${allCustomerData[index].addTime}'))}")),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].customerCode}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].customerName}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].ownerName}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].districtName}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].customerMobile}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].customerType}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allCustomerData[index].customerCreditLimit}')),
                                  ),
                                  // DataCell(
                                  //   Center(
                                  //       child: Container(
                                  //           width: 40.0,
                                  //           height: 40.0,
                                  //           color: Colors.black,
                                  //           child: Image.network(
                                  //               "${allCustomerData[index].imageName}"))),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              else if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else{
               return Container();
              }
            },)
          ],
        ),
      ),
    );
  }

  String? customId;
  getCustomerCode() async {
    String link = "${BaseUrl}api/v1/getCustomerId";
    try {
      var response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      customId = jsonDecode(response.data);
      print("Customer Code===========> $customId");
    } catch (e) {
      print(e);
    }
  }

  XFile? images;
  ImageSource _imageSource = ImageSource.gallery;
  chooseImageFrom() async {
    ImagePicker _picker = ImagePicker();
    images = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
  emtyMethod() {
    setState(() {
      _customerNameController.text = "";
      _Get_customerType = "";
      _mobileController.text = "";
      _officePhoneController.text = "";
      _addressController.text = "";
      _OwnerNameController.text = "";
      areaController.text = "";
      _creditLimitController.text = "";
      _previousDueController.text = "";
    });
  }

  _AddCustomer(context) async {
    String link = "${BaseUrl}api/v1/addCustomer";
    FormData formData = FormData.fromMap({
      "data": jsonEncode({
        "Customer_SlNo": 0,
        "Customer_Code": customId.toString().trim(),
        "Customer_Name": _customerNameController.text.toString().trim(),
        "Customer_Type": _Get_customerType.toString().trim(),
        "Customer_Phone": "",
        "Customer_Mobile": _mobileController.text.toString().trim(),
        "Customer_Email": "",
        "Customer_OfficePhone": _officePhoneController.text.toString().trim(),
        "Customer_Address": _addressController.text.toString().trim(),
        "owner_name": _OwnerNameController.text.toString().trim(),
        "area_ID": _selectedArea.toString().trim(),
        "Customer_Credit_Limit": _creditLimitController.text.toString().trim(),
        "previous_due": _previousDueController.text.toString().trim(),
      }),
      "image": "",

      //"image": await MultipartFile.fromFile(images!.path, filename: "fileName"),
    });
    try {
      var response = await Dio().post(link,
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      print("customer DDDDDDDDDDDATA ${item}");
      print("success============> ${item["success"]}");
      print("message =================> ${item["message"]}");
      print("supplierCode================>  ${item["customerCode"]}");
      if (item["message"] == "Customer added successfully") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Color.fromARGB(255, 4, 108, 156),
            duration: Duration(seconds: 2),
            content: Center(child: Text("Customer added successfull"))));
      } else {
        const Center(child: Text("Customer data added not successfull"));
      }
      emtyMethod();
    } catch (e) {
      return e;
    }
  }
}
//Customer added successfully