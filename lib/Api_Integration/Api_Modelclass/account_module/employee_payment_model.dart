class EmployerPaymentModel {
  String? employeePaymentId;
  String? employeeSlNo;
  String? paymentDate;
  String? monthId;
  String? description;
  String? paymentAmount;
  String? deductionAmount;
  String? status;
  String? saveBy;
  String? saveDate;
  String? updateBy;
  String? updateDate;
  String? paymentBranchId;
  String? employeeName;
  String? employeeID;
  String? salaryRange;
  String? departmentName;
  String? designationName;
  String? monthName;

  EmployerPaymentModel(
      {this.employeePaymentId,
      this.employeeSlNo,
      this.paymentDate,
      this.monthId,
      this.description,
      this.paymentAmount,
      this.deductionAmount,
      this.status,
      this.saveBy,
      this.saveDate,
      this.updateBy,
      this.updateDate,
      this.paymentBranchId,
      this.employeeName,
      this.employeeID,
      this.salaryRange,
      this.departmentName,
      this.designationName,
      this.monthName});

  EmployerPaymentModel.fromJson(Map<String, dynamic> json) {
    employeePaymentId = json['employee_payment_id'];
    employeeSlNo = json['Employee_SlNo'];
    paymentDate = json['payment_date'];
    monthId = json['month_id'];
    description = json['description'];
    paymentAmount = json['payment_amount'];
    deductionAmount = json['deduction_amount'];
    status = json['status'];
    saveBy = json['save_by'];
    saveDate = json['save_date'];
    updateBy = json['update_by'];
    updateDate = json['update_date'];
    paymentBranchId = json['paymentBranch_id'];
    employeeName = json['Employee_Name'];
    employeeID = json['Employee_ID'];
    salaryRange = json['salary_range'];
    departmentName = json['Department_Name'];
    designationName = json['Designation_Name'];
    monthName = json['month_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_payment_id'] = this.employeePaymentId;
    data['Employee_SlNo'] = this.employeeSlNo;
    data['payment_date'] = this.paymentDate;
    data['month_id'] = this.monthId;
    data['description'] = this.description;
    data['payment_amount'] = this.paymentAmount;
    data['deduction_amount'] = this.deductionAmount;
    data['status'] = this.status;
    data['save_by'] = this.saveBy;
    data['save_date'] = this.saveDate;
    data['update_by'] = this.updateBy;
    data['update_date'] = this.updateDate;
    data['paymentBranch_id'] = this.paymentBranchId;
    data['Employee_Name'] = this.employeeName;
    data['Employee_ID'] = this.employeeID;
    data['salary_range'] = this.salaryRange;
    data['Department_Name'] = this.departmentName;
    data['Designation_Name'] = this.designationName;
    data['month_name'] = this.monthName;
    return data;
  }
}
