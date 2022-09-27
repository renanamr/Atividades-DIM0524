import 'package:calculo_imc_2/tela_resultado.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calc. IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  void _calcularIMC(){
    if (!_formKey.currentState!.validate())
      return;

    try{
      String? message;
      String? imageUrl;
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        message = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        imageUrl = "assets/thin.png";
      }else if (imc >= 18.6 && imc < 24.9) {
        message = "Peso ideal (${imc.toStringAsPrecision(4)})";
        imageUrl = "assets/shape.png";
      }else{
        imageUrl = "assets/fat.png";

        if (imc >= 24.9 && imc < 29.9)
          message = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
        else if (imc >= 29.9 && imc < 34.9)
          message = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
        else if (imc >= 34.9 && imc < 39.9)
          message = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
        else if (imc >= 40)
          message = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (_)=> TelaResultado(resultado: message, imageUrl: imageUrl,))
      );

    }catch(error){
      debugPrint(error.toString());

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Erro!"),
            content: Text("Verifique os dados e tente novamente"),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text("Ok"),
              )
            ],
          );
        },
      );
    }
  }

  String? validateTextField(value) {
    if (value.isEmpty)
      return "Insira um valor!";
    else
      return null;
  }


  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        actions: [
          IconButton(
              onPressed: (){
                _pesoController.clear();
                _alturaController.clear();
                _formKey.currentState!.reset();
              },
              tooltip: "Limpar",
              icon: const Icon(Icons.refresh)
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Icon(
                Icons.person,
                size: 110,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _pesoController,
                      keyboardType: TextInputType.number,
                      validator: validateTextField,
                      decoration: const InputDecoration(
                          labelText: "Peso (kg)"
                      ),
                    ),

                    TextFormField(
                      controller: _alturaController,
                      keyboardType: TextInputType.number,
                      validator: validateTextField,
                      decoration: const InputDecoration(
                          labelText: "Altura (cm)"
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top:12.0),
                      child: ElevatedButton(
                        onPressed: _calcularIMC,
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}