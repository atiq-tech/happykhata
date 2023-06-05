class All_Purrchase_ModelClass {
  List<Purchases>? _purchases;

  All_Purrchase_ModelClass({List<Purchases>? purchases}) {
    if (purchases != null) {
      this._purchases = purchases;
    }
  }

  List<Purchases>? get purchases => _purchases;
  set purchases(List<Purchases>? purchases) => _purchases = purchases;

  All_Purrchase_ModelClass.fromJson(Map<String, dynamic> json) {
    if (json['purchases'] != null) {
      _purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        _purchases!.add(new Purchases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._purchases != null) {
      data['purchases'] = this._purchases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchases {
  String? _purchaseMasterSlNo;
  String? _supplierSlNo;
  String? _employeeSlNo;
  String? _purchaseMasterInvoiceNo;
  String? _purchaseMasterOrderDate;
  String? _purchaseMasterPurchaseFor;
  String? _purchaseMasterDescription;
  String? _purchaseMasterTotalAmount;
  String? _purchaseMasterDiscountAmount;
  String? _purchaseMasterTax;
  String? _purchaseMasterFreight;
  String? _purchaseMasterSubTotalAmount;
  String? _purchaseMasterPaidAmount;
  String? _purchaseMasterDueAmount;
  String? _previousDue;
  String? _status;
  String? _addBy;
  String? _addTime;
  String? _updateBy;
  String? _updateTime;
  String? _purchaseMasterBranchID;
  String? _supplierName;
  String? _supplierMobile;
  String? _supplierEmail;
  String? _supplierCode;
  String? _supplierAddress;
  String? _supplierType;

  Purchases(
      {String? purchaseMasterSlNo,
        String? supplierSlNo,
        String? employeeSlNo,
        String? purchaseMasterInvoiceNo,
        String? purchaseMasterOrderDate,
        String? purchaseMasterPurchaseFor,
        String? purchaseMasterDescription,
        String? purchaseMasterTotalAmount,
        String? purchaseMasterDiscountAmount,
        String? purchaseMasterTax,
        String? purchaseMasterFreight,
        String? purchaseMasterSubTotalAmount,
        String? purchaseMasterPaidAmount,
        String? purchaseMasterDueAmount,
        String? previousDue,
        String? status,
        String? addBy,
        String? addTime,
        String? updateBy,
        String? updateTime,
        String? purchaseMasterBranchID,
        String? supplierName,
        String? supplierMobile,
        String? supplierEmail,
        String? supplierCode,
        String? supplierAddress,
        String? supplierType}) {
    if (purchaseMasterSlNo != null) {
      this._purchaseMasterSlNo = purchaseMasterSlNo;
    }
    if (supplierSlNo != null) {
      this._supplierSlNo = supplierSlNo;
    }
    if (employeeSlNo != null) {
      this._employeeSlNo = employeeSlNo;
    }
    if (purchaseMasterInvoiceNo != null) {
      this._purchaseMasterInvoiceNo = purchaseMasterInvoiceNo;
    }
    if (purchaseMasterOrderDate != null) {
      this._purchaseMasterOrderDate = purchaseMasterOrderDate;
    }
    if (purchaseMasterPurchaseFor != null) {
      this._purchaseMasterPurchaseFor = purchaseMasterPurchaseFor;
    }
    if (purchaseMasterDescription != null) {
      this._purchaseMasterDescription = purchaseMasterDescription;
    }
    if (purchaseMasterTotalAmount != null) {
      this._purchaseMasterTotalAmount = purchaseMasterTotalAmount;
    }
    if (purchaseMasterDiscountAmount != null) {
      this._purchaseMasterDiscountAmount = purchaseMasterDiscountAmount;
    }
    if (purchaseMasterTax != null) {
      this._purchaseMasterTax = purchaseMasterTax;
    }
    if (purchaseMasterFreight != null) {
      this._purchaseMasterFreight = purchaseMasterFreight;
    }
    if (purchaseMasterSubTotalAmount != null) {
      this._purchaseMasterSubTotalAmount = purchaseMasterSubTotalAmount;
    }
    if (purchaseMasterPaidAmount != null) {
      this._purchaseMasterPaidAmount = purchaseMasterPaidAmount;
    }
    if (purchaseMasterDueAmount != null) {
      this._purchaseMasterDueAmount = purchaseMasterDueAmount;
    }
    if (previousDue != null) {
      this._previousDue = previousDue;
    }
    if (status != null) {
      this._status = status;
    }
    if (addBy != null) {
      this._addBy = addBy;
    }
    if (addTime != null) {
      this._addTime = addTime;
    }
    if (updateBy != null) {
      this._updateBy = updateBy;
    }
    if (updateTime != null) {
      this._updateTime = updateTime;
    }
    if (purchaseMasterBranchID != null) {
      this._purchaseMasterBranchID = purchaseMasterBranchID;
    }
    if (supplierName != null) {
      this._supplierName = supplierName;
    }
    if (supplierMobile != null) {
      this._supplierMobile = supplierMobile;
    }
    if (supplierEmail != null) {
      this._supplierEmail = supplierEmail;
    }
    if (supplierCode != null) {
      this._supplierCode = supplierCode;
    }
    if (supplierAddress != null) {
      this._supplierAddress = supplierAddress;
    }
    if (supplierType != null) {
      this._supplierType = supplierType;
    }
  }

  String? get purchaseMasterSlNo => _purchaseMasterSlNo;
  set purchaseMasterSlNo(String? purchaseMasterSlNo) =>
      _purchaseMasterSlNo = purchaseMasterSlNo;
  String? get supplierSlNo => _supplierSlNo;
  set supplierSlNo(String? supplierSlNo) => _supplierSlNo = supplierSlNo;
  String? get employeeSlNo => _employeeSlNo;
  set employeeSlNo(String? employeeSlNo) => _employeeSlNo = employeeSlNo;
  String? get purchaseMasterInvoiceNo => _purchaseMasterInvoiceNo;
  set purchaseMasterInvoiceNo(String? purchaseMasterInvoiceNo) =>
      _purchaseMasterInvoiceNo = purchaseMasterInvoiceNo;
  String? get purchaseMasterOrderDate => _purchaseMasterOrderDate;
  set purchaseMasterOrderDate(String? purchaseMasterOrderDate) =>
      _purchaseMasterOrderDate = purchaseMasterOrderDate;
  String? get purchaseMasterPurchaseFor => _purchaseMasterPurchaseFor;
  set purchaseMasterPurchaseFor(String? purchaseMasterPurchaseFor) =>
      _purchaseMasterPurchaseFor = purchaseMasterPurchaseFor;
  String? get purchaseMasterDescription => _purchaseMasterDescription;
  set purchaseMasterDescription(String? purchaseMasterDescription) =>
      _purchaseMasterDescription = purchaseMasterDescription;
  String? get purchaseMasterTotalAmount => _purchaseMasterTotalAmount;
  set purchaseMasterTotalAmount(String? purchaseMasterTotalAmount) =>
      _purchaseMasterTotalAmount = purchaseMasterTotalAmount;
  String? get purchaseMasterDiscountAmount => _purchaseMasterDiscountAmount;
  set purchaseMasterDiscountAmount(String? purchaseMasterDiscountAmount) =>
      _purchaseMasterDiscountAmount = purchaseMasterDiscountAmount;
  String? get purchaseMasterTax => _purchaseMasterTax;
  set purchaseMasterTax(String? purchaseMasterTax) =>
      _purchaseMasterTax = purchaseMasterTax;
  String? get purchaseMasterFreight => _purchaseMasterFreight;
  set purchaseMasterFreight(String? purchaseMasterFreight) =>
      _purchaseMasterFreight = purchaseMasterFreight;
  String? get purchaseMasterSubTotalAmount => _purchaseMasterSubTotalAmount;
  set purchaseMasterSubTotalAmount(String? purchaseMasterSubTotalAmount) =>
      _purchaseMasterSubTotalAmount = purchaseMasterSubTotalAmount;
  String? get purchaseMasterPaidAmount => _purchaseMasterPaidAmount;
  set purchaseMasterPaidAmount(String? purchaseMasterPaidAmount) =>
      _purchaseMasterPaidAmount = purchaseMasterPaidAmount;
  String? get purchaseMasterDueAmount => _purchaseMasterDueAmount;
  set purchaseMasterDueAmount(String? purchaseMasterDueAmount) =>
      _purchaseMasterDueAmount = purchaseMasterDueAmount;
  String? get previousDue => _previousDue;
  set previousDue(String? previousDue) => _previousDue = previousDue;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get addBy => _addBy;
  set addBy(String? addBy) => _addBy = addBy;
  String? get addTime => _addTime;
  set addTime(String? addTime) => _addTime = addTime;
  String? get updateBy => _updateBy;
  set updateBy(String? updateBy) => _updateBy = updateBy;
  String? get updateTime => _updateTime;
  set updateTime(String? updateTime) => _updateTime = updateTime;
  String? get purchaseMasterBranchID => _purchaseMasterBranchID;
  set purchaseMasterBranchID(String? purchaseMasterBranchID) =>
      _purchaseMasterBranchID = purchaseMasterBranchID;
  String? get supplierName => _supplierName;
  set supplierName(String? supplierName) => _supplierName = supplierName;
  String? get supplierMobile => _supplierMobile;
  set supplierMobile(String? supplierMobile) =>
      _supplierMobile = supplierMobile;
  String? get supplierEmail => _supplierEmail;
  set supplierEmail(String? supplierEmail) => _supplierEmail = supplierEmail;
  String? get supplierCode => _supplierCode;
  set supplierCode(String? supplierCode) => _supplierCode = supplierCode;
  String? get supplierAddress => _supplierAddress;
  set supplierAddress(String? supplierAddress) =>
      _supplierAddress = supplierAddress;
  String? get supplierType => _supplierType;
  set supplierType(String? supplierType) => _supplierType = supplierType;

  Purchases.fromJson(Map<String, dynamic> json) {
    _purchaseMasterSlNo = json['PurchaseMaster_SlNo'];
    _supplierSlNo = json['Supplier_SlNo'];
    _employeeSlNo = json['Employee_SlNo'];
    _purchaseMasterInvoiceNo = json['PurchaseMaster_InvoiceNo'];
    _purchaseMasterOrderDate = json['PurchaseMaster_OrderDate'];
    _purchaseMasterPurchaseFor = json['PurchaseMaster_PurchaseFor'];
    _purchaseMasterDescription = json['PurchaseMaster_Description'];
    _purchaseMasterTotalAmount = json['PurchaseMaster_TotalAmount'];
    _purchaseMasterDiscountAmount = json['PurchaseMaster_DiscountAmount'];
    _purchaseMasterTax = json['PurchaseMaster_Tax'];
    _purchaseMasterFreight = json['PurchaseMaster_Freight'];
    _purchaseMasterSubTotalAmount = json['PurchaseMaster_SubTotalAmount'];
    _purchaseMasterPaidAmount = json['PurchaseMaster_PaidAmount'];
    _purchaseMasterDueAmount = json['PurchaseMaster_DueAmount'];
    _previousDue = json['previous_due'];
    _status = json['status'];
    _addBy = json['AddBy'];
    _addTime = json['AddTime'];
    _updateBy = json['UpdateBy'];
    _updateTime = json['UpdateTime'];
    _purchaseMasterBranchID = json['PurchaseMaster_BranchID'];
    _supplierName = json['Supplier_Name'];
    _supplierMobile = json['Supplier_Mobile'];
    _supplierEmail = json['Supplier_Email'];
    _supplierCode = json['Supplier_Code'];
    _supplierAddress = json['Supplier_Address'];
    _supplierType = json['Supplier_Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PurchaseMaster_SlNo'] = this._purchaseMasterSlNo;
    data['Supplier_SlNo'] = this._supplierSlNo;
    data['Employee_SlNo'] = this._employeeSlNo;
    data['PurchaseMaster_InvoiceNo'] = this._purchaseMasterInvoiceNo;
    data['PurchaseMaster_OrderDate'] = this._purchaseMasterOrderDate;
    data['PurchaseMaster_PurchaseFor'] = this._purchaseMasterPurchaseFor;
    data['PurchaseMaster_Description'] = this._purchaseMasterDescription;
    data['PurchaseMaster_TotalAmount'] = this._purchaseMasterTotalAmount;
    data['PurchaseMaster_DiscountAmount'] = this._purchaseMasterDiscountAmount;
    data['PurchaseMaster_Tax'] = this._purchaseMasterTax;
    data['PurchaseMaster_Freight'] = this._purchaseMasterFreight;
    data['PurchaseMaster_SubTotalAmount'] = this._purchaseMasterSubTotalAmount;
    data['PurchaseMaster_PaidAmount'] = this._purchaseMasterPaidAmount;
    data['PurchaseMaster_DueAmount'] = this._purchaseMasterDueAmount;
    data['previous_due'] = this._previousDue;
    data['status'] = this._status;
    data['AddBy'] = this._addBy;
    data['AddTime'] = this._addTime;
    data['UpdateBy'] = this._updateBy;
    data['UpdateTime'] = this._updateTime;
    data['PurchaseMaster_BranchID'] = this._purchaseMasterBranchID;
    data['Supplier_Name'] = this._supplierName;
    data['Supplier_Mobile'] = this._supplierMobile;
    data['Supplier_Email'] = this._supplierEmail;
    data['Supplier_Code'] = this._supplierCode;
    data['Supplier_Address'] = this._supplierAddress;
    data['Supplier_Type'] = this._supplierType;
    return data;
  }
}
