import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Formulário de cadastro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _ruaController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _ufController = TextEditingController();
  TextEditingController _paisController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'Nome completo',
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Este campo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'E-mail',
                              ),
                              validator: (value) {
                                if (!EmailValidator.validate(value)) {
                                  return 'Digite um e-mail válido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'CPF',
                              ),
                              validator: (cpf) {
                                if (!CPF.isValid(cpf)) {
                                  return 'Digite um CPF válido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cepController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'CEP',
                              ),
                              validator: (cep) {
                                if (cep.isEmpty) {
                                  return 'Este campo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () async {
                                var response = await http.get(
                                    'https://viacep.com.br/ws/${_cepController.text}/json/');
                                print(response.statusCode);
                                if (response.statusCode == 200) {
                                  var jsonResponse = jsonDecode(response.body);
                                  setState(() {
                                    _ruaController.text =
                                        jsonResponse['logradouro'];
                                    _bairroController.text =
                                        jsonResponse['bairro'];
                                    _cidadeController.text =
                                        jsonResponse['localidade'];
                                    _ufController.text = jsonResponse['uf'];
                                    _paisController.text = 'Brasil';
                                  });
                                  print(jsonResponse);
                                } else {
                                  print('Erroooou');
                                }
                              },
                              color: Colors.white,
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('Buscar CEP'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _ruaController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'Rua',
                              ),
                              validator: (rua) {
                                return rua.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _numeroController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'Número',
                              ),
                              validator: (numero) {
                                return numero.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _bairroController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'Bairro',
                              ),
                              validator: (bairro) {
                                return bairro.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _cidadeController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'Cidade',
                              ),
                              validator: (cidade) {
                                return cidade.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _ufController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'UF',
                              ),
                              validator: (uf) {
                                return uf.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _paisController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.orange,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                hintText: 'País',
                              ),
                              validator: (pais) {
                                return pais.isEmpty
                                    ? 'Este campo é obrigatório'
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Processing Data'),
                    ),
                  );
                }
              },
              child: Text(
                'Cadastrar',
                style: TextStyle(color: Colors.red),
              ),
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
