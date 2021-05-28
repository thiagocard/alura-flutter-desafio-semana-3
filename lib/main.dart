import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/bands_model.dart';
import 'package:flutter_app/models/band_category_model.dart';
import 'package:flutter_app/screens/categories.dart';
import 'package:flutter_app/screens/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BandsModel(),
      ),
      ChangeNotifierProvider(
        create: (context) => CategoriesModel(),
      ),
    ],
    child: BandCatalogApp(),
  ));
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
