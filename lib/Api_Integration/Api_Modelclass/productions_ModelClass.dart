class ProductionsModelClass {
  String? productionId;
  String? productionSl;
  String? date;
  String? inchargeId;
  String? shift;
  String? note;
  String? labourCost;
  String? transportCost;
  String? otherCost;
  String? totalCost;
  String? status;
  String? inchargeName;

  ProductionsModelClass(
      {this.productionId,
      this.productionSl,
      this.date,
      this.inchargeId,
      this.shift,
      this.note,
      this.labourCost,
      this.transportCost,
      this.otherCost,
      this.totalCost,
      this.status,
      this.inchargeName});

  ProductionsModelClass.fromJson(Map<String, dynamic> json) {
    productionId = json['production_id'];
    productionSl = json['production_sl'];
    date = json['date'];
    inchargeId = json['incharge_id'];
    shift = json['shift'];
    note = json['note'];
    labourCost = json['labour_cost'];
    transportCost = json['transport_cost'];
    otherCost = json['other_cost'];
    totalCost = json['total_cost'];
    status = json['status'];
    inchargeName = json['incharge_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['production_id'] = this.productionId;
    data['production_sl'] = this.productionSl;
    data['date'] = this.date;
    data['incharge_id'] = this.inchargeId;
    data['shift'] = this.shift;
    data['note'] = this.note;
    data['labour_cost'] = this.labourCost;
    data['transport_cost'] = this.transportCost;
    data['other_cost'] = this.otherCost;
    data['total_cost'] = this.totalCost;
    data['status'] = this.status;
    data['incharge_name'] = this.inchargeName;
    return data;
  }
}