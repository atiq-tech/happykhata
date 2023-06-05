class SupplierPaymentModel {
  String? sPaymentId;
  String? sPaymentDate;
  String? sPaymentInvoice;
  String? sPaymentCustomerID;
  String? sPaymentTransactionType;
  String? sPaymentAmount;
  String? sPaymentPaymentby;
  String? accountId;
  String? sPaymentNotes;
  String? sPaymentBrunchid;
  String? sPaymentStatus;
  String? sPaymentAddby;
  String? sPaymentAddDAte;
  String? updateBy;
  String? sPaymentUpdateDAte;
  String? supplierCode;
  String? supplierName;
  String? supplierMobile;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? transactionType;
  String? paymentBy;

  SupplierPaymentModel(
      {this.sPaymentId,
      this.sPaymentDate,
      this.sPaymentInvoice,
      this.sPaymentCustomerID,
      this.sPaymentTransactionType,
      this.sPaymentAmount,
      this.sPaymentPaymentby,
      this.accountId,
      this.sPaymentNotes,
      this.sPaymentBrunchid,
      this.sPaymentStatus,
      this.sPaymentAddby,
      this.sPaymentAddDAte,
      this.updateBy,
      this.sPaymentUpdateDAte,
      this.supplierCode,
      this.supplierName,
      this.supplierMobile,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.transactionType,
      this.paymentBy});

  SupplierPaymentModel.fromJson(Map<String, dynamic> json) {
    sPaymentId = json['SPayment_id'];
    sPaymentDate = json['SPayment_date'];
    sPaymentInvoice = json['SPayment_invoice'];
    sPaymentCustomerID = json['SPayment_customerID'];
    sPaymentTransactionType = json['SPayment_TransactionType'];
    sPaymentAmount = json['SPayment_amount'];
    sPaymentPaymentby = json['SPayment_Paymentby'];
    accountId = json['account_id'];
    sPaymentNotes = json['SPayment_notes'];
    sPaymentBrunchid = json['SPayment_brunchid'];
    sPaymentStatus = json['SPayment_status'];
    sPaymentAddby = json['SPayment_Addby'];
    sPaymentAddDAte = json['SPayment_AddDAte'];
    updateBy = json['update_by'];
    sPaymentUpdateDAte = json['SPayment_UpdateDAte'];
    supplierCode = json['Supplier_Code'];
    supplierName = json['Supplier_Name'];
    supplierMobile = json['Supplier_Mobile'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    transactionType = json['transaction_type'];
    paymentBy = json['payment_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SPayment_id'] = this.sPaymentId;
    data['SPayment_date'] = this.sPaymentDate;
    data['SPayment_invoice'] = this.sPaymentInvoice;
    data['SPayment_customerID'] = this.sPaymentCustomerID;
    data['SPayment_TransactionType'] = this.sPaymentTransactionType;
    data['SPayment_amount'] = this.sPaymentAmount;
    data['SPayment_Paymentby'] = this.sPaymentPaymentby;
    data['account_id'] = this.accountId;
    data['SPayment_notes'] = this.sPaymentNotes;
    data['SPayment_brunchid'] = this.sPaymentBrunchid;
    data['SPayment_status'] = this.sPaymentStatus;
    data['SPayment_Addby'] = this.sPaymentAddby;
    data['SPayment_AddDAte'] = this.sPaymentAddDAte;
    data['update_by'] = this.updateBy;
    data['SPayment_UpdateDAte'] = this.sPaymentUpdateDAte;
    data['Supplier_Code'] = this.supplierCode;
    data['Supplier_Name'] = this.supplierName;
    data['Supplier_Mobile'] = this.supplierMobile;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['transaction_type'] = this.transactionType;
    data['payment_by'] = this.paymentBy;
    return data;
  }
}
