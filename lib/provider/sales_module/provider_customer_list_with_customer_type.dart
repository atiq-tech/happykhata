import 'package:flutter/material.dart';
import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../Api_Integration/Api_Modelclass/sales_module/customer_list_model.dart';

class CustomerListByCustomerTypeProvider extends ChangeNotifier {
  List<CustomerListModel> provideCustomerListByCustomerType = [];
  getCustomerListByCustomerTypeData(BuildContext context,
      {String? customerType}) async {
    provideCustomerListByCustomerType = await AllApiImplement.FetchCustomerListWithCustomerType(context, customerType);
    provideCustomerListByCustomerType.insert(0, CustomerListModel(displayName: "General Customer"));
    notifyListeners();
  }
}
