import 'package:poss/Api_Integration/Api_Modelclass/sales_module/total_stock_model.dart';
import 'package:flutter/material.dart';
import '../../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';

class TotalStockProvider extends ChangeNotifier {
  List<Stock> provideTotalStockList = [];
  getAllTotalStockData(BuildContext context) async {
    provideTotalStockList = await AllApiImplement.FetchTotalStock(context);
    notifyListeners();
  }
}

class TotalStockWithCategoryProvider extends ChangeNotifier {
  List<Stock> provideTotalStockWithCategoryList = [];
  getAllTotalStockWithCategoryData(BuildContext context, String categoryId) async {
    provideTotalStockWithCategoryList = await AllApiImplement.FetchTotalStockWithCategory(context, categoryId);
    notifyListeners();
  }
}

class TotalStockWithProductProvider extends ChangeNotifier {
  List<Stock> provideTotalStockWithProductList = [];
  getAllTotalStockWithProductData(BuildContext context, String productId) async {
    provideTotalStockWithProductList = await AllApiImplement.FetchTotalStockWithProduct(context, productId);
    notifyListeners();
  }
}
