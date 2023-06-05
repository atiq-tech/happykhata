class BankTransactionModel {
  String? transactionId;
  String? accountId;
  String? transactionDate;
  String? transactionType;
  String? amount;
  String? note;
  String? savedBy;
  String? savedDatetime;
  String? branchId;
  String? status;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? branchName;

  BankTransactionModel(
      {this.transactionId,
      this.accountId,
      this.transactionDate,
      this.transactionType,
      this.amount,
      this.note,
      this.savedBy,
      this.savedDatetime,
      this.branchId,
      this.status,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.branchName});

  BankTransactionModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    accountId = json['account_id'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    note = json['note'];
    savedBy = json['saved_by'];
    savedDatetime = json['saved_datetime'];
    branchId = json['branch_id'];
    status = json['status'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['account_id'] = this.accountId;
    data['transaction_date'] = this.transactionDate;
    data['transaction_type'] = this.transactionType;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['saved_by'] = this.savedBy;
    data['saved_datetime'] = this.savedDatetime;
    data['branch_id'] = this.branchId;
    data['status'] = this.status;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    return data;
  }
}
