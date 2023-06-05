class GetPurchaseDetailsModelClass {
  String? purchaseDetailsSlNo;
  String? purchaseMasterIDNo;
  String? productIDNo;
  String? purchaseDetailsTotalQuantity;
  String? purchaseDetailsRate;
  String? purchaseCost;
  String? purchaseDetailsDiscount;
  String? purchaseDetailsTotalAmount;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? purchaseDetailsBranchID;
  String? productName;
  String? productCategoryName;
  String? purchaseMasterInvoiceNo;
  String? purchaseMasterOrderDate;
  String? supplierCode;
  String? supplierName;

  GetPurchaseDetailsModelClass(
      {this.purchaseDetailsSlNo,
      this.purchaseMasterIDNo,
      this.productIDNo,
      this.purchaseDetailsTotalQuantity,
      this.purchaseDetailsRate,
      this.purchaseCost,
      this.purchaseDetailsDiscount,
      this.purchaseDetailsTotalAmount,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.purchaseDetailsBranchID,
      this.productName,
      this.productCategoryName,
      this.purchaseMasterInvoiceNo,
      this.purchaseMasterOrderDate,
      this.supplierCode,
      this.supplierName});

  GetPurchaseDetailsModelClass.fromJson(Map<String, dynamic> json) {
    purchaseDetailsSlNo = json['PurchaseDetails_SlNo'];
    purchaseMasterIDNo = json['PurchaseMaster_IDNo'];
    productIDNo = json['Product_IDNo'];
    purchaseDetailsTotalQuantity = json['PurchaseDetails_TotalQuantity'];
    purchaseDetailsRate = json['PurchaseDetails_Rate'];
    purchaseCost = json['purchase_cost'];
    purchaseDetailsDiscount = json['PurchaseDetails_Discount'];
    purchaseDetailsTotalAmount = json['PurchaseDetails_TotalAmount'];
    status = json['Status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    purchaseDetailsBranchID = json['PurchaseDetails_branchID'];
    productName = json['Product_Name'];
    productCategoryName = json['ProductCategory_Name'];
    purchaseMasterInvoiceNo = json['PurchaseMaster_InvoiceNo'];
    purchaseMasterOrderDate = json['PurchaseMaster_OrderDate'];
    supplierCode = json['Supplier_Code'];
    supplierName = json['Supplier_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PurchaseDetails_SlNo'] = this.purchaseDetailsSlNo;
    data['PurchaseMaster_IDNo'] = this.purchaseMasterIDNo;
    data['Product_IDNo'] = this.productIDNo;
    data['PurchaseDetails_TotalQuantity'] = this.purchaseDetailsTotalQuantity;
    data['PurchaseDetails_Rate'] = this.purchaseDetailsRate;
    data['purchase_cost'] = this.purchaseCost;
    data['PurchaseDetails_Discount'] = this.purchaseDetailsDiscount;
    data['PurchaseDetails_TotalAmount'] = this.purchaseDetailsTotalAmount;
    data['Status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['PurchaseDetails_branchID'] = this.purchaseDetailsBranchID;
    data['Product_Name'] = this.productName;
    data['ProductCategory_Name'] = this.productCategoryName;
    data['PurchaseMaster_InvoiceNo'] = this.purchaseMasterInvoiceNo;
    data['PurchaseMaster_OrderDate'] = this.purchaseMasterOrderDate;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Name'] = this.supplierName;
    return data;
  }
}