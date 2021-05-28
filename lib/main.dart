import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/categories.dart';
import 'package:flutter_app/screens/routes.dart';

void main() {
  runApp(BandCatalogApp());
}

class BandCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.routes,
      home: Categories(),
    );
  }
}
