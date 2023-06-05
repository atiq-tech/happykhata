class AllGetEmployeeClass {
  String? employeeSlNo;
  String? designationID;
  String? departmentID;
  String? employeeID;
  String? employeeName;
  String? employeeJoinDate;
  String? employeeGender;
  String? employeeBirthDate;
  String? employeeNID;
  String? employeeContactNo;
  String? employeeEmail;
  String? employeeMaritalStatus;
  String? employeeFatherName;
  String? employeeMotherName;
  String? employeePrasentAddress;
  String? employeePermanentAddress;
  String? employeePicOrg;
  String? employeePicThum;
  String? salaryRange;
  String? status;
  String? addBy;
  String? addTime;
  String? updateBy;
  String? updateTime;
  String? employeeBrinchid;
  String? dailySalary;
  String? departmentName;
  String? designationName;
  String? displayName;

  AllGetEmployeeClass(
      {this.employeeSlNo,
        this.designationID,
        this.departmentID,
        this.employeeID,
        this.employeeName,
        this.employeeJoinDate,
        this.employeeGender,
        this.employeeBirthDate,
        this.employeeNID,
        this.employeeContactNo,
        this.employeeEmail,
        this.employeeMaritalStatus,
        this.employeeFatherName,
        this.employeeMotherName,
        this.employeePrasentAddress,
        this.employeePermanentAddress,
        this.employeePicOrg,
        this.employeePicThum,
        this.salaryRange,
        this.status,
        this.addBy,
        this.addTime,
        this.updateBy,
        this.updateTime,
        this.employeeBrinchid,
        this.dailySalary,
        this.departmentName,
        this.designationName,
        this.displayName});

  AllGetEmployeeClass.fromJson(Map<String, dynamic> json) {
    employeeSlNo = json['Employee_SlNo'];
    designationID = json['Designation_ID'];
    departmentID = json['Department_ID'];
    employeeID = json['Employee_ID'];
    employeeName = json['Employee_Name'];
    employeeJoinDate = json['Employee_JoinDate'];
    employeeGender = json['Employee_Gender'];
    employeeBirthDate = json['Employee_BirthDate'];
    employeeNID = json['Employee_NID'];
    employeeContactNo = json['Employee_ContactNo'];
    employeeEmail = json['Employee_Email'];
    employeeMaritalStatus = json['Employee_MaritalStatus'];
    employeeFatherName = json['Employee_FatherName'];
    employeeMotherName = json['Employee_MotherName'];
    employeePrasentAddress = json['Employee_PrasentAddress'];
    employeePermanentAddress = json['Employee_PermanentAddress'];
    employeePicOrg = json['Employee_Pic_org'];
    employeePicThum = json['Employee_Pic_thum'];
    salaryRange = json['salary_range'];
    status = json['status'];
    addBy = json['AddBy'];
    addTime = json['AddTime'];
    updateBy = json['UpdateBy'];
    updateTime = json['UpdateTime'];
    employeeBrinchid = json['Employee_brinchid'];
    dailySalary = json['daily_salary'];
    departmentName = json['Department_Name'];
    designationName = json['Designation_Name'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Employee_SlNo'] = this.employeeSlNo;
    data['Designation_ID'] = this.designationID;
    data['Department_ID'] = this.departmentID;
    data['Employee_ID'] = this.employeeID;
    data['Employee_Name'] = this.employeeName;
    data['Employee_JoinDate'] = this.employeeJoinDate;
    data['Employee_Gender'] = this.employeeGender;
    data['Employee_BirthDate'] = this.employeeBirthDate;
    data['Employee_NID'] = this.employeeNID;
    data['Employee_ContactNo'] = this.employeeContactNo;
    data['Employee_Email'] = this.employeeEmail;
    data['Employee_MaritalStatus'] = this.employeeMaritalStatus;
    data['Employee_FatherName'] = this.employeeFatherName;
    data['Employee_MotherName'] = this.employeeMotherName;
    data['Employee_PrasentAddress'] = this.employeePrasentAddress;
    data['Employee_PermanentAddress'] = this.employeePermanentAddress;
    data['Employee_Pic_org'] = this.employeePicOrg;
    data['Employee_Pic_thum'] = this.employeePicThum;
    data['salary_range'] = this.salaryRange;
    data['status'] = this.status;
    data['AddBy'] = this.addBy;
    data['AddTime'] = this.addTime;
    data['UpdateBy'] = this.updateBy;
    data['UpdateTime'] = this.updateTime;
    data['Employee_brinchid'] = this.employeeBrinchid;
    data['daily_salary'] = this.dailySalary;
    data['Department_Name'] = this.departmentName;
    data['Designation_Name'] = this.designationName;
    data['display_name'] = this.displayName;
    return data;
  }
}