import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/models/band_category_model.dart';
import 'package:flutter_app/models/bands_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddBand extends StatefulWidget {
  final BandCategory _bandCategory;

  AddBand(this._bandCategory);

  @override
  State<StatefulWidget> createState() => AddBandState(_bandCategory);
}

class AddBandState extends State<AddBand> {
  final BandCategory _bandCategory;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  BandCategory _selectedCategory;

  AddBandState(this._bandCategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Banda'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A banda deve conter pelo menos o nome!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Imagem (url)',
                  hintText: 'Ex: https://www.imagem.com.br/banda.jpg',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Gênero',
                  border: OutlineInputBorder(),
                ),
                onChanged: (BandCategory value) {
                  _selectedCategory = value;
                },
                value: _bandCategory,
                items: Provider.of<CategoriesModel>(context, listen: false)
                    .categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Adicionar'.toUpperCase()),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Band band = Band(
                          Uuid().v4(),
                          _selectedCategory != null // Categoria selecionada ou inicial
                              ? _selectedCategory.id
                              : _bandCategory.id,
                          _nameController.text,
                          _imageController.text);
                      Provider.of<BandsModel>(context, listen: false).add(band);
                      Future.delayed(Duration(milliseconds: 150),
                          () => Navigator.pop(context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
