class GetCustomerCateMClass {
  String? productCategorySlNo;
  String? productCategoryName;

  GetCustomerCateMClass({this.productCategorySlNo, this.productCategoryName});

  GetCustomerCateMClass.fromJson(Map<String, dynamic> json) {
    productCategorySlNo = json['ProductCategory_SlNo'];
    productCategoryName = json['ProductCategory_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductCategory_SlNo'] = this.productCategorySlNo;
    data['ProductCategory_Name'] = this.productCategoryName;
    return data;
  }
}