import 'package:bbs_project/Cubits/Database%20Cubit/databaseStates.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCubit extends Cubit<DatabaseStates> {
  DatabaseCubit() : super(DatabaseInitialState());

  DatabaseCubit get(context) => BlocProvider.of(context);

  Database? database;

  void createDatabase() {
    openDatabase(
      'stocktaking.db',
      version: 1,
      onCreate: (db, version) async
      {
        print('Database Created');

        await db.execute('''
        CREATE TABLE Items (
            id TEXT PRIMARY KEY,
            name TEXT,
            barcode TEXT UNIQUE,
            price REAL,
            quantity INTEGER
        )''').then((value) {
          print('Items Table Created');
          emit(CreateItemsTableSuccessState());
        }).catchError((error){
          print('error ------ ${error.toString()}');
          emit(CreateItemsTableErrorState());
        });

        await db.execute('''
        CREATE TABLE StockRecords (
          docNumber INTEGER,
          recordTime DATETIME,
          itemId TEXT,
          quantity INTEGER,
          PRIMARY KEY (docNumber, recordTime, itemId),
          FOREIGN KEY (itemId) REFERENCES Items(id)
        )''').then((value) {
          print('StockRecords Table Created');
          emit(CreateStockRecordsTableSuccessState());
        }).catchError((error){
          print('error ------ ${error.toString()}');
          emit(CreateStockRecordsTableErrorState());
        });

      },
      onOpen: (db)
      {
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    }).catchError((error){
      print('error -------- ${error.toString()}');
      emit(CreateDatabaseErrorState());
    });
  }
}
