import 'package:flutter/material.dart';
import '../style/colors/colors.json';

import 'dart:ui';

class MainPage extends StatelessWidget {
 

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: null, 
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
        ),

      ),

      body: Container(

        child: const Center(
          child: Text("Seu gasto foi xxxx")
        )

      ),

      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: Color.fromRGBO(76, 175, 80,1),
        tooltip: 'add',
        child: Icon(Icons.add),
        
      ),

    );
  }
}
