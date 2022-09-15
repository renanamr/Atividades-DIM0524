import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(title: "Contador de pessoas", home: Home())); //Material App
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  int _pessoa = 0;
  String _image = "assets/images/restaurante.jpeg";
  String _mensagem = "Pode entrar!";

  void _changePeople(int delta) {
    setState(() {
      _pessoa += delta;
      if (_pessoa >= 20) {
        _mensagem = "Lotado, não pode entrar.";
        _image = "assets/images/door_out.jpg";
        _pessoa = 20;
      } else {
        _mensagem = "Pode entrar!";
        _image = "assets/images/restaurante.jpeg";

        if (_pessoa < 0)
          _pessoa = 0;
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_image),
          fit: BoxFit.cover,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Liberação do restaurante"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_pessoa",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ), //text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: ()=>_changePeople(1),
                      child: Text(
                        "+1",
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      )
                  ),

                  SizedBox(height: 2, width: 10,),

                  ElevatedButton(
                    child: const Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: ()=>_changePeople(-1),
                  ),

                ],
              ),
            ),
            Text(
              _mensagem,
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white
              ),
            ) //text
          ], //widget
        ),
      ),
    );
  }
}