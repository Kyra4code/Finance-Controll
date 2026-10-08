import 'package:flutter/material.dart';

import 'dart:ui';

main() {
  runApp(FirstStateless(title: "ola mundo"));
}

class FirstStateless extends StatelessWidget {
  final String title;

  const FirstStateless({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Ola mundo", textDirection: TextDirection.rtl)),
    );
  }
}
