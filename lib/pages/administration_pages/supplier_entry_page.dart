import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_add_supplier/Api_all_add_supplier.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_all_get_suppliers/api_all_suppliers.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:poss/const_page.dart';
import 'package:http/http.dart' as http;
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

class SupplierEntryPage extends StatefulWidget {
  const SupplierEntryPage({super.key});

  @override
  State<SupplierEntryPage> createState() => _SupplierEntryPageState();
}

class _SupplierEntryPageState extends State<SupplierEntryPage> {
  final TextEditingController _supplierIdController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _previousDueController = TextEditingController();

  ApiAllSuppliers? apiAllSuppliers;
  @override
  void initState() {
    //get Suppliers
    ApiAllSuppliers apiAllSuppliers;

    getSuppliers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //get Suppliers
    final allSuppliersData =
        Provider.of<CounterProvider>(context).allSupplierslist;
    print(
        "Suppliers Suppliers Suppliers=Lenght is:::::${allSuppliersData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Supplier Entry"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              child: Container(
                height: 245.0,
                width: double.infinity,
                padding: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 5, 107, 155),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     const Expanded(
                    //       flex: 5,
                    //       child: Text(
                    //         "Supplier Id",
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
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(
                    //                 color: Color.fromARGB(221, 5, 123, 233))),
                    //         child: TextField(
                    //           enabled: false,
                    //           controller: _supplierIdController,
                    //           keyboardType: TextInputType.phone,
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
                    // SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Supplier Name",
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
                            child: TextField(
                              controller: _supplierNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Owner Name",
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
                            child: TextField(
                              controller: _ownerNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Address",
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
                            child: TextField(
                              controller: _addressController,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Mobile",
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
                            child: TextField(
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Email",
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
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Previous Due",
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
                            child: TextField(
                              controller: _previousDueController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 125, 180),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                    SizedBox(height: 6.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            getSupplierCode();
                          });
                          _AddSupply(context);
                          getSuppliers();
                        },
                        child: Container(
                          height: 35.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 173, 241, 179),
                                width: 2.0),
                            color: Color.fromARGB(255, 75, 90, 131),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
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
            //               backgroundColor: Color.fromARGB(255, 76, 89, 146)),
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
            SizedBox(height: 10.0),
            FutureBuilder(
              future: Provider.of<CounterProvider>(context, listen: false).getSupplier(context),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Container(
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
                              border:
                              TableBorder.all(color: Colors.black54, width: 1),
                              columns: [
                                DataColumn(
                                  label: Center(child: Text('Supplier Id')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Supplier Name')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Contact Person')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Address')),
                                ),
                                DataColumn(
                                  label: Center(child: Text('Contact Number')),
                                ),
                                // DataColumn(
                                //   label: Center(child: Text('Image')),
                                // ),
                              ],
                              rows: List.generate(
                                allSuppliersData.length,
                                    (int index) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSuppliersData[index].supplierCode}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSuppliersData[index].supplierName}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSuppliersData[index].contactPerson}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSuppliersData[index].supplierAddress}')),
                                    ),
                                    DataCell(
                                      Center(
                                          child: Text(
                                              '${allSuppliersData[index].supplierMobile}')),
                                    ),
                                    // DataCell(
                                    //   Center(
                                    //       child: Container(
                                    //           width: 44.0,
                                    //           height: 42.0,
                                    //           color: Colors.black,
                                    //           child: Image.network(
                                    //               "http://testapi.happykhata.com/${allSuppliersData[index].imageName}"))),
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

  XFile? images;
  ImageSource _imageSource = ImageSource.gallery;
  chooseImageFrom() async {
    ImagePicker _picker = ImagePicker();
    images = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  emtyMethod() {
    setState(() {
      supplierId = "";
      _supplierNameController.text = "";

      _mobileController.text = "";

      _emailController.text = "";
      _addressController.text = "";
      _ownerNameController.text = "";

      _previousDueController.text = "";
    });
  }

  _AddSupply(context) async {
    String link = "${BaseUrl}api/v1/addSupplier";
    FormData formData = FormData.fromMap({
      'data': jsonEncode({
        'Supplier_SlNo': 0,
        'Supplier_Code': supplierId.toString().trim(),
        'Supplier_Name': _supplierNameController.text.toString().trim(),
        'Supplier_Mobile': _mobileController.text.toString().trim(),
        'Supplier_Email': _emailController.text.toString().trim(),
        'Supplier_Address': _addressController.text.toString().trim(),
        'contact_person': _ownerNameController.text.toString().trim(),
        'previous_due': _previousDueController.text.toString().trim()
      }),
      "image": ""
      //"image": await MultipartFile.fromFile(images!.path, filename: "fileName"),
    });
    try {
      Response response = await Dio().post(link,
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${GetStorage().read("token")}",
          }));
      var item = jsonDecode(response.data);
      print("SUPPLIER DDDDDDDDDDDATA ${item}");
      print("success============> ${item["success"]}");
      print("message =================> ${item["message"]}");
      print("supplierCode================>  ${item["supplierCode"]}");
      if (item["message"] == "Supplier added successfully") {
        FocusScope.of(context).requestFocus(FocusNode());

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 4, 108, 156),
            duration: Duration(seconds: 2),
            content: Center(child: Text("Supplier added successfull"))));
      } else {
        Center(child: Text("Supplier data added not successfull"));
      }
      emtyMethod();
    } catch (e) {
      return e;
    }
  }

  getSuppliers(){
    Provider.of<CounterProvider>(context, listen: false).getSupplier(context);
  }

  //Get Supplier_Id
  String? supplierId;
  getSupplierCode() async {
    String link = "${BaseUrl}api/v1/getSupplierId";
    try {
      Response response = await Dio().post(
        link,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${GetStorage().read("token")}",
        }),
      );
      print(response.data);
      var supplierId = jsonDecode(response.data);
      print("SupplierId Code===========> $supplierId");
    } catch (e) {
      print(e);
    }
  }
}
