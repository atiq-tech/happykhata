import 'package:flutter/material.dart';
import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';
import '../../../Api_Integration/Api_Modelclass/sales_module/current_stock_model.dart';

class CurrentStockProvider extends ChangeNotifier {
  List<Stock> provideCurrentStockList = [];
  getAllCurrentStockData(BuildContext context) async {
    provideCurrentStockList = await AllApiImplement.FetchCurrentStock(context);
    notifyListeners();
  }
}
