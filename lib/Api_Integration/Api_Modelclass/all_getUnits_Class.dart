class AllGetUnitsClass {
  String? unitSlNo;
  String? unitName;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;

  AllGetUnitsClass(
      {this.unitSlNo,
        this.unitName,
        this.status,
        this.addBy,
        this.addTime,
        this.updateBy,
        this.updateTime});

  AllGetUnitsClass.fromJson(Map<String, dynamic> json) {
    unitSlNo = json['Unit_SlNo'];
    unitName = json['Unit_Name'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Unit_SlNo'] = this.unitSlNo;
    data['Unit_Name'] = this.unitName;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}