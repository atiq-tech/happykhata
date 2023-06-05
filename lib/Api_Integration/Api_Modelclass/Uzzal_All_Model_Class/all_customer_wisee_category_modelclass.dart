class CustomerCategories {
  String? _productCategorySlNo;
  String? _productCategoryName;

  CustomerCategories(
      {String? productCategorySlNo, String? productCategoryName}) {
    if (productCategorySlNo != null) {
      this._productCategorySlNo = productCategorySlNo;
    }
    if (productCategoryName != null) {
      this._productCategoryName = productCategoryName;
    }
  }

  String? get productCategorySlNo => _productCategorySlNo;
  set productCategorySlNo(String? productCategorySlNo) =>
      _productCategorySlNo = productCategorySlNo;
  String? get productCategoryName => _productCategoryName;
  set productCategoryName(String? productCategoryName) =>
      _productCategoryName = productCategoryName;

  CustomerCategories.fromJson(Map<String, dynamic> json) {
    _productCategorySlNo = json['ProductCategory_SlNo'];
    _productCategoryName = json['ProductCategory_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductCategory_SlNo'] = this._productCategorySlNo;
    data['ProductCategory_Name'] = this._productCategoryName;
    return data;
  }
}
