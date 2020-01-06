import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _infoText = "Informe os seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe os seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void calculate(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura*altura);

      if (imc < 18.6){
        _infoText = "Abaixo do peso ${imc.toStringAsPrecision(4)}";
      }else if( imc >= 18.6 && imc < 24.9 ){
        _infoText = "Peso Ideal ${imc.toStringAsPrecision(4)}";
      }else if( imc >= 24.9 && imc < 29.9 ){
        _infoText = "Levemente acima do peso ${imc.toStringAsPrecision(4)}";
      }else if( imc >= 29.9 && imc < 34.9 ){
        _infoText = "Obsevidade Grau I ${imc.toStringAsPrecision(4)}";
      }else if( imc >= 34.9 && imc < 39.9 ){
        _infoText = "Obsevidade Grau II ${imc.toStringAsPrecision(4)}";
      }else
        _infoText = "Obsevidade Grau III ${imc.toStringAsPrecision(4)}";
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Caluladora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0.00, 10, 0.00),
          child: Form(
            key : _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                    controller: pesoController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty){
                        return "Insira a sua Peso";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0)),
                TextFormField(
                    controller: alturaController,
                    validator: (value) {
                      if (value.isEmpty){
                        return "Insira a sua Altura";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.00),
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text("$_infoText",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25))
              ],
            )
          )
        ));
  }
}
