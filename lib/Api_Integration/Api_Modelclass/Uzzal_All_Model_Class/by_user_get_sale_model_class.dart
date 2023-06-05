class GetSalesByuserModelClass {
  List<Sales>? _sales;
  String? _branch;

  GetSalesByuserModelClass({List<Sales>? sales, String? branch}) {
    if (sales != null) {
      this._sales = sales;
    }
    if (branch != null) {
      this._branch = branch;
    }
  }

  List<Sales>? get sales => _sales;
  set sales(List<Sales>? sales) => _sales = sales;
  String? get branch => _branch;
  set branch(String? branch) => _branch = branch;

  GetSalesByuserModelClass.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      _sales = <Sales>[];
      json['sales'].forEach((v) {
        _sales!.add(new Sales.fromJson(v));
      });
    }
    _branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._sales != null) {
      data['sales'] = this._sales!.map((v) => v.toJson()).toList();
    }
    data['branch'] = this._branch;
    return data;
  }
}

class Sales {
  String? _saleMasterSlNo;
  String? _saleMasterInvoiceNo;
  String? _salseCustomerIDNo;
  String? _employeeId;
  String? _saleMasterSaleDate;
  String? _saleMasterDescription;
  String? _saleMasterSaleType;
  String? _paymentType;
  String? _saleMasterTotalSaleAmount;
  String? _saleMasterTotalDiscountAmount;
  String? _saleMasterTaxAmount;
  String? _saleMasterFreight;
  String? _saleMasterSubTotalAmount;
  String? _saleMasterPaidAmount;
  String? _saleMasterDueAmount;
  String? _saleMasterPreviousDue;
  String? _status;
  String? _isService;
  String? _addBy;
  String? _addTime;
  String? _updateBy;
  String? _updateTime;
  String? _saleMasterBranchid;
  String? _customerCode;
  String? _customerName;
  String? _customerMobile;
  String? _customerAddress;
  String? _customerType;
  String? _employeeName;
  String? _brunchName;

