import 'package:flutter/material.dart';
import 'package:flutter_app/models/user_model.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: [
            FlatButton(
              child: Text(
                "CRIAR CONTA",
                style: TextStyle(
                    fontSize: 15.0
                ),
              ),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>SignUpScreen())
                );
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) {
                        return "E-mail inválido";
                      }else return null;
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    obscureText: true,
                    controller: _passController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) {
                        return "Senha inválida";
                      }else return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: (){
                        if(_emailController.text.isEmpty)
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text("Insira seu e-mail para recuperação!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        else{
                          model.recoverPass(_emailController.text);
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              content: Text("Confira seu e-mail!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(_formKey.currentState.validate()){

                        }
                        model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Falha ao entrar!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

