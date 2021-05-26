import 'package:flutter/material.dart';
import 'package:flutter_app/screens/routes.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Bandas'),
      ),
      body: Column(
        children: [
          Image.network(
              'https://roadiecrew.com/wp-content/uploads/alice-in-chains-foto-696x405.jpg'),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.categories);
              },
              child: Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Entrar'.toUpperCase()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
