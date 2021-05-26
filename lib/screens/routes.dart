import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/screens/add_band.dart';
import 'package:flutter_app/screens/bands.dart';
import 'package:flutter_app/screens/categories.dart';

class Routes {
  static const String home = '/';
  static const String bands = '/bands';
  static const String addBand = '/bands/add';
  static const String categories = '/categories';

  Routes._();

  static get routes => (RouteSettings settings) {
        switch (settings.name) {
          case Routes.home:
            return CupertinoPageRoute(
                builder: (_) => BandCatalogApp(), settings: settings);
          case Routes.bands:
            BandCategory category = settings.arguments as BandCategory;
            return CupertinoPageRoute(
                builder: (_) => Bands(category), settings: settings);
          case Routes.addBand:
            BandCategory category = settings.arguments as BandCategory;
            return CupertinoPageRoute(
                builder: (_) => AddBand(category), settings: settings);
          case Routes.categories:
            return CupertinoPageRoute(
                builder: (_) => Categories(), settings: settings);
          default:
            return null;
        }
      };
}
