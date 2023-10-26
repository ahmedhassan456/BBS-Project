abstract class DatabaseStates {}

class DatabaseInitialState extends DatabaseStates {}

class CreateDatabaseState extends DatabaseStates {}
class CreateDatabaseErrorState extends DatabaseStates {}

class CreateItemsTableSuccessState extends DatabaseStates {}
class CreateItemsTableErrorState extends DatabaseStates {}

class CreateStockRecordsTableSuccessState extends DatabaseStates {}
class CreateStockRecordsTableErrorState extends DatabaseStates {}

class InsertIntoItemsTableSuccessState extends DatabaseStates {}
class InsertIntoItemsTableErrorState extends DatabaseStates {
  final String error;

  InsertIntoItemsTableErrorState(this.error);
}

class InsertIntoStockTableSuccessState extends DatabaseStates {}
class InsertIntoStockTableErrorState extends DatabaseStates {
  final String error;

  InsertIntoStockTableErrorState(this.error);
}

class GetDataFromStockTableSuccessState extends DatabaseStates {}
class GetDataFromStockTableErrorState extends DatabaseStates {}

class GetDataFromItemsTableSuccessState extends DatabaseStates {}
class GetDataFromItemsTableErrorState extends DatabaseStates {}

class ChangeDocumentNoState extends DatabaseStates {}

class SearchInItemTableSuccessState extends DatabaseStates {}
class SearchInItemTableErrorState extends DatabaseStates {}

class AddToItemListState extends DatabaseStates {}
