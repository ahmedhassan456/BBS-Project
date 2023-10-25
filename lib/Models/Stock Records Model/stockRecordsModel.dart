class StockRecordsModel{
  int? recordDocumentNumber;
  String? recordTime;
  String? itemID;
  int? itemQuantity;

  StockRecordsModel({
    required int recordNo,
    required String recordTime,
    required String itemId,
    required int itemQty,
}){
    recordDocumentNumber = recordNo;
    this.recordTime = recordTime;
    this.itemID = itemId;
    itemQuantity = itemQty;
  }

  StockRecordsModel.formJson(Map<String, dynamic> json){
    recordDocumentNumber = json['RecordDocumentNumber'];
    recordTime = json['RecordTime'];
    itemID = json['ItemID'];
    itemQuantity = json['ItemQuantity'];
  }

  Map<String, dynamic> toMap(){
    return {
      'RecordDocumentNumber': recordDocumentNumber,
      'RecordTime': recordTime,
      'ItemID': itemID,
      'ItemQuantity': itemQuantity,
    };
  }
}