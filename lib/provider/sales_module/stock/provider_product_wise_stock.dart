import 'package:flutter/material.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/product_wise_stock_model.dart';
import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';

class ProductWiseStockProvider extends ChangeNotifier {
  List<ProductWiseStockModel> provideProductWiseStockList = [];
  getProductWiseStockData(BuildContext context, String? productId) async {
    provideProductWiseStockList = await AllApiImplement.FetchProductWiseStock(productId);
    notifyListeners();
  }
}
