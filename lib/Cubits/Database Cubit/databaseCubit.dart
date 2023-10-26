import 'package:bbs_project/Cubits/Database%20Cubit/databaseStates.dart';
import 'package:bbs_project/Models/Items%20Model/itemsModel.dart';
import 'package:bbs_project/Models/Stock%20Records%20Model/stockRecordsModel.dart';
import 'package:bbs_project/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCubit extends Cubit<DatabaseStates> {
  DatabaseCubit() : super(DatabaseInitialState());

  static DatabaseCubit get(context) => BlocProvider.of(context);

  Database? database;
  void createDatabase() async {
    var path = join(await getDatabasesPath(), 'stocktaking.db');
    openDatabase(
      path,
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
        );
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
        );
        ''').then((value) {
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
      databa = value;
      print('path --------- ${database?.path}');
      emit(CreateDatabaseState());
    }).catchError((error) {
      print('error -------- ${error.toString()}');
      emit(CreateDatabaseErrorState());
    });
  }

  void insertIntoDatabase({
    required ItemModel item,
    required StockRecordsModel stock,
}) async {
    print("pass ------------ ${database?.path}");
    final db = databa;

    await db!.transaction((txn) async{

      int? ins1 = await txn.rawInsert('''
      INSERT INTO Items(ItemID, ItemName, ItemBarcode, ItemPrice, ItemQuantity)
      VALUES ('${item.itemID}', '${item.itemName}', '${item.itemBarcode}', ${item.itemPrice}, ${item.itemQuantity})
      ''',
      ).then((value) {
        print('$value inserted Successfully to Items Table');
        emit(InsertIntoItemsTableSuccessState());
      }).catchError((error) {
        print('error ---------- ${error.toString()}');
        emit(InsertIntoItemsTableErrorState());
      });

      int? ins2 = await txn.rawInsert('''
      INSERT INTO StockRecords(RecordDocumentNumber, RecordTime, ItemID, ItemQuantity)
      VALUES (${stock.recordDocumentNumber}, '${stock.recordTime}', '${stock.itemID}', ${stock.itemQuantity})
      ''',
      ).then((value) {
        print('$value inserted Successfully to Stock Table');
        emit(InsertIntoStockTableSuccessState());
      }).catchError((error) {
        print('error ---------- ${error.toString()}');
        emit(InsertIntoStockTableErrorState());
      });

    });


  }

  List<Map<String, dynamic>>? records = [];
  void getDataFromStockTable(Database db) async {
    await db.rawQuery('SELECT * FROM StockRecords').then((value) {

      value.forEach((element) {
        records?.add(element);
      });
      print(records);
      emit(GetDataFromStockTableSuccessState());
    }).catchError((error) {
      print('error ------- ${error.toString()}');
      emit(GetDataFromStockTableErrorState());
    });
  }

  List<Map<String, dynamic>> items = [];
  void getDataFromItemsTable(Database db) async {
    await db.rawQuery('SELECT * FROM Items').then((value) {

      value.forEach((element) {
        items.add(element);
      });
      print(items);
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
      documentNo = ((records?[records!.length - 1]['RecordDocumentNumber']) + 1)
          .toString();
      print("documentNo  $documentNo");
      emit(ChangeDocumentNoState());
    }
  }

  // void delete() async{
  //   var path = join(await getDatabasesPath(), 'stocktaking.db');
  //   await deleteDatabase(path).then((value) {
  //     print('deleted successfully');
  //     emit(Delete());
  //   });
  // }
  
  Map<String, dynamic> searchMap = {};
  void searchWithBarcode(String barcode) async{
    final db = databa;
    
    await db?.rawQuery('''
    SELECT * FROM Items
    WHERE ItemBarcode='$barcode'
    ''').then((value) {
      searchMap.addAll(value[0]);
      print('itemModelSearch ---- $searchMap');
      emit(SearchInItemTableSuccessState());
    }).catchError((error){
      print('Search in Item Table error ---- ${error.toString()}');
      emit(SearchInItemTableErrorState());
    });
  }
}





