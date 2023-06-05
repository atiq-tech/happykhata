class AllCustomerDueList {
  String? _customerSlNo;
  String? _customerName;
  String? _customerCode;
  String? _customerAddress;
  String? _customerMobile;
  String? _billAmount;
  String? _invoicePaid;
  String? _cashReceived;
  String? _paidOutAmount;
  String? _returnedAmount;
  String? _paidAmount;
  String? _dueAmount;

  AllCustomerDueList(
      {String? customerSlNo,
        String? customerName,
        String? customerCode,
        String? customerAddress,
        String? customerMobile,
        String? billAmount,
        String? invoicePaid,
        String? cashReceived,
        String? paidOutAmount,
        String? returnedAmount,
        String? paidAmount,
        String? dueAmount}) {
    if (customerSlNo != null) {
      this._customerSlNo = customerSlNo;
    }
    if (customerName != null) {
      this._customerName = customerName;
    }
    if (customerCode != null) {
      this._customerCode = customerCode;
    }
    if (customerAddress != null) {
      this._customerAddress = customerAddress;
    }
    if (customerMobile != null) {
      this._customerMobile = customerMobile;
    }
    if (billAmount != null) {
      this._billAmount = billAmount;
    }
    if (invoicePaid != null) {
      this._invoicePaid = invoicePaid;
    }
    if (cashReceived != null) {
      this._cashReceived = cashReceived;
    }
    if (paidOutAmount != null) {
      this._paidOutAmount = paidOutAmount;
    }
    if (returnedAmount != null) {
      this._returnedAmount = returnedAmount;
    }
    if (paidAmount != null) {
      this._paidAmount = paidAmount;
    }
    if (dueAmount != null) {
      this._dueAmount = dueAmount;
    }
  }

  String? get customerSlNo => _customerSlNo;
  set customerSlNo(String? customerSlNo) => _customerSlNo = customerSlNo;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get customerCode => _customerCode;
  set customerCode(String? customerCode) => _customerCode = customerCode;
  String? get customerAddress => _customerAddress;
  set customerAddress(String? customerAddress) =>
      _customerAddress = customerAddress;
  String? get customerMobile => _customerMobile;
  set customerMobile(String? customerMobile) =>
      _customerMobile = customerMobile;
  String? get billAmount => _billAmount;
  set billAmount(String? billAmount) => _billAmount = billAmount;
  String? get invoicePaid => _invoicePaid;
  set invoicePaid(String? invoicePaid) => _invoicePaid = invoicePaid;
  String? get cashReceived => _cashReceived;
  set cashReceived(String? cashReceived) => _cashReceived = cashReceived;
  String? get paidOutAmount => _paidOutAmount;
  set paidOutAmount(String? paidOutAmount) => _paidOutAmount = paidOutAmount;
  String? get returnedAmount => _returnedAmount;
  set returnedAmount(String? returnedAmount) =>
      _returnedAmount = returnedAmount;
  String? get paidAmount => _paidAmount;
  set paidAmount(String? paidAmount) => _paidAmount = paidAmount;
  String? get dueAmount => _dueAmount;
  set dueAmount(String? dueAmount) => _dueAmount = dueAmount;

  AllCustomerDueList.fromJson(Map<String, dynamic> json) {
    _customerSlNo = json['Customer_SlNo'];
    _customerName = json['Customer_Name'];
    _customerCode = json['Customer_Code'];
    _customerAddress = json['Customer_Address'];
    _customerMobile = json['Customer_Mobile'];
    _billAmount = json['billAmount'];
    _invoicePaid = json['invoicePaid'];
    _cashReceived = json['cashReceived'];
    _paidOutAmount = json['paidOutAmount'];
    _returnedAmount = json['returnedAmount'];
    _paidAmount = json['paidAmount'];
    _dueAmount = json['dueAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Customer_SlNo'] = this._customerSlNo;
    data['Customer_Name'] = this._customerName;
    data['Customer_Code'] = this._customerCode;
    data['Customer_Address'] = this._customerAddress;
    data['Customer_Mobile'] = this._customerMobile;
    data['billAmount'] = this._billAmount;
    data['invoicePaid'] = this._invoicePaid;
    data['cashReceived'] = this._cashReceived;
    data['paidOutAmount'] = this._paidOutAmount;
    data['returnedAmount'] = this._returnedAmount;
    data['paidAmount'] = this._paidAmount;
    data['dueAmount'] = this._dueAmount;
    return data;
  }
}
