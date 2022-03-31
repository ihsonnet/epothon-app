import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ePothon"),
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          leading:  IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.document_scanner))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 500,
                padding: const EdgeInsets.all(20.0),
                child: Text("Good Afternoon , Sonnet!",
                  style: TextStyle(color: Colors.blueGrey[900], fontSize: 20), textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
