class AllAccountsModelClass {
  String? accSlNo;
  String? branchId;
  String? accCode;
  String? accTrType;
  String? accName;
  String? accType;
  String? accDescription;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;

  AllAccountsModelClass(
      {this.accSlNo,
      this.branchId,
      this.accCode,
      this.accTrType,
      this.accName,
      this.accType,
      this.accDescription,
      this.status,
      this.addBy,
      this.addTime,
      this.updateBy,
      this.updateTime});

  AllAccountsModelClass.fromJson(Map<String, dynamic> json) {
    accSlNo = json['Acc_SlNo'];
    branchId = json['branch_id'];
    accCode = json['Acc_Code'];
    accTrType = json['Acc_Tr_Type'];
    accName = json['Acc_Name'];
    accType = json['Acc_Type'];
    accDescription = json['Acc_Description'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Acc_SlNo'] = this.accSlNo;
    data['branch_id'] = this.branchId;
    data['Acc_Code'] = this.accCode;
    data['Acc_Tr_Type'] = this.accTrType;
    data['Acc_Name'] = this.accName;
    data['Acc_Type'] = this.accType;
    data['Acc_Description'] = this.accDescription;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}