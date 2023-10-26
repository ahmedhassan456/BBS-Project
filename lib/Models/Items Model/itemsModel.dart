class ItemModel{
  String? itemID;
  String? itemName;
  String? itemBarcode;
  int? itemPrice;
  int? itemQuantity;

  ItemModel({
    required String id,
    required String name,
    required String barcode,
    required int price,
    required int quantity
}){
    itemID = id;
    itemName = name;
    itemBarcode = barcode;
    itemPrice = price;
    itemQuantity = quantity;
}

  ItemModel.formJson(Map<String, dynamic> json){
    itemID = json['ItemID'];
    itemName = json['ItemName'];
    itemBarcode = json['ItemBarcode'];
    itemPrice = json['ItemPrice'];
    itemQuantity = json['ItemQuantity'];
  }

  Map<String, dynamic> toMap()  {
    return{
      'ItemID': itemID,
      'ItemName': itemName,
      'ItemBarcode': itemBarcode,
      'ItemPrice': itemPrice,
      'ItemQuantity': itemQuantity,
    };
  }
}