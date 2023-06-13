import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poss/drawer_section/mydrawersection.dart';
import 'package:poss/login_page/log_in_page.dart';
import 'package:poss/pages/account_pages/bank_transaction_page.dart';
import 'package:poss/pages/account_pages/bank_transaction_report_page.dart';
import 'package:poss/pages/account_pages/cash_statement_page.dart';
import 'package:poss/pages/account_pages/cash_transaction.dart';
import 'package:poss/pages/account_pages/cash_transaction_report_page.dart';
import 'package:poss/pages/account_pages/cash_view_page.dart';
import 'package:poss/pages/account_pages/customer_pay_reciev_page.dart';
import 'package:poss/pages/account_pages/supplier_payment_page.dart';
import 'package:poss/pages/administration_pages/customer_entry_page.dart';
import 'package:poss/pages/administration_pages/product_entry_page.dart';
import 'package:poss/pages/administration_pages/product_ledger_page.dart';
import 'package:poss/pages/administration_pages/supplier_entry_page.dart';
import 'package:poss/pages/production_pages/meterial_purchase_page.dart';
import 'package:poss/pages/production_pages/meterial_purchase_record.dart';
import 'package:poss/pages/production_pages/production_entry_page.dart';
import 'package:poss/pages/production_pages/production_record_page.dart';
import 'package:poss/pages/purchase_module/purchase_entry/purchase_entry.dart';
import 'package:poss/pages/purchase_module/purchase_record.dart';
import 'package:poss/pages/purchase_module/reorder_list.dart';
import 'package:poss/pages/purchase_module/supplier_due_report.dart';
import 'package:poss/pages/purchase_module/supplier_payment_report.dart';
import 'package:poss/pages/report_module/profit&loss_report_page.dart';
import 'package:poss/pages/sales_module/customer_due_list.dart';
import 'package:poss/pages/sales_module/customer_list.dart';
import 'package:poss/pages/sales_module/customer_payment_history.dart';
import 'package:poss/pages/sales_module/customer_payment_report.dart';
import 'package:poss/pages/sales_module/sales_entry/sales_entry.dart';
import 'package:poss/pages/sales_module/sales_record.dart';
import 'package:poss/pages/sales_module/stock_report.dart';
import 'package:poss/provider/providers/counter_provider.dart';
import 'package:poss/provider/sales_module/sales_record/provider_sales_data.dart';
import 'package:poss/provider/sales_module/stock/provider_category_wise_stock.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.name});
  final String? name;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    /////////All User ///////////
    Provider.of<AllProductProvider>(context, listen: false)
        .FetchUserByUsergetAllSaleProduct(context);
    /////////All Employee ///////////
    Provider.of<AllProductProvider>(context, listen: false)
        .Fatch_By_all_Employee(context, customerId: "", dateFrom: "",employeeId:  "", productId: "",userFullName:  "", dateTo: "");
    /////////All Customer ///////////
    Provider.of<AllProductProvider>(context, listen: false)
        .Fatch_By_all_Customer(context, customerId: "", dateFrom: "", dateTo: "", employeeId: "", productId: "", userFullName: "");
    /////////All Category ///////////
    Provider.of<CategoryWiseStockProvider>(context, listen: false)
        .getCategoryWiseStockData(context, categoryId: "");
    /////////All Product ///////////
    Provider.of<AllProductProvider>(context, listen: false)
        .FetchAllProduct(context);
    /////////All Supplier ///////////
    Provider.of<CounterProvider>(context, listen: false).getSupplier(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerSection(
        name: widget.name,
      ),
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: const Color.fromARGB(255, 7, 125, 180),
        title: const Text(
          "POS EXPRESS",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        actions: [
          Row(
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRw8tnmRAobUlTWwXTzG0yJevfymCAQw00wZw&usqp=CAU'),
                  ),
                  Text(
                    "Welcome,${widget.name}",
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60.0),
                            child: Dialog(
                              child: Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, bottom: 10.0),
                                      child: Text("Profile",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    const Divider(
                                        thickness: 0.5,
                                        color: Colors.grey,
                                        height: 1.0),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0, top: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LogInPage()));
                                        },
                                        child: const Text("Logout",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.arrow_drop_down))
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromARGB(255, 7, 125, 180),
              height: 100.0,
              width: double.infinity,
              padding:
                  const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 70,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                    ),
                    itemCount: headTitle.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50.0,
                        width: 80,
                        margin: const EdgeInsets.only(
                          right: 4,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                "${headTitle[index]['name']}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 125, 180),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "105k",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.robotoSlab(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 253, 253, 253),
                            borderRadius: BorderRadius.circular(5.0)),
                      );
                    },
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sales",
                          style: TextStyle(
                              color: Colors.black54,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: salesList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => salesPages[index],
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "${salesList[index]['image']}"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "${salesList[index]['name']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    child: const Text(
                      "Purchase",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: purchaseList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => purchasepage[index],
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "${purchaseList[index]['image']}"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "${purchaseList[index]['name']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      // color: Color.fromARGB(255, 7, 125, 180),
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    child: const Text(
                      "Production",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ProductionList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        _ProductionListPages[index],
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "${ProductionList[index]['image']}"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "${ProductionList[index]['name']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      // color: Color.fromARGB(255, 7, 125, 180),
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    child: const Text(
                      "Account",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: accountList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        accountListPage[index],
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "${accountList[index]['image']}"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "${accountList[index]['name']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      // color: Color.fromARGB(255, 7, 125, 180),
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: const Text(
                      "Administator",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Administator.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        _administatorPages[index],
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        "${Administator[index]['image']}"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    "${Administator[index]['name']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      // color: Color.fromARGB(255, 7, 125, 180),
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    child: const Text(
                      "Report Module",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          mainAxisExtent: 110,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfitLossReportPage(),
                                  ));
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue[50],
                              elevation: 9.00,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage("all_picture/paal.png"),
                                    height: 30,
                                    width: 35,
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "Profit & loss",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      // color: Color.fromARGB(255, 7, 125, 180),
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.w900);
  }

  List salesList = [
    {"name": "Sales Entry", "image": "all_picture/sales_entry.png"},
    {"name": "Sales Record", "image": "all_picture/sales_record.png"},
    {"name": "Stock", "image": "all_picture/stock.png"},
    {"name": "Due List", "image": "all_picture/due_list.png"},
    {"name": "Customer Payment Report", "image": "all_picture/cpr.png"},
    {"name": "Customer Payment History", "image": "all_picture/cph.png"},
    {"name": "Customer List", "image": "all_picture/custlist.png"},
  ];

  List purchaseList = [
    {"name": "Purchase Entry", "image": "all_picture/purchase_entry.png"},
    {"name": "Purchase Record", "image": "all_picture/purcashe_record.png"},
    {"name": "Supplier due report", "image": "all_picture/sdr.png"},
    {"name": "Supplier payment report", "image": "all_picture/spr.png"},
    {"name": "ReOrder list", "image": "all_picture/rol.png"},
  ];
  List ProductionList = [
    {"name": "Production Entry", "image": "all_picture/production_entry.png"},
    {"name": "Production Record", "image": "all_picture/production_record.png"},
    {"name": "Material purchase", "image": "all_picture/mp.png"},
    {"name": "Material purchase Record", "image": "all_picture/mpr.png"},
  ];

  List accountList = [
    {"name": "Cash Transaction", "image": "all_picture/cashtrans.png"},
    {"name": "Bank Transaction", "image": "all_picture/btrans.png"},
    {"name": "Customer Payment", "image": "all_picture/custpay.png"},
    {"name": "Supplier Payment", "image": "all_picture/spr.png"},
    {"name": "Cash View", "image": "all_picture/cashview.png"},
    {
      "name": "Cash Transaction Report",
      "image": "all_picture/cashtransrep.png"
    },
    {"name": "Bank Transaction Report", "image": "all_picture/btr.png"},
    {"name": "Cash Statement", "image": "all_picture/cashstate.png"},
  ];
  // List accountListPage = [
  //   CashTransactionPage(),
  //   BankTransactionPage(),
  //   CustomerPayRecivePage(),
  //   CashTransactionPage(),
  //   BankTransactionPage(),
  //   CustomerPayRecivePage(),
  //   CashTransactionPage(),
  //   BankTransactionPage(),
  // ];
  List accountListPage = [
    const CashTransactionPage(),
    const BankTransactionPage(),
    const CustomerPaymentPage(),
    const SupplierPaymentPage(),
    const CashViewPage(),
    const CashTransactionReportPage(),
    const BankTransactionReportPage(),
    const CashStatementPage(),
  ];
  List _ProductionListPages = [
    const ProductionEntryPage(),
    const ProductionRecordPage(),
    const MeterialPurchasePage(),
    const MeterialPurchaseRecord(),
  ];
  List _administatorPages = [
    const ProductEntryPage(),
    const ProductLedgerPage(),
    const CustomerEntryPage2(),
    const SupplierEntryPage(),
  ];
  List Administator = [
    {"name": "Product Entry", "image": "all_picture/production_entry.png"},
    {"name": "Product Ledger", "image": "all_picture/production_record.png"},
    {"name": "Customer Entry", "image": "all_picture/customer_entry.png"},
    {"name": "Supplier Entry", "image": "all_picture/suppay.png"},
  ];

  List headTitle = [
    {"name": "Today Sale", "countPrice": "40k"},
    {"name": "Monthly", "countPrice": "500k"},
    {"name": "Total Due", "countPrice": "80k"},
    {"name": "Cash", "countPrice": "150k"},
  ];

  List salesPages = [
    const SalesEntryPage(),
    const SalesRecordPage(),
    const StockReportPage(),
    const Customer_Due_List(),
    const Customer_Payment_Report(),
    const Customer_Payment_History(),
    const Customer_List(),
  ];
  List purchasepage = [
    const PurchaseEntryPage(),
    const PurchaseRecord(),
    const SupplierDueReport(),
    const SupplierPaymentReport(),
    const ReorderList()
  ];
}
