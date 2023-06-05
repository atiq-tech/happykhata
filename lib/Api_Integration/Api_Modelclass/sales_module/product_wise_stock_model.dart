class ProductWiseStockModel {
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
  String? displayText;
  String? productCategoryName;
  Null? brandName;
  String? unitName;

  ProductWiseStockModel(
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
      this.displayText,
      this.productCategoryName,
      this.brandName,
      this.unitName});

  ProductWiseStockModel.fromJson(Map<String, dynamic> json) {
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
    displayText = json['display_text'];
    productCategoryName = json['ProductCategory_Name'];
    brandName = json['brand_name'];
    unitName = json['Unit_Name'];
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
    data['display_text'] = this.displayText;
    data['ProductCategory_Name'] = this.productCategoryName;
    data['brand_name'] = this.brandName;
    data['Unit_Name'] = this.unitName;
    return data;
  }
}
