import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_app/models/bands_model.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/screens/routes.dart';
import 'package:provider/provider.dart';

class Bands extends StatelessWidget {
  final BandCategory _category;

  Bands(this._category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas de ${_category.name.toLowerCase()}'),
      ),
      body: Consumer<BandsModel>(
        builder: (context, model, child) {
          var bands = model.bandsByCategory(_category.id);
          if (bands.isEmpty) {
            return Center(
              child: Text(
                  'Você não adicionou nenhuma banda do gênero ${_category.name.toLowerCase()}'),
            );
          } else {
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                  bands.length, (index) => BandCard(bands[index])),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addBand, arguments: _category);
        },
      ),
    );
  }
}

class BandCard extends StatelessWidget {
  final Band _band;

  BandCard(this._band);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              _band.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(_band.name)),
          )
        ],
      ),
    );
  }
}
