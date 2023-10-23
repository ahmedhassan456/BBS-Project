class StockRecordsModel{
  int? docNumber;
  String? recordTime;
  String? itemId;
  int? quantity;

  StockRecordsModel.formJson(Map<String, dynamic> json){
    docNumber = json['docNumber'];
    recordTime = json['recordTime'];
    itemId = json['itemId'];
    quantity = json['quantity'];
  }
}