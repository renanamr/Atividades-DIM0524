import 'package:flutter/material.dart';

class TelaResultado extends StatelessWidget {

  final String? imageUrl;
  final String? resultado;
  const TelaResultado({Key? key, this.imageUrl, this.resultado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageUrl!,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          Center(
            child: Text(
              resultado!,
              style: TextStyle(fontSize: 22.0),
            ),
          )
        ],
      ),
    );
  }
}
