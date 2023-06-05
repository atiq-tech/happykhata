class SupplierPaymentReportModel {
  String? previousBalance;
  List<Payments>? payments;

  SupplierPaymentReportModel({this.previousBalance, this.payments});

  SupplierPaymentReportModel.fromJson(Map<String, dynamic> json) {
    previousBalance = json['previousBalance'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['previousBalance'] = this.previousBalance;
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payments {
  String? sequence;
  String? id;
  String? date;
  String? description;
  String? bill;
  String? paid;
  String? due;
  String? returned;
  String? cashReceived;
  int? balance;

  Payments(
      {this.sequence,
      this.id,
      this.date,
      this.description,
      this.bill,
      this.paid,
      this.due,
      this.returned,
      this.cashReceived,
      this.balance});

  Payments.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    id = json['id'];
    date = json['date'];
    description = json['description'];
    bill = json['bill'];
    paid = json['paid'];
    due = json['due'];
    returned = json['returned'];
    cashReceived = json['cash_received'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequence'] = this.sequence;
    data['id'] = this.id;
    data['date'] = this.date;
    data['description'] = this.description;
    data['bill'] = this.bill;
    data['paid'] = this.paid;
    data['due'] = this.due;
    data['returned'] = this.returned;
    data['cash_received'] = this.cashReceived;
    data['balance'] = this.balance;
    return data;
  }
}
