class AllSupplierDueClass {
  String? supplierSlNo;
  String? supplierCode;
  String? supplierName;
  String? supplierMobile;
  String? supplierAddress;
  String? bill;
  String? invoicePaid;
  String? cashPaid;
  String? cashReceived;
  String? materialBill;
  String? paidForMaterial;
  String? returned;
  String? paid;
  String? due;

  AllSupplierDueClass(
      {this.supplierSlNo,
      this.supplierCode,
      this.supplierName,
      this.supplierMobile,
      this.supplierAddress,
      this.bill,
      this.invoicePaid,
      this.cashPaid,
      this.cashReceived,
      this.materialBill,
      this.paidForMaterial,
      this.returned,
      this.paid,
      this.due});

  AllSupplierDueClass.fromJson(Map<String, dynamic> json) {
    supplierSlNo = json['Supplier_SlNo'];
    supplierCode = json['Supplier_Code'];
    supplierName = json['Supplier_Name'];
    supplierMobile = json['Supplier_Mobile'];
    supplierAddress = json['Supplier_Address'];
    bill = json['bill'];
    invoicePaid = json['invoicePaid'];
    cashPaid = json['cashPaid'];
    cashReceived = json['cashReceived'];
    materialBill = json['material_bill'];
    paidForMaterial = json['paid_for_material'];
    returned = json['returned'];
    paid = json['paid'];
    due = json['due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Supplier_SlNo'] = this.supplierSlNo;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Name'] = this.supplierName;
    data['Supplier_Mobile'] = this.supplierMobile;
    data['Supplier_Address'] = this.supplierAddress;
    data['bill'] = this.bill;
    data['invoicePaid'] = this.invoicePaid;
    data['cashPaid'] = this.cashPaid;
    data['cashReceived'] = this.cashReceived;
    data['material_bill'] = this.materialBill;
    data['paid_for_material'] = this.paidForMaterial;
    data['returned'] = this.returned;
    data['paid'] = this.paid;
    data['due'] = this.due;
    return data;
  }
}