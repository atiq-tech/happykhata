import 'package:flutter/material.dart';
import 'package:poss/Api_Integration/Api_Modelclass/account_module/purchase_model.dart';

import '../../Api_Integration/Api_All_implement/Riaz/all_api_implement.dart';

class GetPurchaseProvider extends ChangeNotifier {
  List<Purchases> providePurchaseList = [];
  getPurchaseData(
    context,
    String? dateFrom,
    String? dateTo,
  ) async {
    providePurchaseList = await AllApiImplement.FetchAllPurchaseData(
      context,
      dateFrom,
      dateTo,
    );
    notifyListeners();
  }
}
