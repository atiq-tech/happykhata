class AllGetCustomerPaymentClass {
  String? cPaymentId;
  String? cPaymentDate;
  String? cPaymentInvoice;
  String? cPaymentCustomerID;
  String? cPaymentTransactionType;
  String? cPaymentAmount;
  String? outAmount;
  String? cPaymentPaymentby;
  String? accountId;
  String? cPaymentNotes;
  String? cPaymentBrunchid;
  String? cPaymentPreviousDue;
  String? cPaymentAddby;
  String? cPaymentAddDAte;
  String? cPaymentStatus;
  String? updateBy;
  String? cPaymentUpdateDAte;
  String? customerCode;
  String? customerName;
  String? customerMobile;
  String? customerType;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? transactionType;
  String? paymentBy;

  AllGetCustomerPaymentClass(
      {this.cPaymentId,
      this.cPaymentDate,
      this.cPaymentInvoice,
      this.cPaymentCustomerID,
      this.cPaymentTransactionType,
      this.cPaymentAmount,
      this.outAmount,
      this.cPaymentPaymentby,
      this.accountId,
      this.cPaymentNotes,
      this.cPaymentBrunchid,
      this.cPaymentPreviousDue,
      this.cPaymentAddby,
      this.cPaymentAddDAte,
      this.cPaymentStatus,
      this.updateBy,
      this.cPaymentUpdateDAte,
      this.customerCode,
      this.customerName,
      this.customerMobile,
      this.customerType,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.transactionType,
      this.paymentBy});

  AllGetCustomerPaymentClass.fromJson(Map<String, dynamic> json) {
    cPaymentId = json['CPayment_id'];
    cPaymentDate = json['CPayment_date'];
    cPaymentInvoice = json['CPayment_invoice'];
    cPaymentCustomerID = json['CPayment_customerID'];
    cPaymentTransactionType = json['CPayment_TransactionType'];
    cPaymentAmount = json['CPayment_amount'];
    outAmount = json['out_amount'];
    cPaymentPaymentby = json['CPayment_Paymentby'];
    accountId = json['account_id'];
    cPaymentNotes = json['CPayment_notes'];
    cPaymentBrunchid = json['CPayment_brunchid'];
    cPaymentPreviousDue = json['CPayment_previous_due'];
    cPaymentAddby = json['CPayment_Addby'];
    cPaymentAddDAte = json['CPayment_AddDAte'];
    cPaymentStatus = json['CPayment_status'];
    updateBy = json['update_by'];
    cPaymentUpdateDAte = json['CPayment_UpdateDAte'];
    customerCode = json['Customer_Code'];
    customerName = json['Customer_Name'];
    customerMobile = json['Customer_Mobile'];
    customerType = json['Customer_Type'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    transactionType = json['transaction_type'];
    paymentBy = json['payment_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CPayment_id'] = this.cPaymentId;
    data['CPayment_date'] = this.cPaymentDate;
    data['CPayment_invoice'] = this.cPaymentInvoice;
    data['CPayment_customerID'] = this.cPaymentCustomerID;
    data['CPayment_TransactionType'] = this.cPaymentTransactionType;
    data['CPayment_amount'] = this.cPaymentAmount;
    data['out_amount'] = this.outAmount;
    data['CPayment_Paymentby'] = this.cPaymentPaymentby;
    data['account_id'] = this.accountId;
    data['CPayment_notes'] = this.cPaymentNotes;
    data['CPayment_brunchid'] = this.cPaymentBrunchid;
    data['CPayment_previous_due'] = this.cPaymentPreviousDue;
    data['CPayment_Addby'] = this.cPaymentAddby;
    data['CPayment_AddDAte'] = this.cPaymentAddDAte;
    data['CPayment_status'] = this.cPaymentStatus;
    data['update_by'] = this.updateBy;
    data['CPayment_UpdateDAte'] = this.cPaymentUpdateDAte;
    data['Customer_Code'] = this.customerCode;
    data['Customer_Name'] = this.customerName;
    data['Customer_Mobile'] = this.customerMobile;
    data['Customer_Type'] = this.customerType;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['transaction_type'] = this.transactionType;
    data['payment_by'] = this.paymentBy;
    return data;
  }
}