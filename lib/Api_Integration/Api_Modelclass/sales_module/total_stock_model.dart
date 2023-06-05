// // To parse this JSON data, do
// //
// //     final totalStockModel = totalStockModelFromJson(jsonString);
//
// import 'dart:convert';
//
// TotalStockModel totalStockModelFromJson(String str) => TotalStockModel.fromJson(json.decode(str));
//
// String totalStockModelToJson(TotalStockModel data) => json.encode(data.toJson());
//
// class TotalStockModel {
//   TotalStockModel({
//     this.stock,
//     this.totalValue,
//   });
//
//   final List<Stock>? stock;
//   final double? totalValue;
//
//   factory TotalStockModel.fromJson(Map<String, dynamic> json) => TotalStockModel(
//         stock: json["stock"] == null ? [] : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
//         totalValue: json["totalValue"]?.toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x.toJson())),
//         "totalValue": totalValue,
//       };
// }
//
// class Stock {
//   Stock({
//     this.productSlNo,
//     this.productCode,
//     this.productName,
//     this.productCategoryId,
//     this.color,
//     this.brand,
//     this.size,
//     this.vat,
//     this.productReOrederLevel,
//     this.productPurchaseRate,
//     this.productSellingPrice,
//     this.productMinimumSellingPrice,
//     this.productWholesaleRate,
//     this.oneCartunEqual,
//     this.isService,
//     this.unitId,
//     this.status,
//     this.addBy,
//     this.addTime,
//     this.updateBy,
//     this.updateTime,
//     this.productBranchid,
//     this.productCategoryName,
//     this.brandName,
//     this.unitName,
//     this.purchasedQuantity,
//     this.purchaseReturnedQuantity,
//     this.soldQuantity,
//     this.salesReturnedQuantity,
//     this.damagedQuantity,
//     this.transferredFromQuantity,
//     this.transferredToQuantity,
//     this.productionQuantity,
//     this.currentQuantity,
//     this.stockValue,
//   });
//
//   final String? productSlNo;
//   final String? productCode;
//   final String? productName;
//   final String? productCategoryId;
//   final String? color;
//   final String? brand;
//   final Size? size;
//   final String? vat;
//   final String? productReOrederLevel;
//   final String? productPurchaseRate;
//   final String? productSellingPrice;
//   final String? productMinimumSellingPrice;
//   final String? productWholesaleRate;
//   final String? oneCartunEqual;
//   final String? isService;
//   final String? unitId;
//   final Status? status;
//   final AddBy? addBy;
//   final DateTime? addTime;
//   final UpdateBy? updateBy;
//   final String? updateTime;
//   final String? productBranchid;
//   final ProductCategoryName? productCategoryName;
//   final dynamic brandName;
//   final UnitName? unitName;
//   final String? purchasedQuantity;
//   final String? purchaseReturnedQuantity;
//   final String? soldQuantity;
//   final String? salesReturnedQuantity;
//   final String? damagedQuantity;
//   final String? transferredFromQuantity;
//   final String? transferredToQuantity;
//   final String? productionQuantity;
//   final String? currentQuantity;
//   final String? stockValue;
//
//   factory Stock.fromJson(Map<String, dynamic> json) => Stock(
//         productSlNo: json["Product_SlNo"],
//         productCode: json["Product_Code"],
//         productName: json["Product_Name"],
//         productCategoryId: json["ProductCategory_ID"],
//         color: json["color"],
//         brand: json["brand"],
//         size: sizeValues.map[json["size"]]!,
//         vat: json["vat"],
//         productReOrederLevel: json["Product_ReOrederLevel"],
//         productPurchaseRate: json["Product_Purchase_Rate"],
//         productSellingPrice: json["Product_SellingPrice"],
//         productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
//         productWholesaleRate: json["Product_WholesaleRate"],
//         oneCartunEqual: json["one_cartun_equal"],
//         isService: json["is_service"],
//         unitId: json["Unit_ID"],
//         status: statusValues.map[json["status"]]!,
//         addBy: addByValues.map[json["AddBy"]]!,
//         addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
//         updateBy: updateByValues.map[json["UpdateBy"]]!,
//         updateTime: json["UpdateTime"],
//         productBranchid: json["Product_branchid"],
//         productCategoryName: productCategoryNameValues.map[json["ProductCategory_Name"]]!,
//         brandName: json["brand_name"],
//         unitName: unitNameValues.map[json["Unit_Name"]]!,
//         purchasedQuantity: json["purchased_quantity"],
//         purchaseReturnedQuantity: json["purchase_returned_quantity"],
//         soldQuantity: json["sold_quantity"],
//         salesReturnedQuantity: json["sales_returned_quantity"],
//         damagedQuantity: json["damaged_quantity"],
//         transferredFromQuantity: json["transferred_from_quantity"],
//         transferredToQuantity: json["transferred_to_quantity"],
//         productionQuantity: json["production_quantity"],
//         currentQuantity: json["current_quantity"],
//         stockValue: json["stock_value"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Product_SlNo": productSlNo,
//         "Product_Code": productCode,
//         "Product_Name": productName,
//         "ProductCategory_ID": productCategoryId,
//         "color": color,
//         "brand": brand,
//         "size": sizeValues.reverse[size],
//         "vat": vat,
//         "Product_ReOrederLevel": productReOrederLevel,
//         "Product_Purchase_Rate": productPurchaseRate,
//         "Product_SellingPrice": productSellingPrice,
//         "Product_MinimumSellingPrice": productMinimumSellingPrice,
//         "Product_WholesaleRate": productWholesaleRate,
//         "one_cartun_equal": oneCartunEqual,
//         "is_service": isService,
//         "Unit_ID": unitId,
//         "status": statusValues.reverse[status],
//         "AddBy": addByValues.reverse[addBy],
//         "AddTime": addTime?.toIso8601String(),
//         "UpdateBy": updateByValues.reverse[updateBy],
//         "UpdateTime": updateTime,
//         "Product_branchid": productBranchid,
//         "ProductCategory_Name": productCategoryNameValues.reverse[productCategoryName],
//         "brand_name": brandName,
//         "Unit_Name": unitNameValues.reverse[unitName],
//         "purchased_quantity": purchasedQuantity,
//         "purchase_returned_quantity": purchaseReturnedQuantity,
//         "sold_quantity": soldQuantity,
//         "sales_returned_quantity": salesReturnedQuantity,
//         "damaged_quantity": damagedQuantity,
//         "transferred_from_quantity": transferredFromQuantity,
//         "transferred_to_quantity": transferredToQuantity,
//         "production_quantity": productionQuantity,
//         "current_quantity": currentQuantity,
//         "stock_value": stockValue,
//       };
// }
//
// enum AddBy { ADMIN, GOTOM, RENUKA, ALOMGIR, AL_AMIN }
//
// final addByValues = EnumValues({
//   "Admin": AddBy.ADMIN,
//   "Alomgir": AddBy.ALOMGIR,
//   "Al Amin": AddBy.AL_AMIN,
//   "Gotom": AddBy.GOTOM,
//   "Renuka": AddBy.RENUKA
// });
//
// enum ProductCategoryName {
//   FIXED_ASSET,
//   OTHER,
//   PAPER,
//   KHATA,
//   HAPPY_KHATA,
//   PHOTOSTATE,
//   REGISTER,
//   TALI_KHATA,
//   PRINTING_PAPER,
//   FRESS_TISSUE,
//   TISSUE,
//   FRESS_KHATA,
//   FRESS_PEN,
//   POTTI,
//   INK,
//   TEP,
//   STATIONARY,
//   DAIRY,
//   FILE
// }
//
// final productCategoryNameValues = EnumValues({
//   "Dairy": ProductCategoryName.DAIRY,
//   "File": ProductCategoryName.FILE,
//   "Fixed Asset": ProductCategoryName.FIXED_ASSET,
//   "Fress Khata": ProductCategoryName.FRESS_KHATA,
//   "Fress Pen": ProductCategoryName.FRESS_PEN,
//   "Fress Tissue": ProductCategoryName.FRESS_TISSUE,
//   "Happy Khata": ProductCategoryName.HAPPY_KHATA,
//   "Ink": ProductCategoryName.INK,
//   "Khata": ProductCategoryName.KHATA,
//   "Other": ProductCategoryName.OTHER,
//   "Paper": ProductCategoryName.PAPER,
//   "Photostate": ProductCategoryName.PHOTOSTATE,
//   "Potti": ProductCategoryName.POTTI,
//   "Printing Paper": ProductCategoryName.PRINTING_PAPER,
//   "Register": ProductCategoryName.REGISTER,
//   "Stationary": ProductCategoryName.STATIONARY,
//   "Tali Khata": ProductCategoryName.TALI_KHATA,
//   "Tep ": ProductCategoryName.TEP,
//   "Tissue": ProductCategoryName.TISSUE
// });
//
// enum Size { NA }
//
// final sizeValues = EnumValues({"na": Size.NA});
//
// enum Status { A }
//
// final statusValues = EnumValues({"a": Status.A});
//
// enum UnitName { PCS, REEM, PACKET, K_G }
//
// final unitNameValues =
//     EnumValues({"K.G": UnitName.K_G, "Packet": UnitName.PACKET, "PCS": UnitName.PCS, "Reem": UnitName.REEM});
//
// enum UpdateBy { ADMIN, EMPTY }
//
// final updateByValues = EnumValues({"Admin": UpdateBy.ADMIN, "": UpdateBy.EMPTY});
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

