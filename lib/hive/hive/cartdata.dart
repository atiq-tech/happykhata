class cartdata{
  String ? product_id,color_id,size_id,purchase_rate,main_price,quantity,total_main_price,cashback_percent,cashback,total_cashback;
  cartdata({
   required this.quantity,
   required this.cashback,
   required this.cashback_percent,
   required this.color_id,
   required this.main_price,
   required this.product_id,
   required this.purchase_rate,
   required this.size_id,
   required this.total_cashback,
   required this.total_main_price,
  });

  Map toJson() => {
   'product_id': product_id,
   'color_id': color_id,
   'size_id': size_id,
   'purchase_rate': purchase_rate,
   'main_price': main_price,
   'quantity': quantity,
   'total_main_price': total_main_price,
   'cashback': cashback,
   'total_cashback': total_cashback,
   'cashback_percent': cashback_percent,
  };
}