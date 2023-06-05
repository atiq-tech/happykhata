class AllCustomersClass {
  String? customerSlNo;
  String? customerCode;
  String? customerName;
  String? customerType;
  String? customerPhone;
  String? customerMobile;
  String? customerEmail;
  String? customerOfficePhone;
  String? customerAddress;
  String? ownerName;
  String? countrySlNo;
  String? areaID;
  String? customerWeb;
  String? customerCreditLimit;
  String? previousDue;
  String? imageName;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? customerBrunchid;
  String? districtName;
  String? displayName;

  AllCustomersClass(
      {this.customerSlNo,
      this.customerCode,
      this.customerName,
      this.customerType,
      this.customerPhone,
      this.customerMobile,
      this.customerEmail,
      this.customerOfficePhone,
      this.customerAddress,
      this.ownerName,
      this.countrySlNo,
      this.areaID,
      this.customerWeb,
      this.customerCreditLimit,
      this.previousDue,
      this.imageName,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.customerBrunchid,
      this.districtName,
      this.displayName});

  AllCustomersClass.fromJson(Map<String, dynamic> json) {
    customerSlNo = json['Customer_SlNo'];
    customerCode = json['Customer_Code'];
    customerName = json['Customer_Name'];
    customerType = json['Customer_Type'];
    customerPhone = json['Customer_Phone'];
    customerMobile = json['Customer_Mobile'];
    customerEmail = json['Customer_Email'];
    customerOfficePhone = json['Customer_OfficePhone'];
    customerAddress = json['Customer_Address'];
    ownerName = json['owner_name'];
    countrySlNo = json['Country_SlNo'];
    areaID = json['area_ID'];
    customerWeb = json['Customer_Web'];
    customerCreditLimit = json['Customer_Credit_Limit'];
    previousDue = json['previous_due'];
    imageName = json['image_name'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    customerBrunchid = json['Customer_brunchid'];
    districtName = json['District_Name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Customer_SlNo'] = this.customerSlNo;
    data['Customer_Code'] = this.customerCode;
    data['Customer_Name'] = this.customerName;
    data['Customer_Type'] = this.customerType;
    data['Customer_Phone'] = this.customerPhone;
    data['Customer_Mobile'] = this.customerMobile;
    data['Customer_Email'] = this.customerEmail;
    data['Customer_OfficePhone'] = this.customerOfficePhone;
    data['Customer_Address'] = this.customerAddress;
    data['owner_name'] = this.ownerName;
    data['Country_SlNo'] = this.countrySlNo;
    data['area_ID'] = this.areaID;
    data['Customer_Web'] = this.customerWeb;
    data['Customer_Credit_Limit'] = this.customerCreditLimit;
    data['previous_due'] = this.previousDue;
    data['image_name'] = this.imageName;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Customer_brunchid'] = this.customerBrunchid;
    data['District_Name'] = this.districtName;
    data['display_name'] = this.displayName;
    return data;
  }
}
