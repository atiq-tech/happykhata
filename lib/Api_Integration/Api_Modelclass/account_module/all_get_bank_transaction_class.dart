class AllGetBankTransactionClass {
  String? sequence;
  String? id;
  String? description;
  String? accountId;
  String? transactionDate;
  String? transactionType;
  String? amount;
  String? note;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? branchName;

  AllGetBankTransactionClass(
      {this.sequence,
      this.id,
      this.description,
      this.accountId,
      this.transactionDate,
      this.transactionType,
      this.amount,
      this.note,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.branchName});

  AllGetBankTransactionClass.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    id = json['id'];
    description = json['description'];
    accountId = json['account_id'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    amount = json['amount'];
    note = json['note'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequence'] = this.sequence;
    data['id'] = this.id;
    data['description'] = this.description;
    data['account_id'] = this.accountId;
    data['transaction_date'] = this.transactionDate;
    data['transaction_type'] = this.transactionType;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    return data;
  }
}