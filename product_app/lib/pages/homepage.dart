import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:products_app/widgets/products_gridview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Product App'),
        centerTitle: true,
      ),
      body: const GridWithCards()
    );
  }
}