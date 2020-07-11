import 'package:aula_19_flutter_exercicio/user_data.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cnpj_cpf_helper/cnpj_cpf_helper.dart';
import 'package:cnpj_cpf_formatter/cnpj_cpf_formatter.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberHouseController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  String _country = 'Brasil';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final UserData user = UserData();

  _restart() {
    _formKey.currentState.reset();
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _cpfController.clear();
      _cepController.clear();
      _streetController.clear();
      _numberHouseController.clear();
      _neighborhoodController.clear();
      _cityController.clear();
      _stateController.clear();
    });
  }

  void _buscaCep(String cep) async {
    var dio = Dio();
    try {
      var response = await dio.get('https://viacep.com.br/ws/${cep}/json');
      var address = response.data;
      _streetController.text = address['logradouro'];
      _neighborhoodController.text = address['bairro'];
      _cityController.text = address['localidade'];
      _stateController.text = address['uf'];
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text("Cep não encontrado"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Cadastro de usuario'),
          centerTitle: true,
          backgroundColor: Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.blue)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nome Vazio';
                          }
                          if (value.length <= 3) {
                            return 'Nome muito curto';
                          }
                          if (value.length >= 30) {
                            return 'Nome muito longo';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          user.name = newValue;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'email',
                            hintStyle: TextStyle(color: Colors.blue)),
                        validator: (value) {
                          final bool isValid = EmailValidator.validate(value);
                          if (!isValid) {
                            return 'inválido';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          user.email = newValue;
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _cpfController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'CPF',
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                        inputFormatters: [
                          CnpjCpfFormatter(
                            eDocumentType: EDocumentType.CPF,
                          )
                        ],
                        validator: (value) {
                          if (!CnpjCpfBase.isCpfValid(value)) {
                            return 'Não é valido';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          user.cpf = newValue;
                        },
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              controller: _cepController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Cep',
                                  hintStyle: TextStyle(color: Colors.blue)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'CEP Vazio';
                                }
                                if (value.length < 8) {
                                  return 'Falta numeros, o correto é 8 números';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.cep = newValue;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 25,
                            child: RaisedButton.icon(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                _buscaCep(_cepController.text);
                              },
                              label: Text('buscar'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 75,
                            child: TextFormField(
                              controller: _streetController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Rua',
                                  hintStyle: TextStyle(color: Colors.blue)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Rua está Vazio';
                                }
                                if (value.length < 3) {
                                  return 'Endereço muito curto';
                                }
                                if (value.length >= 30) {
                                  return 'Endereço digitado muito longo';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.street = newValue;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 25,
                            child: TextFormField(
                              controller: _numberHouseController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Numero',
                                  hintStyle: TextStyle(color: Colors.blue)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Numero esta Vazio';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.numberHouse = newValue;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              controller: _neighborhoodController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Bairro',
                                  hintStyle: TextStyle(color: Colors.blue)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Bairro esta Vazio';
                                }
                                if (value.length >= 30) {
                                  return 'Nome do bairro muito grande';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.neighborhood = newValue;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 50,
                            child: TextFormField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Cidade',
                                  hintStyle: TextStyle(color: Colors.blue)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Cidade está Vazio';
                                }
                                if (value.length >= 30) {
                                  return 'Nome da cidade muito grande';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.city = newValue;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 25,
                            child: TextFormField(
                              controller: _stateController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Estado',
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Estado está Vazio';
                                }
                                if (value.length >= 3) {
                                  return 'UF do estado deve ser 2 siglas';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                user.state = newValue;
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 75,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'País',
                                  hintStyle: TextStyle(color: Colors.blue),
                                  labelText: _country),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 40,
                  child: OutlineButton(
                    onPressed: () {
                      _restart();
                    },
                    child: Text('Limpar'),
                    borderSide: BorderSide(color: Colors.black),
                    focusColor: Colors.red,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 60,
                  child: OutlineButton(
                    child: Text('Cadastrar'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _formKey.currentState.save();
                        });
                        _onSucess();
                        _dialogInfo();
                      }
                    },
                    borderSide: BorderSide(color: Colors.black),
                    focusColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _dialogInfo() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Dados: ${user.name}',
            ),
            content: Text('Nome:${user.name}\n'
                'Email: ${user.email}\n'
                'Cpf: ${user.cpf}\n'
                'Endereço:\n'
                'Rua: ${user.street},Numero: ${user.numberHouse},\n'
                'Bairro: ${user.neighborhood},Cidade: ${user.city}\n'
                'País: $_country\n'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'ok',
                  ))
            ],
          );
        });
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuario Criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    ));
  }
}
