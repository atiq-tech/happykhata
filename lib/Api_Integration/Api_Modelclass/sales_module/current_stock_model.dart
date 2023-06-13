// To parse this JSON data, do
//
//     final currentStockModel = currentStockModelFromJson(jsonString);

import 'dart:convert';

CurrentStockModel currentStockModelFromJson(String str) => CurrentStockModel.fromJson(json.decode(str));

String currentStockModelToJson(CurrentStockModel data) => json.encode(data.toJson());

class CurrentStockModel {
  CurrentStockModel({
    this.stock,
    this.totalValue,
  });

  final List<Stock>? stock;
  final double? totalValue;

  factory CurrentStockModel.fromJson(Map<String, dynamic> json) => CurrentStockModel(
        stock: json["stock"] == null ? [] : List<Stock>.from(json["stock"]!.map((x) => Stock.fromJson(x))),
        totalValue: json["totalValue"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "stock": stock == null ? [] : List<dynamic>.from(stock!.map((x) => x.toJson())),
        "totalValue": totalValue,
      };
}

class Stock {
  Stock({
    this.inventoryId,
    this.productId,
    this.purchaseQuantity,
    this.purchaseReturnQuantity,
    this.productionQuantity,
    this.salesQuantity,
    this.salesReturnQuantity,
    this.damageQuantity,
    this.transferFromQuantity,
    this.transferToQuantity,
    this.branchId,
    this.currentQuantity,
    this.productName,
    this.productCode,
    this.productReOrederLevel,
    this.stockValue,
    this.productCategoryName,
    this.brandName,
    this.unitName,
  });

  final String? inventoryId;
  final String? productId;
  final String? purchaseQuantity;
  final String? purchaseReturnQuantity;
  final String? productionQuantity;
  final String? salesQuantity;
  final String? salesReturnQuantity;
  final String? damageQuantity;
  final String? transferFromQuantity;
  final String? transferToQuantity;
  final String? branchId;
  final String? currentQuantity;
  final String? productName;
  final String? productCode;
  final String? productReOrederLevel;
  final String? stockValue;
  final String? productCategoryName;
  final dynamic brandName;
  final UnitName? unitName;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        inventoryId: json["inventory_id"],
        productId: json["product_id"],
        purchaseQuantity: json["purchase_quantity"],
        purchaseReturnQuantity: json["purchase_return_quantity"],
        productionQuantity: json["production_quantity"],
        salesQuantity: json["sales_quantity"],
        salesReturnQuantity: json["sales_return_quantity"],
        damageQuantity: json["damage_quantity"],
        transferFromQuantity: json["transfer_from_quantity"],
        transferToQuantity: json["transfer_to_quantity"],
        branchId: json["branch_id"],
        currentQuantity: json["current_quantity"],
        productName: json["Product_Name"],
        productCode: json["Product_Code"],
        productReOrederLevel: json["Product_ReOrederLevel"],
        stockValue: json["stock_value"],
        productCategoryName: json["ProductCategory_Name"],
        brandName: json["brand_name"],
        unitName: unitNameValues.map[json["Unit_Name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "inventory_id": inventoryId,
        "product_id": productId,
        "purchase_quantity": purchaseQuantity,
        "purchase_return_quantity": purchaseReturnQuantity,
        "production_quantity": productionQuantity,
        "sales_quantity": salesQuantity,
        "sales_return_quantity": salesReturnQuantity,
        "damage_quantity": damageQuantity,
        "transfer_from_quantity": transferFromQuantity,
        "transfer_to_quantity": transferToQuantity,
        "branch_id": branchId,
        "current_quantity": currentQuantity,
        "Product_Name": productName,
        "Product_Code": productCode,
        "Product_ReOrederLevel": productReOrederLevel,
        "stock_value": stockValue,
        "ProductCategory_Name": productCategoryName,
        "brand_name": brandName,
        "Unit_Name": unitNameValues.reverse[unitName],
      };
}

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

enum UnitName { PCS, REEM, PACKET, K_G }

final unitNameValues =
    EnumValues({"K.G": UnitName.K_G, "Packet": UnitName.PACKET, "PCS": UnitName.PCS, "Reem": UnitName.REEM});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
