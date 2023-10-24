class StockRecordsModel{
  int? recordDocumentNumber;
  String? recordTime;
  String? itemID;
  int? itemQuantity;

  StockRecordsModel({
    this.recordDocumentNumber,
    this.recordTime,
    this.itemID,
    this.itemQuantity
});

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