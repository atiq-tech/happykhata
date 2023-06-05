class AllMeterialPurchaseRecordClass {
  List<Purchases>? purchases;
  int? totalPurchase;
  int? totalPaid;
  int? totalDue;

  AllMeterialPurchaseRecordClass(
      {this.purchases, this.totalPurchase, this.totalPaid, this.totalDue});

  AllMeterialPurchaseRecordClass.fromJson(Map<String, dynamic> json) {
    if (json['purchases'] != null) {
      purchases = <Purchases>[];
      json['purchases'].forEach((v) {
        purchases!.add(new Purchases.fromJson(v));
      });
    }
    totalPurchase = json['totalPurchase'];
    totalPaid = json['totalPaid'];
    totalDue = json['totalDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.purchases != null) {
      data['purchases'] = this.purchases!.map((v) => v.toJson()).toList();
    }
    data['totalPurchase'] = this.totalPurchase;
    data['totalPaid'] = this.totalPaid;
    data['totalDue'] = this.totalDue;
    return data;
  }
}

class Purchases {
  String? purchaseId;
  String? supplierId;
  String? invoiceNo;
  String? purchaseDate;
  String? purchaseFor;
  String? subTotal;
  String? vat;
  String? transportCost;
  String? discount;
  String? total;
  String? paid;
  String? due;
  String? previousDue;
  String? note;
  String? status;
  String? branchId;
  String? supplierName;
  String? supplierCode;
  String? supplierMobile;
  String? supplierAddress;
  String? supplierType;

  Purchases(
      {this.purchaseId,
      this.supplierId,
      this.invoiceNo,
      this.purchaseDate,
      this.purchaseFor,
      this.subTotal,
      this.vat,
      this.transportCost,
      this.discount,
      this.total,
      this.paid,
      this.due,
      this.previousDue,
      this.note,
      this.status,
      this.branchId,
      this.supplierName,
      this.supplierCode,
      this.supplierMobile,
      this.supplierAddress,
      this.supplierType});

  Purchases.fromJson(Map<String, dynamic> json) {
    purchaseId = json['purchase_id'];
    supplierId = json['supplier_id'];
    invoiceNo = json['invoice_no'];
    purchaseDate = json['purchase_date'];
    purchaseFor = json['purchase_for'];
    subTotal = json['sub_total'];
    vat = json['vat'];
    transportCost = json['transport_cost'];
    discount = json['discount'];
    total = json['total'];
    paid = json['paid'];
    due = json['due'];
    previousDue = json['previous_due'];
    note = json['note'];
    status = json['status'];
    branchId = json['branch_id'];
    supplierName = json['supplier_name'];
    supplierCode = json['supplier_code'];
    supplierMobile = json['supplier_mobile'];
    supplierAddress = json['supplier_address'];
    supplierType = json['supplier_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_id'] = this.purchaseId;
    data['supplier_id'] = this.supplierId;
    data['invoice_no'] = this.invoiceNo;
    data['purchase_date'] = this.purchaseDate;
    data['purchase_for'] = this.purchaseFor;
    data['sub_total'] = this.subTotal;
    data['vat'] = this.vat;
    data['transport_cost'] = this.transportCost;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['paid'] = this.paid;
    data['due'] = this.due;
    data['previous_due'] = this.previousDue;
    data['note'] = this.note;
    data['status'] = this.status;
    data['branch_id'] = this.branchId;
    data['supplier_name'] = this.supplierName;
    data['supplier_code'] = this.supplierCode;
    data['supplier_mobile'] = this.supplierMobile;
    data['supplier_address'] = this.supplierAddress;
    data['supplier_type'] = this.supplierType;
    return data;
  }
}