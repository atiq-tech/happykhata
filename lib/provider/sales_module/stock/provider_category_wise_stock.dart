import 'package:flutter/material.dart';
import 'package:poss/Api_Integration/Api_Modelclass/sales_module/category_wise_stock_model.dart';
import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';

class CategoryWiseStockProvider extends ChangeNotifier {
  List<CategoryWiseStockModel> provideCategoryWiseStockList = [];
  Future<List<CategoryWiseStockModel>>getCategoryWiseStockData(BuildContext context,
      {String? categoryId}) async {
    provideCategoryWiseStockList = await AllApiImplement.FetchCategoryWiseStock(categoryId);
    return provideCategoryWiseStockList;
    notifyListeners();
  }
}
