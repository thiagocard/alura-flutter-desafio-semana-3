import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_app/models/bands_model.dart';
import 'package:flutter_app/screens/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bands extends StatelessWidget {
  final BandCategory _category;

  Bands(this._category);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BandsCubit(_category.id),
      child: BandsView(_category),
    );
  }
}

class BandsViewState extends State<BandsView> {
  final BandCategory _category;

  BandsViewState(this._category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas de ${_category.name.toLowerCase()}'),
      ),
      body: BlocBuilder<BandsCubit, BandsState>(builder: (context, state) {
        if (state.bands.isEmpty) {
          return Center(
            child: Text(
                'Você não adicionou nenhuma banda do gênero ${_category.name.toLowerCase()}'),
          );
        } else {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(
                state.bands.length, (index) => BandCard(state.bands[index])),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushReplacementNamed(context, Routes.addBand,
            arguments: _category),
      ),
    );
  }
}

class BandsView extends StatefulWidget {
  final BandCategory _category;

  BandsView(this._category);

  @override
  State<StatefulWidget> createState() => BandsViewState(_category);
}

class BandCardState extends State<BandCard> {
  final Band _band;

  BandCardState(this._band);

  @override
  Widget build(BuildContext context) {
    return _band == null ? null : Card(
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
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(_band.name),
                    )),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<BandsCubit>(context).remove(_band.uuid);

                      // navigateToOptions(context, _band);
                    },
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.black38,
                      size: 21,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  void navigateToOptions(BuildContext context, Band band) async {
    var result = await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(),
        builder: (ctx) {
          return BlocProvider(
            create: (ctx) => BandsCubit(_band.categoryId),
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  final options = [
                    {
                      'title': 'Deletar',
                      'icon': Icons.delete_forever,
                      'action': () => BlocProvider.of<BandsCubit>(context)
                          .remove(_band.uuid),
                    },
                    {
                      'title': 'Mover',
                      'icon': Icons.forward,
                      'action': () {},
                    },
                  ];
                  return CardOption(options: options, index: index);
                }),
          );
        });

    // if (result as int == 1) {
    //   setState(() {
    //     band = null;
    //   });
    // }
  }
}

class BandCard extends StatefulWidget {
  final Band _band;

  BandCard(this._band);

  @override
  State createState() => BandCardState(_band);
}

class CardOption extends StatelessWidget {
  const CardOption({
    Key key,
    @required this.options,
    @required this.index,
  }) : super(key: key);

  final List<Map<String, Object>> options;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Function action = options[index]['action'];
        action();
        Navigator.pop(context, 1);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: Text(options[index]['title']),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                options[index]['icon'],
                color: Colors.black38,
                size: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
