class PurchaseModel {
  List<Purchases>? purchases;

  PurchaseModel({this.purchases});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    if (json['purchases'] != null) {
      purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        purchases!.add(new Purchases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchases != null) {
      data['purchases'] = this.purchases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchases {
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
  String? supplierName;
  String? supplierMobile;
  String? supplierEmail;
  String? supplierCode;
  String? supplierAddress;
  String? supplierType;

  Purchases(
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
      this.supplierName,
      this.supplierMobile,
      this.supplierEmail,
      this.supplierCode,
      this.supplierAddress,
      this.supplierType});

  Purchases.fromJson(Map<String, dynamic> json) {
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
    supplierName = json['Supplier_Name'];
    supplierMobile = json['Supplier_Mobile'];
    supplierEmail = json['Supplier_Email'];
    supplierCode = json['Supplier_Code'];
    supplierAddress = json['Supplier_Address'];
    supplierType = json['Supplier_Type'];
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
    data['Supplier_Name'] = this.supplierName;
    data['Supplier_Mobile'] = this.supplierMobile;
    data['Supplier_Email'] = this.supplierEmail;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Address'] = this.supplierAddress;
    data['Supplier_Type'] = this.supplierType;
    return data;
  }
}
