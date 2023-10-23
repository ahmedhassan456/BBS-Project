abstract class DatabaseStates{}
class DatabaseInitialState extends DatabaseStates{}

class CreateDatabaseState extends DatabaseStates{}
class CreateDatabaseErrorState extends DatabaseStates{}

class CreateItemsTableSuccessState extends DatabaseStates{}
class CreateItemsTableErrorState extends DatabaseStates{}

class CreateStockRecordsTableSuccessState extends DatabaseStates{}
class CreateStockRecordsTableErrorState extends DatabaseStates{}