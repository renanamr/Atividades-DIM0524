import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final realController = TextEditingController();

  late double dolar;
  late double euro;


  //<Métodos auxiliares>
  void _realChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChange(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }


  //<Requisição http>
  Future<Map> getData() async {
    http.Response response = await http.get("https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926");
    return json.decode(response.body);
  }


  @override
  void dispose() {
    dolarController.dispose();
    euroController.dispose();
    realController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text("\$ Conversor de Moedas \$"),
            centerTitle: true,
            backgroundColor: Colors.amber),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                          "Erro ao carregar dados...",
                          style: TextStyle(color: Colors.amber, fontSize: 25.0),
                          textAlign: TextAlign.center,
                        ));
                  } else {
                    dolar =
                    snapshot.data!["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.amber),
                          buildTextFormField(
                              "Reais", "R\$", realController, _realChange),
                          const Divider(),
                          buildTextFormField(
                              "Dólar", "US\$", dolarController, _dolarChange),
                          const Divider(),
                          buildTextFormField(
                              "Euro", "EUR", euroController, _euroChange),
                        ],
                      ),
                    );
                  }
              }
            }));
  }

  Widget buildTextFormField(String label, String prefix,
      TextEditingController controller, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.amber),
          border: const  OutlineInputBorder(),
          prefixText: "$prefix "),
      style: const  TextStyle(color: Colors.amber, fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }


}