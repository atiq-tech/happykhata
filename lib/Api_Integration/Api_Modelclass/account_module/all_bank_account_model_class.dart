class AllBankAccountModelClass {
  String? accountId;
  String? accountName;
  String? accountNumber;
  String? accountType;
  String? bankName;
  String? branchName;
  String? initialBalance;
  String? description;
  String? savedBy;
  String? savedDatetime;
  String? updatedBy;
  String? updatedDatetime;
  String? branchId;
  String? status;
  String? statusText;

  AllBankAccountModelClass(
      {this.accountId,
      this.accountName,
      this.accountNumber,
      this.accountType,
      this.bankName,
      this.branchName,
      this.initialBalance,
      this.description,
      this.savedBy,
      this.savedDatetime,
      this.updatedBy,
      this.updatedDatetime,
      this.branchId,
      this.status,
      this.statusText});

  AllBankAccountModelClass.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    accountType = json['account_type'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    initialBalance = json['initial_balance'];
    description = json['description'];
    savedBy = json['saved_by'];
    savedDatetime = json['saved_datetime'];
    updatedBy = json['updated_by'];
    updatedDatetime = json['updated_datetime'];
    branchId = json['branch_id'];
    status = json['status'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_id'] = this.accountId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['account_type'] = this.accountType;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['initial_balance'] = this.initialBalance;
    data['description'] = this.description;
    data['saved_by'] = this.savedBy;
    data['saved_datetime'] = this.savedDatetime;
    data['updated_by'] = this.updatedBy;
    data['updated_datetime'] = this.updatedDatetime;
    data['branch_id'] = this.branchId;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    return data;
  }
}