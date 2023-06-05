class CashStatementModel {
  List<Sales>? sales;

  CashStatementModel({this.sales});

  CashStatementModel.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(new Sales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sales != null) {
      data['sales'] = this.sales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sales {
  String? saleMasterSlNo;
  String? saleMasterInvoiceNo;
  String? salseCustomerIDNo;
  String? employeeId;
  String? saleMasterSaleDate;
  String? saleMasterDescription;
  String? saleMasterSaleType;
  String? paymentType;
  String? saleMasterTotalSaleAmount;
  String? saleMasterTotalDiscountAmount;
  String? saleMasterTaxAmount;
  String? saleMasterFreight;
  String? saleMasterSubTotalAmount;
  String? saleMasterPaidAmount;
  String? saleMasterDueAmount;
  String? saleMasterPreviousDue;
  String? status;
  String? isService;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? saleMasterBranchid;
  String? customerCode;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  String? customerType;
  String? employeeName;
  String? brunchName;

  Sales(
      {this.saleMasterSlNo,
      this.saleMasterInvoiceNo,
      this.salseCustomerIDNo,
      this.employeeId,
      this.saleMasterSaleDate,
      this.saleMasterDescription,
      this.saleMasterSaleType,
      this.paymentType,
      this.saleMasterTotalSaleAmount,
      this.saleMasterTotalDiscountAmount,
      this.saleMasterTaxAmount,
      this.saleMasterFreight,
      this.saleMasterSubTotalAmount,
      this.saleMasterPaidAmount,
      this.saleMasterDueAmount,
      this.saleMasterPreviousDue,
      this.status,
      this.isService,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.saleMasterBranchid,
      this.customerCode,
      this.customerName,
      this.customerMobile,
      this.customerAddress,
      this.customerType,
      this.employeeName,
      this.brunchName});

  Sales.fromJson(Map<String, dynamic> json) {
    saleMasterSlNo = json['SaleMaster_SlNo'];
    saleMasterInvoiceNo = json['SaleMaster_InvoiceNo'];
    salseCustomerIDNo = json['SalseCustomer_IDNo'];
    employeeId = json['employee_id'];
    saleMasterSaleDate = json['SaleMaster_SaleDate'];
    saleMasterDescription = json['SaleMaster_Description'];
    saleMasterSaleType = json['SaleMaster_SaleType'];
    paymentType = json['payment_type'];
    saleMasterTotalSaleAmount = json['SaleMaster_TotalSaleAmount'];
    saleMasterTotalDiscountAmount = json['SaleMaster_TotalDiscountAmount'];
    saleMasterTaxAmount = json['SaleMaster_TaxAmount'];
    saleMasterFreight = json['SaleMaster_Freight'];
    saleMasterSubTotalAmount = json['SaleMaster_SubTotalAmount'];
    saleMasterPaidAmount = json['SaleMaster_PaidAmount'];
    saleMasterDueAmount = json['SaleMaster_DueAmount'];
    saleMasterPreviousDue = json['SaleMaster_Previous_Due'];
    status = json['Status'];
    isService = json['is_service'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    saleMasterBranchid = json['SaleMaster_branchid'];
    customerCode = json['Customer_Code'];
    customerName = json['Customer_Name'];
    customerMobile = json['Customer_Mobile'];
    customerAddress = json['Customer_Address'];
    customerType = json['Customer_Type'];
    employeeName = json['Employee_Name'];
    brunchName = json['Brunch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SaleMaster_SlNo'] = this.saleMasterSlNo;
    data['SaleMaster_InvoiceNo'] = this.saleMasterInvoiceNo;
    data['SalseCustomer_IDNo'] = this.salseCustomerIDNo;
    data['employee_id'] = this.employeeId;
    data['SaleMaster_SaleDate'] = this.saleMasterSaleDate;
    data['SaleMaster_Description'] = this.saleMasterDescription;
    data['SaleMaster_SaleType'] = this.saleMasterSaleType;
    data['payment_type'] = this.paymentType;
    data['SaleMaster_TotalSaleAmount'] = this.saleMasterTotalSaleAmount;
    data['SaleMaster_TotalDiscountAmount'] = this.saleMasterTotalDiscountAmount;
    data['SaleMaster_TaxAmount'] = this.saleMasterTaxAmount;
    data['SaleMaster_Freight'] = this.saleMasterFreight;
    data['SaleMaster_SubTotalAmount'] = this.saleMasterSubTotalAmount;
    data['SaleMaster_PaidAmount'] = this.saleMasterPaidAmount;
    data['SaleMaster_DueAmount'] = this.saleMasterDueAmount;
    data['SaleMaster_Previous_Due'] = this.saleMasterPreviousDue;
    data['Status'] = this.status;
    data['is_service'] = this.isService;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['SaleMaster_branchid'] = this.saleMasterBranchid;
    data['Customer_Code'] = this.customerCode;
    data['Customer_Name'] = this.customerName;
    data['Customer_Mobile'] = this.customerMobile;
    data['Customer_Address'] = this.customerAddress;
    data['Customer_Type'] = this.customerType;
    data['Employee_Name'] = this.employeeName;
    data['Brunch_name'] = this.brunchName;
    return data;
  }
}
