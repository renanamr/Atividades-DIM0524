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
        children: [
          Center(child: Text(resultado!)),
          Expanded(
              child: Image.asset(imageUrl!)
          )
        ],
      ),
    );
  }
}
