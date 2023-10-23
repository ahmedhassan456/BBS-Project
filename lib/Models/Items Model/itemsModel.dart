class ItemModel{
  String? id;
  String? name;
  String? barcode;
  double? price;
  int? quantity;

  ItemModel.formJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    barcode = json['barcode'];
    price = json['price'];
    quantity = json['quantity'];
  }
}