// To parse this JSON data, do
//
//     final categoryWiseStockModel = categoryWiseStockModelFromJson(jsonString);

import 'dart:convert';

List<CategoryWiseStockModel> categoryWiseStockModelFromJson(String str) =>
    List<CategoryWiseStockModel>.from(json.decode(str).map((x) => CategoryWiseStockModel.fromJson(x)));

String categoryWiseStockModelToJson(List<CategoryWiseStockModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryWiseStockModel {
  CategoryWiseStockModel({
    this.productCategorySlNo,
    this.productCategoryName,
    this.productCategoryDescription,
    this.status,
    this.addBy,
    this.addTime,
    this.updateBy,
    this.updateTime,
    this.categoryBranchid,
  });

  final String? productCategorySlNo;
  final String? productCategoryName;
  final String? productCategoryDescription;
  final Status? status;
  final AddBy? addBy;
  final DateTime? addTime;
  final UpdateBy? updateBy;
  final String? updateTime;
  final String? categoryBranchid;

  factory CategoryWiseStockModel.fromJson(Map<String, dynamic> json) => CategoryWiseStockModel(
        productCategorySlNo: json["ProductCategory_SlNo"],
        productCategoryName: json["ProductCategory_Name"],
        productCategoryDescription: json["ProductCategory_Description"],
        status: statusValues.map[json["status"]]!,
        addBy: addByValues.map[json["AddBy"]]!,
        addTime: json["AddTime"] == null ? null : DateTime.parse(json["AddTime"]),
        updateBy: updateByValues.map[json["UpdateBy"]]!,
        updateTime: json["UpdateTime"],
        categoryBranchid: json["category_branchid"],
      );

  Map<String, dynamic> toJson() => {
        "ProductCategory_SlNo": productCategorySlNo,
        "ProductCategory_Name": productCategoryName,
        "ProductCategory_Description": productCategoryDescription,
        "status": statusValues.reverse[status],
        "AddBy": addByValues.reverse[addBy],
        "AddTime": addTime?.toIso8601String(),
        "UpdateBy": updateByValues.reverse[updateBy],
        "UpdateTime": updateTime,
        "category_branchid": categoryBranchid,
      };
}

enum AddBy { ADMIN, ALOMGIR }

final addByValues = EnumValues({"Admin": AddBy.ADMIN, "Alomgir": AddBy.ALOMGIR});

enum Status { A }

final statusValues = EnumValues({"a": Status.A});

enum UpdateBy { EMPTY, ADMIN }

final updateByValues = EnumValues({"Admin": UpdateBy.ADMIN, "": UpdateBy.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
