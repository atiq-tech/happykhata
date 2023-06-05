class AllGetDistricesClass {
  String? districtSlNo;
  String? districtName;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;

  AllGetDistricesClass(
      {this.districtSlNo,
        this.districtName,
        this.status,
        this.addBy,
        this.addTime,
        this.updateBy,
        this.updateTime});

  AllGetDistricesClass.fromJson(Map<String, dynamic> json) {
    districtSlNo = json['District_SlNo'];
    districtName = json['District_Name'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['District_SlNo'] = this.districtSlNo;
    data['District_Name'] = this.districtName;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    return data;
  }
}