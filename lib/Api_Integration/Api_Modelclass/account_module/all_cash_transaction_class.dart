class AllCashTransactionsClass {
  String? trSlNo;
  String? trId;
  String? trDate;
  String? trType;
  String? trAccountType;
  String? accSlID;
  String? trDescription;
  String? inAmount;
  String? outAmount;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? trBranchid;
  String? accName;

  AllCashTransactionsClass(
      {this.trSlNo,
      this.trId,
      this.trDate,
      this.trType,
      this.trAccountType,
      this.accSlID,
      this.trDescription,
      this.inAmount,
      this.outAmount,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime,
      this.trBranchid,
      this.accName});

  AllCashTransactionsClass.fromJson(Map<String, dynamic> json) {
    trSlNo = json['Tr_SlNo'];
    trId = json['Tr_Id'];
    trDate = json['Tr_date'];
    trType = json['Tr_Type'];
    trAccountType = json['Tr_account_Type'];
    accSlID = json['Acc_SlID'];
    trDescription = json['Tr_Description'];
    inAmount = json['In_Amount'];
    outAmount = json['Out_Amount'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    trBranchid = json['Tr_branchid'];
    accName = json['Acc_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tr_SlNo'] = this.trSlNo;
    data['Tr_Id'] = this.trId;
    data['Tr_date'] = this.trDate;
    data['Tr_Type'] = this.trType;
    data['Tr_account_Type'] = this.trAccountType;
    data['Acc_SlID'] = this.accSlID;
    data['Tr_Description'] = this.trDescription;
    data['In_Amount'] = this.inAmount;
    data['Out_Amount'] = this.outAmount;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Tr_branchid'] = this.trBranchid;
    data['Acc_Name'] = this.accName;
    return data;
  }
}