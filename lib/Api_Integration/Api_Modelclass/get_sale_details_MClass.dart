class GetSaleDetailsMClass {
  String? saleDetailsSlNo;
  String? saleMasterIDNo;
  String? productIDNo;
  String? saleDetailsTotalQuantity;
  String? purchaseRate;
  String? saleDetailsRate;
  String? saleDetailsDiscount;
  String? discountAmount;
  String? saleDetailsTax;
  String? saleDetailsTotalAmount;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? saleDetailsBranchId;
  String? productName;
  String? productCategoryName;
  String? saleMasterInvoiceNo;
  String? saleMasterSaleDate;
  String? customerCode;
  String? customerName;

  GetSaleDetailsMClass(
      {this.saleDetailsSlNo,
      this.saleMasterIDNo,
      this.productIDNo,
      this.saleDetailsTotalQuantity,
      this.purchaseRate,
      this.saleDetailsRate,
      this.saleDetailsDiscount,
      this.discountAmount,
      this.saleDetailsTax,
      this.saleDetailsTotalAmount,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.saleDetailsBranchId,
      this.productName,
      this.productCategoryName,
      this.saleMasterInvoiceNo,
      this.saleMasterSaleDate,
      this.customerCode,
      this.customerName});

  GetSaleDetailsMClass.fromJson(Map<String, dynamic> json) {
    saleDetailsSlNo = json['SaleDetails_SlNo'];
    saleMasterIDNo = json['SaleMaster_IDNo'];
    productIDNo = json['Product_IDNo'];
    saleDetailsTotalQuantity = json['SaleDetails_TotalQuantity'];
    purchaseRate = json['Purchase_Rate'];
    saleDetailsRate = json['SaleDetails_Rate'];
    saleDetailsDiscount = json['SaleDetails_Discount'];
    discountAmount = json['Discount_amount'];
    saleDetailsTax = json['SaleDetails_Tax'];
    saleDetailsTotalAmount = json['SaleDetails_TotalAmount'];
    status = json['Status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    saleDetailsBranchId = json['SaleDetails_BranchId'];
    productName = json['Product_Name'];
    productCategoryName = json['ProductCategory_Name'];
    saleMasterInvoiceNo = json['SaleMaster_InvoiceNo'];
    saleMasterSaleDate = json['SaleMaster_SaleDate'];
    customerCode = json['Customer_Code'];
    customerName = json['Customer_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaleDetails_SlNo'] = this.saleDetailsSlNo;
    data['SaleMaster_IDNo'] = this.saleMasterIDNo;
    data['Product_IDNo'] = this.productIDNo;
    data['SaleDetails_TotalQuantity'] = this.saleDetailsTotalQuantity;
    data['Purchase_Rate'] = this.purchaseRate;
    data['SaleDetails_Rate'] = this.saleDetailsRate;
    data['SaleDetails_Discount'] = this.saleDetailsDiscount;
    data['Discount_amount'] = this.discountAmount;
    data['SaleDetails_Tax'] = this.saleDetailsTax;
    data['SaleDetails_TotalAmount'] = this.saleDetailsTotalAmount;
    data['Status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['SaleDetails_BranchId'] = this.saleDetailsBranchId;
    data['Product_Name'] = this.productName;
    data['ProductCategory_Name'] = this.productCategoryName;
    data['SaleMaster_InvoiceNo'] = this.saleMasterInvoiceNo;
    data['SaleMaster_SaleDate'] = this.saleMasterSaleDate;
    data['Customer_Code'] = this.customerCode;
    data['Customer_Name'] = this.customerName;
    return data;
  }
}