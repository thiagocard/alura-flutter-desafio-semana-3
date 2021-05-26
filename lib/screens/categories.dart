import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/models/band_category_model.dart';
import 'package:flutter_app/screens/routes.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
      ),
      body: Consumer<CategoriesModel>(
        builder: (context, model, child) {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(model.categories.length,
                (index) => CategoryCard(model.categories[index])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addBand);
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final BandCategory _category;

  CategoryCard(this._category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, Routes.bands, arguments: _category),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                _category.image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  _category.name,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
