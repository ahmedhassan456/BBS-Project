import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Check Inventory/checkInventoryScreen.dart';
import '../New Document/newDocumentScreen.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black,style: BorderStyle.solid, width: 5.0),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Stocktaking',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Document',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewDocumentScreen(),));
              },
            ),
            const SizedBox(height: 30.0,),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.black,style: BorderStyle.solid, width: 5.0),
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Check',
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Inventory',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckInventoryScreen(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}