  Sales(
      {String? saleMasterSlNo,
        String? saleMasterInvoiceNo,
        String? salseCustomerIDNo,
        String? employeeId,
        String? saleMasterSaleDate,
        String? saleMasterDescription,
        String? saleMasterSaleType,
        String? paymentType,
        String? saleMasterTotalSaleAmount,
        String? saleMasterTotalDiscountAmount,
        String? saleMasterTaxAmount,
        String? saleMasterFreight,
        String? saleMasterSubTotalAmount,
        String? saleMasterPaidAmount,
        String? saleMasterDueAmount,
        String? saleMasterPreviousDue,
        String? status,
        String? isService,
        String? addBy,
        String? addTime,
        String? updateBy,
        String? updateTime,
        String? saleMasterBranchid,
        String? customerCode,
        String? customerName,
        String? customerMobile,
        String? customerAddress,
        String? customerType,
        String? employeeName,
        String? brunchName}) {
    if (saleMasterSlNo != null) {
      this._saleMasterSlNo = saleMasterSlNo;
    }
    if (saleMasterInvoiceNo != null) {
      this._saleMasterInvoiceNo = saleMasterInvoiceNo;
    }
    if (salseCustomerIDNo != null) {
      this._salseCustomerIDNo = salseCustomerIDNo;
    }
    if (employeeId != null) {
      this._employeeId = employeeId;
    }
    if (saleMasterSaleDate != null) {
      this._saleMasterSaleDate = saleMasterSaleDate;
    }
    if (saleMasterDescription != null) {
      this._saleMasterDescription = saleMasterDescription;
    }
    if (saleMasterSaleType != null) {
      this._saleMasterSaleType = saleMasterSaleType;
    }
    if (paymentType != null) {
      this._paymentType = paymentType;
    }
    if (saleMasterTotalSaleAmount != null) {
      this._saleMasterTotalSaleAmount = saleMasterTotalSaleAmount;
    }
    if (saleMasterTotalDiscountAmount != null) {
      this._saleMasterTotalDiscountAmount = saleMasterTotalDiscountAmount;
    }
    if (saleMasterTaxAmount != null) {
      this._saleMasterTaxAmount = saleMasterTaxAmount;
    }
    if (saleMasterFreight != null) {
      this._saleMasterFreight = saleMasterFreight;
    }
    if (saleMasterSubTotalAmount != null) {
      this._saleMasterSubTotalAmount = saleMasterSubTotalAmount;
    }
    if (saleMasterPaidAmount != null) {
      this._saleMasterPaidAmount = saleMasterPaidAmount;
    }
    if (saleMasterDueAmount != null) {
      this._saleMasterDueAmount = saleMasterDueAmount;
    }
    if (saleMasterPreviousDue != null) {
      this._saleMasterPreviousDue = saleMasterPreviousDue;
    }
    if (status != null) {
      this._status = status;
    }
    if (isService != null) {
      this._isService = isService;
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
    if (saleMasterBranchid != null) {
      this._saleMasterBranchid = saleMasterBranchid;
    }
    if (customerCode != null) {
      this._customerCode = customerCode;
    }
    if (customerName != null) {
      this._customerName = customerName;
    }
    if (customerMobile != null) {
      this._customerMobile = customerMobile;
    }
    if (customerAddress != null) {
      this._customerAddress = customerAddress;
    }
    if (customerType != null) {
      this._customerType = customerType;
    }
    if (employeeName != null) {
      this._employeeName = employeeName;
    }
    if (brunchName != null) {
      this._brunchName = brunchName;
    }
  }

  String? get saleMasterSlNo => _saleMasterSlNo;
  set saleMasterSlNo(String? saleMasterSlNo) =>
      _saleMasterSlNo = saleMasterSlNo;
  String? get saleMasterInvoiceNo => _saleMasterInvoiceNo;
  set saleMasterInvoiceNo(String? saleMasterInvoiceNo) =>
      _saleMasterInvoiceNo = saleMasterInvoiceNo;
  String? get salseCustomerIDNo => _salseCustomerIDNo;
  set salseCustomerIDNo(String? salseCustomerIDNo) =>
      _salseCustomerIDNo = salseCustomerIDNo;
  String? get employeeId => _employeeId;
  set employeeId(String? employeeId) => _employeeId = employeeId;
  String? get saleMasterSaleDate => _saleMasterSaleDate;
  set saleMasterSaleDate(String? saleMasterSaleDate) =>
      _saleMasterSaleDate = saleMasterSaleDate;
  String? get saleMasterDescription => _saleMasterDescription;
  set saleMasterDescription(String? saleMasterDescription) =>
      _saleMasterDescription = saleMasterDescription;
  String? get saleMasterSaleType => _saleMasterSaleType;
  set saleMasterSaleType(String? saleMasterSaleType) =>
      _saleMasterSaleType = saleMasterSaleType;
  String? get paymentType => _paymentType;
  set paymentType(String? paymentType) => _paymentType = paymentType;
  String? get saleMasterTotalSaleAmount => _saleMasterTotalSaleAmount;
  set saleMasterTotalSaleAmount(String? saleMasterTotalSaleAmount) =>
      _saleMasterTotalSaleAmount = saleMasterTotalSaleAmount;
  String? get saleMasterTotalDiscountAmount => _saleMasterTotalDiscountAmount;
  set saleMasterTotalDiscountAmount(String? saleMasterTotalDiscountAmount) =>
      _saleMasterTotalDiscountAmount = saleMasterTotalDiscountAmount;
  String? get saleMasterTaxAmount => _saleMasterTaxAmount;
  set saleMasterTaxAmount(String? saleMasterTaxAmount) =>
      _saleMasterTaxAmount = saleMasterTaxAmount;
  String? get saleMasterFreight => _saleMasterFreight;
  set saleMasterFreight(String? saleMasterFreight) =>
      _saleMasterFreight = saleMasterFreight;
  String? get saleMasterSubTotalAmount => _saleMasterSubTotalAmount;
  set saleMasterSubTotalAmount(String? saleMasterSubTotalAmount) =>
      _saleMasterSubTotalAmount = saleMasterSubTotalAmount;
  String? get saleMasterPaidAmount => _saleMasterPaidAmount;
  set saleMasterPaidAmount(String? saleMasterPaidAmount) =>
      _saleMasterPaidAmount = saleMasterPaidAmount;
  String? get saleMasterDueAmount => _saleMasterDueAmount;
  set saleMasterDueAmount(String? saleMasterDueAmount) =>
      _saleMasterDueAmount = saleMasterDueAmount;
  String? get saleMasterPreviousDue => _saleMasterPreviousDue;
  set saleMasterPreviousDue(String? saleMasterPreviousDue) =>
      _saleMasterPreviousDue = saleMasterPreviousDue;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get isService => _isService;
  set isService(String? isService) => _isService = isService;
  String? get addBy => _addBy;
  set addBy(String? addBy) => _addBy = addBy;
  String? get addTime => _addTime;
  set addTime(String? addTime) => _addTime = addTime;
  String? get updateBy => _updateBy;
  set updateBy(String? updateBy) => _updateBy = updateBy;
  String? get updateTime => _updateTime;
  set updateTime(String? updateTime) => _updateTime = updateTime;
  String? get saleMasterBranchid => _saleMasterBranchid;
  set saleMasterBranchid(String? saleMasterBranchid) =>
      _saleMasterBranchid = saleMasterBranchid;
  String? get customerCode => _customerCode;
  set customerCode(String? customerCode) => _customerCode = customerCode;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get customerMobile => _customerMobile;
  set customerMobile(String? customerMobile) =>
      _customerMobile = customerMobile;
  String? get customerAddress => _customerAddress;
  set customerAddress(String? customerAddress) =>
      _customerAddress = customerAddress;
  String? get customerType => _customerType;
  set customerType(String? customerType) => _customerType = customerType;
  String? get employeeName => _employeeName;
  set employeeName(String? employeeName) => _employeeName = employeeName;
  String? get brunchName => _brunchName;
  set brunchName(String? brunchName) => _brunchName = brunchName;

  Sales.fromJson(Map<String, dynamic> json) {
    _saleMasterSlNo = json['SaleMaster_SlNo'];
    _saleMasterInvoiceNo = json['SaleMaster_InvoiceNo'];
    _salseCustomerIDNo = json['SalseCustomer_IDNo'];
    _employeeId = json['employee_id'];
    _saleMasterSaleDate = json['SaleMaster_SaleDate'];
    _saleMasterDescription = json['SaleMaster_Description'];
    _saleMasterSaleType = json['SaleMaster_SaleType'];
    _paymentType = json['payment_type'];
    _saleMasterTotalSaleAmount = json['SaleMaster_TotalSaleAmount'];
    _saleMasterTotalDiscountAmount = json['SaleMaster_TotalDiscountAmount'];
    _saleMasterTaxAmount = json['SaleMaster_TaxAmount'];
    _saleMasterFreight = json['SaleMaster_Freight'];
    _saleMasterSubTotalAmount = json['SaleMaster_SubTotalAmount'];
    _saleMasterPaidAmount = json['SaleMaster_PaidAmount'];
    _saleMasterDueAmount = json['SaleMaster_DueAmount'];
    _saleMasterPreviousDue = json['SaleMaster_Previous_Due'];
    _status = json['Status'];
    _isService = json['is_service'];
    _addBy = json['AddBy'];
    _addTime = json['AddTime'];
    _updateBy = json['UpdateBy'];
    _updateTime = json['UpdateTime'];
    _saleMasterBranchid = json['SaleMaster_branchid'];
    _customerCode = json['Customer_Code'];
    _customerName = json['Customer_Name'];
    _customerMobile = json['Customer_Mobile'];
    _customerAddress = json['Customer_Address'];
    _customerType = json['Customer_Type'];
    _employeeName = json['Employee_Name'];
    _brunchName = json['Brunch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaleMaster_SlNo'] = this._saleMasterSlNo;
    data['SaleMaster_InvoiceNo'] = this._saleMasterInvoiceNo;
    data['SalseCustomer_IDNo'] = this._salseCustomerIDNo;
    data['employee_id'] = this._employeeId;
    data['SaleMaster_SaleDate'] = this._saleMasterSaleDate;
    data['SaleMaster_Description'] = this._saleMasterDescription;
    data['SaleMaster_SaleType'] = this._saleMasterSaleType;
    data['payment_type'] = this._paymentType;
    data['SaleMaster_TotalSaleAmount'] = this._saleMasterTotalSaleAmount;
    data['SaleMaster_TotalDiscountAmount'] =
        this._saleMasterTotalDiscountAmount;
    data['SaleMaster_TaxAmount'] = this._saleMasterTaxAmount;
    data['SaleMaster_Freight'] = this._saleMasterFreight;
    data['SaleMaster_SubTotalAmount'] = this._saleMasterSubTotalAmount;
    data['SaleMaster_PaidAmount'] = this._saleMasterPaidAmount;
    data['SaleMaster_DueAmount'] = this._saleMasterDueAmount;
    data['SaleMaster_Previous_Due'] = this._saleMasterPreviousDue;
    data['Status'] = this._status;
    data['is_service'] = this._isService;
    data['AddBy'] = this._addBy;
    data['AddTime'] = this._addTime;
    data['UpdateBy'] = this._updateBy;
    data['UpdateTime'] = this._updateTime;
    data['SaleMaster_branchid'] = this._saleMasterBranchid;
    data['Customer_Code'] = this._customerCode;
    data['Customer_Name'] = this._customerName;
    data['Customer_Mobile'] = this._customerMobile;
    data['Customer_Address'] = this._customerAddress;
    data['Customer_Type'] = this._customerType;
    data['Employee_Name'] = this._employeeName;
    data['Brunch_name'] = this._brunchName;
    return data;
  }
}
