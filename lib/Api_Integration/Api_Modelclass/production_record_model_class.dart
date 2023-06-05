class ProductionRecordModelClass {
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
  List<Products>? products;

  ProductionRecordModelClass(
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
      this.inchargeName,
      this.products});

  ProductionRecordModelClass.fromJson(Map<String, dynamic> json) {
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
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productionProductsId;
  String? productionId;
  String? productId;
  String? quantity;
  String? price;
  String? status;
  String? productCode;
  String? name;
  String? categoryId;
  String? categoryName;
  String? unitName;

  Products(
      {this.productionProductsId,
      this.productionId,
      this.productId,
      this.quantity,
      this.price,
      this.status,
      this.productCode,
      this.name,
      this.categoryId,
      this.categoryName,
      this.unitName});

  Products.fromJson(Map<String, dynamic> json) {
    productionProductsId = json['production_products_id'];
    productionId = json['production_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    status = json['status'];
    productCode = json['product_code'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['production_products_id'] = this.productionProductsId;
    data['production_id'] = this.productionId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['status'] = this.status;
    data['product_code'] = this.productCode;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['unit_name'] = this.unitName;
    return data;
  }
}