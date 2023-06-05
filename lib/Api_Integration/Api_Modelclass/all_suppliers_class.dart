class AllSuppliersClass {
  String? supplierSlNo;
  String? supplierCode;
  String? supplierName;
  String? supplierType;
  String? supplierPhone;
  String? supplierMobile;
  String? supplierEmail;
  String? supplierOfficePhone;
  String? supplierAddress;
  String? contactPerson;
  String? districtSlNo;
  String? countrySlNo;
  String? supplierWeb;
  String? previousDue;
  String? imageName;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? supplierBrinchid;
  String? displayName;

  AllSuppliersClass(
      {this.supplierSlNo,
      this.supplierCode,
      this.supplierName,
      this.supplierType,
      this.supplierPhone,
      this.supplierMobile,
      this.supplierEmail,
      this.supplierOfficePhone,
      this.supplierAddress,
      this.contactPerson,
      this.districtSlNo,
      this.countrySlNo,
      this.supplierWeb,
      this.previousDue,
      this.imageName,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.supplierBrinchid,
      this.displayName});

  AllSuppliersClass.fromJson(Map<String, dynamic> json) {
    supplierSlNo = json['Supplier_SlNo'];
    supplierCode = json['Supplier_Code'];
    supplierName = json['Supplier_Name'];
    supplierType = json['Supplier_Type'];
    supplierPhone = json['Supplier_Phone'];
    supplierMobile = json['Supplier_Mobile'];
    supplierEmail = json['Supplier_Email'];
    supplierOfficePhone = json['Supplier_OfficePhone'];
    supplierAddress = json['Supplier_Address'];
    contactPerson = json['contact_person'];
    districtSlNo = json['District_SlNo'];
    countrySlNo = json['Country_SlNo'];
    supplierWeb = json['Supplier_Web'];
    previousDue = json['previous_due'];
    imageName = json['image_name'];
    status = json['Status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    supplierBrinchid = json['Supplier_brinchid'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Supplier_SlNo'] = this.supplierSlNo;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Name'] = this.supplierName;
    data['Supplier_Type'] = this.supplierType;
    data['Supplier_Phone'] = this.supplierPhone;
    data['Supplier_Mobile'] = this.supplierMobile;
    data['Supplier_Email'] = this.supplierEmail;
    data['Supplier_OfficePhone'] = this.supplierOfficePhone;
    data['Supplier_Address'] = this.supplierAddress;
    data['contact_person'] = this.contactPerson;
    data['District_SlNo'] = this.districtSlNo;
    data['Country_SlNo'] = this.countrySlNo;
    data['Supplier_Web'] = this.supplierWeb;
    data['previous_due'] = this.previousDue;
    data['image_name'] = this.imageName;
    data['Status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Supplier_brinchid'] = this.supplierBrinchid;
    data['display_name'] = this.displayName;
    return data;
  }
}
