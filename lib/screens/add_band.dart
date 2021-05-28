import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/models/band_category_model.dart';
import 'package:flutter_app/models/bands_model.dart';
import 'package:flutter_app/screens/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddBand extends StatelessWidget {
  final BandCategory _category;

  AddBand(this._category);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoriesCubit()),
        BlocProvider(create: (_) => BandsCubit(_category.id)),
      ],
      child: AddBandView(_category),
    );
  }
}

// ignore: must_be_immutable
class AddBandView extends StatelessWidget {
  final BandCategory _category;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  AddBandView(this._category);

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
              child: BlocBuilder<CategoriesCubit, List<BandCategory>>(
                  builder: (ctx, state) {
                return DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Gênero',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (BandCategory value) {
                    BlocProvider.of<CategoriesCubit>(context).selectedCategory =
                        value;
                  },
                  items: state
                      .map((category) => DropdownMenuItem(
                            key: Key("${category.id}"),
                            value: category,
                            child: Text(category.name),
                          ))
                      .toList(),
                  value: _category,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Adicionar'.toUpperCase()),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      var selected = BlocProvider.of<CategoriesCubit>(context)
                          .selectedCategory;
                      Band band = Band(Uuid().v4(), selected != null ? selected.id : _category.id,
                          _nameController.text, _imageController.text);
                      BlocProvider.of<BandsCubit>(context).add(band);
                      Future.delayed(
                          Duration(milliseconds: 100),
                          () => Navigator.pushReplacementNamed(
                              context, Routes.bands,
                              arguments: _category));
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
