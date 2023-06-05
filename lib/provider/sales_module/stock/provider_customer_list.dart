import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../../Api_Integration/Api_Modelclass/sales_module/customer_list_model.dart';
import 'package:flutter/material.dart';

class CustomerListProvider extends ChangeNotifier {
  List<CustomerListModel> provideCustomerList = [];
  getCustomerListData(BuildContext context) async {
    provideCustomerList = await AllApiImplement.FetchCustomerList(context);
    notifyListeners();
  }
}
