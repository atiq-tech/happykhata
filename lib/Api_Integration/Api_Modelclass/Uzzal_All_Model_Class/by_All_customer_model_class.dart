class By_all_Customer {
  String? _customerSlNo;
  String? _customerCode;
  String? _customerName;
  String? _customerType;
  String? _customerPhone;
  String? _customerMobile;
  String? _customerEmail;
  String? _customerOfficePhone;
  String? _customerAddress;
  String? _ownerName;
  String? _countrySlNo;
  String? _areaID;
  String? _customerWeb;
  String? _customerCreditLimit;
  String? _previousDue;
  String? _imageName;
  String? _status;
  String? _addBy;
  String? _addTime;
  String? _updateBy;
  String? _updateTime;
  String? _customerBrunchid;
  String? _districtName;
  String? _displayName;

  By_all_Customer(
      {String? customerSlNo,
        String? customerCode,
        String? customerName,
        String? customerType,
        String? customerPhone,
        String? customerMobile,
        String? customerEmail,
        String? customerOfficePhone,
        String? customerAddress,
        String? ownerName,
        String? countrySlNo,
        String? areaID,
        String? customerWeb,
        String? customerCreditLimit,
        String? previousDue,
        String? imageName,
        String? status,
        String? addBy,
        String? addTime,
        String? updateBy,
        String? updateTime,
        String? customerBrunchid,
        String? districtName,
        String? displayName}) {
    if (customerSlNo != null) {
      this._customerSlNo = customerSlNo;
    }
    if (customerCode != null) {
      this._customerCode = customerCode;
    }
    if (customerName != null) {
      this._customerName = customerName;
    }
    if (customerType != null) {
      this._customerType = customerType;
    }
    if (customerPhone != null) {
      this._customerPhone = customerPhone;
    }
    if (customerMobile != null) {
      this._customerMobile = customerMobile;
    }
    if (customerEmail != null) {
      this._customerEmail = customerEmail;
    }
    if (customerOfficePhone != null) {
      this._customerOfficePhone = customerOfficePhone;
    }
    if (customerAddress != null) {
      this._customerAddress = customerAddress;
    }
    if (ownerName != null) {
      this._ownerName = ownerName;
    }
    if (countrySlNo != null) {
      this._countrySlNo = countrySlNo;
    }
    if (areaID != null) {
      this._areaID = areaID;
    }
    if (customerWeb != null) {
      this._customerWeb = customerWeb;
    }
    if (customerCreditLimit != null) {
      this._customerCreditLimit = customerCreditLimit;
    }
    if (previousDue != null) {
      this._previousDue = previousDue;
    }
    if (imageName != null) {
      this._imageName = imageName;
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
    if (customerBrunchid != null) {
      this._customerBrunchid = customerBrunchid;
    }
    if (districtName != null) {
      this._districtName = districtName;
    }
    if (displayName != null) {
      this._displayName = displayName;
    }
  }

  String? get customerSlNo => _customerSlNo;
  set customerSlNo(String? customerSlNo) => _customerSlNo = customerSlNo;
  String? get customerCode => _customerCode;
  set customerCode(String? customerCode) => _customerCode = customerCode;
  String? get customerName => _customerName;
  set customerName(String? customerName) => _customerName = customerName;
  String? get customerType => _customerType;
  set customerType(String? customerType) => _customerType = customerType;
  String? get customerPhone => _customerPhone;
  set customerPhone(String? customerPhone) => _customerPhone = customerPhone;
  String? get customerMobile => _customerMobile;
  set customerMobile(String? customerMobile) =>
      _customerMobile = customerMobile;
  String? get customerEmail => _customerEmail;
  set customerEmail(String? customerEmail) => _customerEmail = customerEmail;
  String? get customerOfficePhone => _customerOfficePhone;
  set customerOfficePhone(String? customerOfficePhone) =>
      _customerOfficePhone = customerOfficePhone;
  String? get customerAddress => _customerAddress;
  set customerAddress(String? customerAddress) =>
      _customerAddress = customerAddress;
  String? get ownerName => _ownerName;
  set ownerName(String? ownerName) => _ownerName = ownerName;
  String? get countrySlNo => _countrySlNo;
  set countrySlNo(String? countrySlNo) => _countrySlNo = countrySlNo;
  String? get areaID => _areaID;
  set areaID(String? areaID) => _areaID = areaID;
  String? get customerWeb => _customerWeb;
  set customerWeb(String? customerWeb) => _customerWeb = customerWeb;
  String? get customerCreditLimit => _customerCreditLimit;
  set customerCreditLimit(String? customerCreditLimit) =>
      _customerCreditLimit = customerCreditLimit;
  String? get previousDue => _previousDue;
  set previousDue(String? previousDue) => _previousDue = previousDue;
  String? get imageName => _imageName;
  set imageName(String? imageName) => _imageName = imageName;
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
  String? get customerBrunchid => _customerBrunchid;
  set customerBrunchid(String? customerBrunchid) =>
      _customerBrunchid = customerBrunchid;
  String? get districtName => _districtName;
  set districtName(String? districtName) => _districtName = districtName;
  String? get displayName => _displayName;
  set displayName(String? displayName) => _displayName = displayName;

  By_all_Customer.fromJson(Map<String, dynamic> json) {
    _customerSlNo = json['Customer_SlNo'];
    _customerCode = json['Customer_Code'];
    _customerName = json['Customer_Name'];
    _customerType = json['Customer_Type'];
    _customerPhone = json['Customer_Phone'];
    _customerMobile = json['Customer_Mobile'];
    _customerEmail = json['Customer_Email'];
    _customerOfficePhone = json['Customer_OfficePhone'];
    _customerAddress = json['Customer_Address'];
    _ownerName = json['owner_name'];
    _countrySlNo = json['Country_SlNo'];
    _areaID = json['area_ID'];
    _customerWeb = json['Customer_Web'];
    _customerCreditLimit = json['Customer_Credit_Limit'];
    _previousDue = json['previous_due'];
    _imageName = json['image_name'];
    _status = json['status'];
    _addBy = json['AddBy'];
    _addTime = json['AddTime'];
    _updateBy = json['UpdateBy'];
    _updateTime = json['UpdateTime'];
    _customerBrunchid = json['Customer_brunchid'];
    _districtName = json['District_Name'];
    _displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Customer_SlNo'] = this._customerSlNo;
    data['Customer_Code'] = this._customerCode;
    data['Customer_Name'] = this._customerName;
    data['Customer_Type'] = this._customerType;
    data['Customer_Phone'] = this._customerPhone;
    data['Customer_Mobile'] = this._customerMobile;
    data['Customer_Email'] = this._customerEmail;
    data['Customer_OfficePhone'] = this._customerOfficePhone;
    data['Customer_Address'] = this._customerAddress;
    data['owner_name'] = this._ownerName;
    data['Country_SlNo'] = this._countrySlNo;
    data['area_ID'] = this._areaID;
    data['Customer_Web'] = this._customerWeb;
    data['Customer_Credit_Limit'] = this._customerCreditLimit;
    data['previous_due'] = this._previousDue;
    data['image_name'] = this._imageName;
    data['status'] = this._status;
    data['AddBy'] = this._addBy;
    data['AddTime'] = this._addTime;
    data['UpdateBy'] = this._updateBy;
    data['UpdateTime'] = this._updateTime;
    data['Customer_brunchid'] = this._customerBrunchid;
    data['District_Name'] = this._districtName;
    data['display_name'] = this._displayName;
    return data;
  }
}
