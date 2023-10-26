import 'package:bbs_project/Cubits/Database%20Cubit/databaseCubit.dart';
import 'package:bbs_project/Cubits/Database%20Cubit/databaseStates.dart';
import 'package:bbs_project/Models/Items%20Model/itemsModel.dart';
import 'package:bbs_project/Models/Stock%20Records%20Model/stockRecordsModel.dart';
import 'package:bbs_project/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewDocumentScreen extends StatelessWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var documentController = TextEditingController();
    var barcodeController = TextEditingController();
    var quantityController = TextEditingController(text: '1');
    ItemModel itemModel;
    var formKey = GlobalKey<FormState>();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    DatabaseCubit.get(context).documentNumber();

    return BlocConsumer<DatabaseCubit, DatabaseStates>(
      listener: (context, state) {
        if (state is GetDataFromStockTableErrorState ||
            state is GetDataFromItemsTableErrorState) {
          bottomSheet(context, 'error: some thing wrong in your data');
        }
      },
      builder: (context, state) {
        var cubit = DatabaseCubit.get(context);
        documentController.text = cubit.documentNo.toString();
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Document No.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                cubit.documentNo,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Barcode',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: barcodeController,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Qty.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: quantityController,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: '1',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'this field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: MaterialButton(
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await cubit.searchWithBarcode(barcodeController.text);
                          if (cubit.searchMap.isEmpty) {
                            itemModel = ItemModel(
                              id: documentController.text,
                              name: 'Item ${documentController.text}',
                              barcode: barcodeController.text,
                              price: 300,
                              quantity: int.parse(quantityController.text),
                            );
                            cubit.addToItemsList(itemModel);
                            barcodeController.clear();
                            quantityController.text = '1';
                          } else {
                            bottomSheet(context, 'duplicate items are not allowed');
                            cubit.searchMap.clear();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 250.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "{'ItemName': ${cubit.items[index]['ItemName']}, 'ItemQuantity': ${cubit.items[index]['ItemQuantity']}}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 2.0,
                        ),
                        itemCount: cubit.items!.length,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: MaterialButton(
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          String date = DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.now());
                          Map<String, dynamic> saveMap = cubit.items.last;
                          ItemModel itemModel = ItemModel.formJson(saveMap);
                          StockRecordsModel stockModel = StockRecordsModel(
                            recordNo: int.parse(documentController.text),
                            recordTime: date,
                            itemId: saveMap['ItemID'],
                            itemQty: saveMap['ItemQuantity'],
                          );
                          await DatabaseCubit.get(context).insertIntoDatabase(
                            item: itemModel,
                            stock: stockModel,
                          );
                          cubit.items.clear();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> bottomSheet(context, String message) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