//=============================================================
class Autogenerated {
  List<Stock>? stock;
  int? totalValue;

  Autogenerated({this.stock, this.totalValue});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['stock'] != null) {
      stock = <Stock>[];
      json['stock'].forEach((v) {
        stock!.add(new Stock.fromJson(v));
      });
    }
    totalValue = json['totalValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stock != null) {
      data['stock'] = this.stock!.map((v) => v.toJson()).toList();
    }
    data['totalValue'] = this.totalValue;
    return data;
  }
}

class Stock {
  String? productSlNo;
  String? productCode;
  String? productName;
  String? productCategoryID;
  String? color;
  String? brand;
  String? size;
  String? vat;
  String? productReOrederLevel;
  String? productPurchaseRate;
  String? productSellingPrice;
  String? productMinimumSellingPrice;
  String? productWholesaleRate;
  String? oneCartunEqual;
  String? isService;
  String? unitID;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? productBranchid;
  String? productCategoryName;
  Null? brandName;
  String? unitName;
  String? purchasedQuantity;
  String? purchaseReturnedQuantity;
  String? soldQuantity;
  String? salesReturnedQuantity;
  String? damagedQuantity;
  String? transferredFromQuantity;
  String? transferredToQuantity;
  String? productionQuantity;
  String? currentQuantity;
  String? stockValue;

