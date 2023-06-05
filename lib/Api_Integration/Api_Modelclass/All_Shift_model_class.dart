class AllShiftModelClass {
  String? shiftId;
  String? name;

  AllShiftModelClass({this.shiftId, this.name});

  AllShiftModelClass.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_id'] = this.shiftId;
    data['name'] = this.name;
    return data;
  }
}