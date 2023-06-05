class AllGetMaterialClass {
  String? materialId;
  String? code;
  String? name;
  String? categoryId;
  String? reorderLevel;
  String? purchaseRate;
  String? unitId;
  String? status;
  String? displayText;
  String? categoryName;
  String? unitName;
  String? statusText;

  AllGetMaterialClass(
      {this.materialId,
        this.code,
        this.name,
        this.categoryId,
        this.reorderLevel,
        this.purchaseRate,
        this.unitId,
        this.status,
        this.displayText,
        this.categoryName,
        this.unitName,
        this.statusText});

  AllGetMaterialClass.fromJson(Map<String, dynamic> json) {
    materialId = json['material_id'];
    code = json['code'];
    name = json['name'];
    categoryId = json['category_id'];
    reorderLevel = json['reorder_level'];
    purchaseRate = json['purchase_rate'];
    unitId = json['unit_id'];
    status = json['status'];
    displayText = json['display_text'];
    categoryName = json['category_name'];
    unitName = json['unit_name'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['material_id'] = this.materialId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['reorder_level'] = this.reorderLevel;
    data['purchase_rate'] = this.purchaseRate;
    data['unit_id'] = this.unitId;
    data['status'] = this.status;
    data['display_text'] = this.displayText;
    data['category_name'] = this.categoryName;
    data['unit_name'] = this.unitName;
    data['status_text'] = this.statusText;
    return data;
  }
}