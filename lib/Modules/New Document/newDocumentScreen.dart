import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDocumentScreen extends StatelessWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var documentController = TextEditingController();
    var barcodeController = TextEditingController();
    var quantityController = TextEditingController(text: '1');
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
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
                      child: TextFormField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'this field must not be empty';
                          }
                          return null;
                        },
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
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          controller: barcodeController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'this field must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0,),
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
                        const SizedBox(height: 10.0,),
                        TextFormField(
                          controller: quantityController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '1',
                          ),
                          validator: (value){
                            if(value!.isEmpty){
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
                  border: Border.all(width: 3.0,),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: MaterialButton(
                  child: const Text('Add',style: TextStyle(fontSize: 20.0,color: Colors.white,),),
                  onPressed: (){},
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 3.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
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
                  border: Border.all(width: 3.0,),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: MaterialButton(
                  child: const Text('Save',style: TextStyle(fontSize: 20.0,color: Colors.white,),),
                  onPressed: (){},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
