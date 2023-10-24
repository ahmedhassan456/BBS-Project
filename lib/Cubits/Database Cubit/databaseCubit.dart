import 'package:bbs_project/Cubits/Database%20Cubit/databaseStates.dart';
import 'package:bbs_project/Models/Items%20Model/itemsModel.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCubit extends Cubit<DatabaseStates> {
  DatabaseCubit() : super(DatabaseInitialState());

  static DatabaseCubit get(context) => BlocProvider.of(context);

  Database? database;

  void createDatabase() {
    openDatabase(
      'stocktaking.db',
      version: 1,
      onCreate: (db, version) async {
        print('Database Created');

        await db.execute('''
        CREATE TABLE Items (
            ItemID VARCHAR(255) PRIMARY KEY,
            ItemName VARCHAR(255),
            ItemBarcode VARCHAR(255) UNIQUE,
            ItemPrice REAL,
            ItemQuantity INT
        )
        ''').then((value) {
          print('Items Table Created');
          emit(CreateItemsTableSuccessState());
        }).catchError((error) {
          print('error ------ ${error.toString()}');
          emit(CreateItemsTableErrorState());
        });

        await db.execute('''
        CREATE TABLE StockRecords (
          RecordDocumentNumber INT,
          RecordTime DATETIME,
          ItemID VARCHAR(255),
          ItemQuantity INT,
          PRIMARY KEY (RecordDocumentNumber, RecordTime, ItemID),
          FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
        )''').then((value) {
          print('StockRecords Table Created');
          emit(CreateStockRecordsTableSuccessState());
        }).catchError((error) {
          print('error ------ ${error.toString()}');
          emit(CreateStockRecordsTableErrorState());
        });
      },
      onOpen: (db) {
        print('Database Opened');
        getDataFromStockTable(db);
        getDataFromItemsTable(db);
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    }).catchError((error) {
      print('error -------- ${error.toString()}');
      emit(CreateDatabaseErrorState());
    });
  }

  void insertIntoDatabase({
    required int docNumber,
    required String recordTime,
    required int quantity,
    required String itemID,
    required Map items,
  }) async {
    database?.transaction((txn) async{
      // Insert items into StockRecordsItems table
      await txn.rawInsert('''
      INSERT INTO StockRecords (RecordDocumentNumber, RecordTime, ItemID, ItemQuantity)
      VALUES (${int.parse(documentNo)}, $recordTime, $itemID, $quantity)
      ''').then((value) {
        print('inserted Successfully');
        emit(InsertIntoStockTableSuccessState());
      }).catchError((error) {
        print('error ------ ${error.toString()}');
        emit(InsertIntoStockTableErrorState());
      });


      await txn.rawInsert('''
        INSERT INTO Items (ItemID, ItemName, ItemBarcode, ItemPrice, ItemQuantity)
        VALUES ("${items['ItemID']}", "${items['ItemName']}", "${items['ItemBarcode']}", ${items['ItemPrice']}, ${items['ItemQuantity']})
        ''').then((value) {
        print('$value inserted Successfully');
        emit(InsertIntoItemsTableSuccessState());
      }).catchError((error) {
        print('error -------- ${error.toString()}');
        emit(InsertIntoStockTableErrorState());
      });

      // Insert stock record into StockRecords table
      // await txn
      //     .insert(
      //   'StockRecords',
      //   {
      //     'RecordDocumentNumber': docNumber,
      //     'RecordTime': recordTime,
      //     'ItemQuantity': quantity,
      //     'ItemID': itemID
      //   },
      //   conflictAlgorithm: ConflictAlgorithm.replace,
      // ).then((value) {
      //   print('inserted Successfully');
      //   emit(InsertIntoStockTableSuccessState());
      // }).catchError((error) {
      //   print('error ------ ${error.toString()}');
      //   emit(InsertIntoStockTableErrorState());
      // });

    });
  }


  List<Map>? records = [];
  void getDataFromStockTable(Database db) async {
    await db.rawQuery('SELECT * FROM StockRecords').then((value) {
      print(records);
      records = value;
      emit(GetDataFromStockTableSuccessState());
    }).catchError((error) {
      print('error ------- ${error.toString()}');
      emit(GetDataFromStockTableErrorState());
    });
  }

  List<Map>? items = [];
  void getDataFromItemsTable(Database db) async{
    await db.rawQuery('SELECT * FROM Items').then((value) {
      print(items);
      items = value;
      emit(GetDataFromItemsTableSuccessState());
    }).catchError((error) {
      print('error ------- ${error.toString()}');
      emit(GetDataFromItemsTableErrorState());
    });
  }

  String documentNo = '';
  void documentNumber() {
    if (records!.isEmpty) {
      documentNo = '1';
      print("documentNo  $documentNo");
      emit(ChangeDocumentNoState());
    } else {
      documentNo = ((records?[records!.length - 1]['RecordDocumentNumber']) + 1).toString();
      print("documentNo  $documentNo");
      emit(ChangeDocumentNoState());
    }
  }

}

