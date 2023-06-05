class GetPurchaseRecord_ALL {
  String? purchaseMasterSlNo;
  String? supplierSlNo;
  String? employeeSlNo;
  String? purchaseMasterInvoiceNo;
  String? purchaseMasterOrderDate;
  String? purchaseMasterPurchaseFor;
  String? purchaseMasterDescription;
  String? purchaseMasterTotalAmount;
  String? purchaseMasterDiscountAmount;
  String? purchaseMasterTax;
  String? purchaseMasterFreight;
  String? purchaseMasterSubTotalAmount;
  String? purchaseMasterPaidAmount;
  String? purchaseMasterDueAmount;
  String? previousDue;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? purchaseMasterBranchID;
  String? supplierCode;
  String? supplierName;
  String? supplierMobile;
  String? supplierAddress;
  String? brunchName;
  List<PurchaseDetails>? purchaseDetails;

  GetPurchaseRecord_ALL(
      {this.purchaseMasterSlNo,
      this.supplierSlNo,
      this.employeeSlNo,
      this.purchaseMasterInvoiceNo,
      this.purchaseMasterOrderDate,
      this.purchaseMasterPurchaseFor,
      this.purchaseMasterDescription,
      this.purchaseMasterTotalAmount,
      this.purchaseMasterDiscountAmount,
      this.purchaseMasterTax,
      this.purchaseMasterFreight,
      this.purchaseMasterSubTotalAmount,
      this.purchaseMasterPaidAmount,
      this.purchaseMasterDueAmount,
      this.previousDue,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.purchaseMasterBranchID,
      this.supplierCode,
      this.supplierName,
      this.supplierMobile,
      this.supplierAddress,
      this.brunchName,
      this.purchaseDetails});

  GetPurchaseRecord_ALL.fromJson(Map<String, dynamic> json) {
    purchaseMasterSlNo = json['PurchaseMaster_SlNo'];
    supplierSlNo = json['Supplier_SlNo'];
    employeeSlNo = json['Employee_SlNo'];
    purchaseMasterInvoiceNo = json['PurchaseMaster_InvoiceNo'];
    purchaseMasterOrderDate = json['PurchaseMaster_OrderDate'];
    purchaseMasterPurchaseFor = json['PurchaseMaster_PurchaseFor'];
    purchaseMasterDescription = json['PurchaseMaster_Description'];
    purchaseMasterTotalAmount = json['PurchaseMaster_TotalAmount'];
    purchaseMasterDiscountAmount = json['PurchaseMaster_DiscountAmount'];
    purchaseMasterTax = json['PurchaseMaster_Tax'];
    purchaseMasterFreight = json['PurchaseMaster_Freight'];
    purchaseMasterSubTotalAmount = json['PurchaseMaster_SubTotalAmount'];
    purchaseMasterPaidAmount = json['PurchaseMaster_PaidAmount'];
    purchaseMasterDueAmount = json['PurchaseMaster_DueAmount'];
    previousDue = json['previous_due'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    purchaseMasterBranchID = json['PurchaseMaster_BranchID'];
    supplierCode = json['Supplier_Code'];
    supplierName = json['Supplier_Name'];
    supplierMobile = json['Supplier_Mobile'];
    supplierAddress = json['Supplier_Address'];
    brunchName = json['Brunch_name'];
    if (json['purchaseDetails'] != null) {
      purchaseDetails = <PurchaseDetails>[];
      json['purchaseDetails'].forEach((v) {
        purchaseDetails!.add(new PurchaseDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PurchaseMaster_SlNo'] = this.purchaseMasterSlNo;
    data['Supplier_SlNo'] = this.supplierSlNo;
    data['Employee_SlNo'] = this.employeeSlNo;
    data['PurchaseMaster_InvoiceNo'] = this.purchaseMasterInvoiceNo;
    data['PurchaseMaster_OrderDate'] = this.purchaseMasterOrderDate;
    data['PurchaseMaster_PurchaseFor'] = this.purchaseMasterPurchaseFor;
    data['PurchaseMaster_Description'] = this.purchaseMasterDescription;
    data['PurchaseMaster_TotalAmount'] = this.purchaseMasterTotalAmount;
    data['PurchaseMaster_DiscountAmount'] = this.purchaseMasterDiscountAmount;
    data['PurchaseMaster_Tax'] = this.purchaseMasterTax;
    data['PurchaseMaster_Freight'] = this.purchaseMasterFreight;
    data['PurchaseMaster_SubTotalAmount'] = this.purchaseMasterSubTotalAmount;
    data['PurchaseMaster_PaidAmount'] = this.purchaseMasterPaidAmount;
    data['PurchaseMaster_DueAmount'] = this.purchaseMasterDueAmount;
    data['previous_due'] = this.previousDue;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['PurchaseMaster_BranchID'] = this.purchaseMasterBranchID;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Name'] = this.supplierName;
    data['Supplier_Mobile'] = this.supplierMobile;
    data['Supplier_Address'] = this.supplierAddress;
    data['Brunch_name'] = this.brunchName;
    if (this.purchaseDetails != null) {
      data['purchaseDetails'] =
          this.purchaseDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseDetails {
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

  PurchaseDetails(
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
      this.productCategoryName});

  PurchaseDetails.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
