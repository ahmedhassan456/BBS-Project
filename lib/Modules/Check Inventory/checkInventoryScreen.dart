import 'package:bbs_project/Cubits/Database%20Cubit/databaseCubit.dart';
import 'package:bbs_project/Cubits/Database%20Cubit/databaseStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInventoryScreen extends StatelessWidget {
  const CheckInventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var barcodeController = TextEditingController();
    var nameController = TextEditingController();
    var priceController = TextEditingController();
    var quantityController = TextEditingController();

    return BlocProvider(
      create: (context) => DatabaseCubit(),
      child: BlocConsumer<DatabaseCubit, DatabaseStates>(
        listener: (context, state){
          if(state is SearchInItemTableSuccessState){
            if(DatabaseCubit.get(context).searchMap.isNotEmpty){
              nameController.text = DatabaseCubit.get(context).searchMap['ItemBarcode'];
              priceController.text = '${DatabaseCubit.get(context).searchMap['ItemPrice']}';
              quantityController.text = '${DatabaseCubit.get(context).searchMap['ItemQuantity']}';
            }
          }
        },
        builder: (context, state){
          var cubit = DatabaseCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Barcode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    TextFormField(
                      controller: barcodeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onFieldSubmitted: (value){
                        DatabaseCubit.get(context).searchWithBarcode(barcodeController.text);
                      },
                    ),
                    const SizedBox(height: 80.0,),
                    Row(
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            controller: priceController,
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Row(
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                          ),
                        ),
                        const SizedBox(width: 10.0,),
                        Expanded(
                          child: TextFormField(
                            controller: quantityController,
                            enabled: false,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
