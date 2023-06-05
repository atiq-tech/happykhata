class AllProductLedgerClass {
  List<Ledger>? ledger;
  int? previousStock;

  AllProductLedgerClass({this.ledger, this.previousStock});

  AllProductLedgerClass.fromJson(Map<String, dynamic> json) {
    if (json['ledger'] != null) {
      ledger = <Ledger>[];
      json['ledger'].forEach((v) {
        ledger!.add(new Ledger.fromJson(v));
      });
    }
    previousStock = json['previousStock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ledger != null) {
      data['ledger'] = this.ledger!.map((v) => v.toJson()).toList();
    }
    data['previousStock'] = this.previousStock;
    return data;
  }
}

class Ledger {
  String? sequence;
  String? id;
  String? date;
  String? description;
  String? rate;
  String? inQuantity;
  String? outQuantity;
  int? stock;

  Ledger(
      {this.sequence,
      this.id,
      this.date,
      this.description,
      this.rate,
      this.inQuantity,
      this.outQuantity,
      this.stock});

  Ledger.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    id = json['id'];
    date = json['date'];
    description = json['description'];
    rate = json['rate'];
    inQuantity = json['in_quantity'];
    outQuantity = json['out_quantity'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sequence'] = this.sequence;
    data['id'] = this.id;
    data['date'] = this.date;
    data['description'] = this.description;
    data['rate'] = this.rate;
    data['in_quantity'] = this.inQuantity;
    data['out_quantity'] = this.outQuantity;
    data['stock'] = this.stock;
    return data;
  }
}