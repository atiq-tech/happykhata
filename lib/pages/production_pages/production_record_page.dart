import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poss/Api_Integration/Api_All_implement/Atik/Api_All_get_production_record/production_record_api.dart';
import 'package:poss/common_widget/custom_appbar.dart';
import 'package:intl/intl.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/utils/utils.dart';
import 'package:provider/provider.dart';

class ProductionRecordPage extends StatefulWidget {
  const ProductionRecordPage({super.key});

  @override
  State<ProductionRecordPage> createState() => _ProductionRecordPageState();
}

class _ProductionRecordPageState extends State<ProductionRecordPage> {
  final TextEditingController _DateController = TextEditingController();
  final TextEditingController _Date2Controller = TextEditingController();

  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondDate;
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
        print("Firstdateee $firstPickedDate");
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
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
        secondPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndSecondDate = Utils.formatBackEndDate(selectedDate);
        print("Firstdateee $secondPickedDate");
      });
    }
    else{
      setState(() {
        secondPickedDate = Utils.formatFrontEndDate(toDay);
        backEndSecondDate = Utils.formatBackEndDate(toDay);
        print("Firstdateee $secondPickedDate");
      });
    }
  }

  ApiallProductionRecord? apiallProductionRecord;
  @override
  void initState() {
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());
    backEndSecondDate = Utils.formatBackEndDate(DateTime.now());
    secondPickedDate = Utils.formatFrontEndDate(DateTime.now());
    // fetchProductionReport(context,backEndFirstDate,backEndSecondDate);

    // TODO: implement initState
    super.initState();
  }

  fetchProductionReport(context, backEndFirstDate, backEndSecondDate){
    Provider.of<CounterProvider>(context, listen: false)
        .getProductionRecord(
        context,
        "${backEndFirstDate}",
        "${backEndSecondDate}");
  }

  @override
  Widget build(BuildContext context) {
    //Product Record
    final allProductionRecordData =
        Provider.of<CounterProvider>(context).allProductionRecordlist;
    print(
        "ProductionRecord ISSSSSSSSSSSS IS Lenght is:::::${allProductionRecordData.length}");
    return Scaffold(
      appBar: CustomAppBar(title: "Production Record"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              child: Container(
                height: 140.0,
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
                            "Date From",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
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
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: Text(
                            "Date To",
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 125, 125)),
                          ),
                        ),
                        const Expanded(flex: 1, child: Text(":")),
                        Expanded(
                          flex: 11,
                          child: SizedBox(
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
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            ApiallProductionRecord.isLoading = true;
                            print(
                                "firstDate ++++ProductionRecord=====::${backEndFirstDate}");
                            print(
                                "secondDate ++++ProductionRecord=====::${backEndSecondDate}");
                          });
                          fetchProductionReport(context, backEndFirstDate, backEndSecondDate);

                          // Future.delayed(const Duration(seconds: 3), () {
                          //   setState(() {
                          //     isLoading = false;
                          //   });
                          // });
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
            ApiallProductionRecord.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
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
                            border: TableBorder.all(
                                color: Colors.black54, width: 1),
                            columns: const [
                              DataColumn(
                                label: Center(child: Text('Production Id.')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Date')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Incharge')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Shift')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Total Cost')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Note')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Product Name')),
                              ),
                              DataColumn(
                                label: Center(child: Text('Quantity')),
                              ),
                            ],
                            rows: List.generate(
                              allProductionRecordData.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].productionSl}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].date}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].inchargeName}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].shift}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].totalCost}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: Text(
                                            '${allProductionRecordData[index].note}')),
                                  ),
                                  DataCell(
                                    Center(
                                        child: SizedBox(
                                          // color: Colors.green,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.5,
                                          child: ListView.builder(
                                            scrollDirection:
                                            Axis.vertical,
                                            itemCount:
                                            allProductionRecordData[
                                            index]
                                                .products!
                                                .length,
                                            itemBuilder: (context, j) {
                                              return Container(
                                                decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                child: Center(
                                                  child: Text(
                                                      "${allProductionRecordData[index].products![j].name}"),
                                                ),
                                              );
                                            },
                                          ),
                                        )),
                                  ),
                                  DataCell(
                                    Center(
                                        child: SizedBox(
                                          // color: Colors.green,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.5,
                                          child: ListView.builder(
                                            scrollDirection:
                                            Axis.vertical,
                                            itemCount:
                                            allProductionRecordData[
                                            index]
                                                .products!
                                                .length,
                                            itemBuilder: (context, j) {
                                              return Container(
                                                decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 0.05)),
                                                child: Center(
                                                  child: Text(
                                                      "${allProductionRecordData[index].products![j].quantity}"),
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
          ],
        ),
      ),
    );
  }
}