  Stock(
      {this.productSlNo,
      this.productCode,
      this.productName,
      this.productCategoryID,
      this.color,
      this.brand,
      this.size,
      this.vat,
      this.productReOrederLevel,
      this.productPurchaseRate,
      this.productSellingPrice,
      this.productMinimumSellingPrice,
      this.productWholesaleRate,
      this.oneCartunEqual,
      this.isService,
      this.unitID,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.productBranchid,
      this.productCategoryName,
      this.brandName,
      this.unitName,
      this.purchasedQuantity,
      this.purchaseReturnedQuantity,
      this.soldQuantity,
      this.salesReturnedQuantity,
      this.damagedQuantity,
      this.transferredFromQuantity,
      this.transferredToQuantity,
      this.productionQuantity,
      this.currentQuantity,
      this.stockValue});

  Stock.fromJson(Map<String, dynamic> json) {
    productSlNo = json['Product_SlNo'];
    productCode = json['Product_Code'];
    productName = json['Product_Name'];
    productCategoryID = json['ProductCategory_ID'];
    color = json['color'];
    brand = json['brand'];
    size = json['size'];
    vat = json['vat'];
    productReOrederLevel = json['Product_ReOrederLevel'];
    productPurchaseRate = json['Product_Purchase_Rate'];
    productSellingPrice = json['Product_SellingPrice'];
    productMinimumSellingPrice = json['Product_MinimumSellingPrice'];
    productWholesaleRate = json['Product_WholesaleRate'];
    oneCartunEqual = json['one_cartun_equal'];
    isService = json['is_service'];
    unitID = json['Unit_ID'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    productBranchid = json['Product_branchid'];
    productCategoryName = json['ProductCategory_Name'];
    brandName = json['brand_name'];
    unitName = json['Unit_Name'];
    purchasedQuantity = json['purchased_quantity'];
    purchaseReturnedQuantity = json['purchase_returned_quantity'];
    soldQuantity = json['sold_quantity'];
    salesReturnedQuantity = json['sales_returned_quantity'];
    damagedQuantity = json['damaged_quantity'];
    transferredFromQuantity = json['transferred_from_quantity'];
    transferredToQuantity = json['transferred_to_quantity'];
    productionQuantity = json['production_quantity'];
    currentQuantity = json['current_quantity'];
    stockValue = json['stock_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product_SlNo'] = this.productSlNo;
    data['Product_Code'] = this.productCode;
    data['Product_Name'] = this.productName;
    data['ProductCategory_ID'] = this.productCategoryID;
    data['color'] = this.color;
    data['brand'] = this.brand;
    data['size'] = this.size;
    data['vat'] = this.vat;
    data['Product_ReOrederLevel'] = this.productReOrederLevel;
    data['Product_Purchase_Rate'] = this.productPurchaseRate;
    data['Product_SellingPrice'] = this.productSellingPrice;
    data['Product_MinimumSellingPrice'] = this.productMinimumSellingPrice;
    data['Product_WholesaleRate'] = this.productWholesaleRate;
    data['one_cartun_equal'] = this.oneCartunEqual;
    data['is_service'] = this.isService;
    data['Unit_ID'] = this.unitID;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Product_branchid'] = this.productBranchid;
    data['ProductCategory_Name'] = this.productCategoryName;
    data['brand_name'] = this.brandName;
    data['Unit_Name'] = this.unitName;
    data['purchased_quantity'] = this.purchasedQuantity;
    data['purchase_returned_quantity'] = this.purchaseReturnedQuantity;
    data['sold_quantity'] = this.soldQuantity;
    data['sales_returned_quantity'] = this.salesReturnedQuantity;
    data['damaged_quantity'] = this.damagedQuantity;
    data['transferred_from_quantity'] = this.transferredFromQuantity;
    data['transferred_to_quantity'] = this.transferredToQuantity;
    data['production_quantity'] = this.productionQuantity;
    data['current_quantity'] = this.currentQuantity;
    data['stock_value'] = this.stockValue;
    return data;
  }
}
