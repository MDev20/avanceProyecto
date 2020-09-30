import 'package:appedejemplo/src/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:appedejemplo/src/services/auth_services.dart';

final primaryColor = const Color.fromRGBO(255, 255, 255, 1.0);
enum AuthFormType { signIn, signUp, reset }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Confirmar Nueva Contraseña");
          _warning =
              "Se ha enviado un Link al correo para restablecer la Contraseña a $_email";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _name);
          print("Signed up with New ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.025),
                showAlert(),
                SizedBox(height: _height * 0.025),
                buildTHeaderext(),
                SizedBox(height: _height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: buildInputs() + buildButtons(),
                    ),
                  ),
                ),
                SizedBox(height: 100.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
          color: Colors.deepOrange,
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.error_outline),
              Expanded(
                child: AutoSizeText(_warning, maxLines: 3),
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _warning = null;
                    });
                  })
            ],
          ));
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildTHeaderext() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Crear Cuenta de Usuario";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Cambiar Contraseña";
    } else {
      _headerText = "Iniciar Sesión";
    }

    return AutoSizeText(
      _headerText,
      maxLines: 2,
      style: TextStyle(fontSize: 35, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 17.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
      return textFields;
    }

    //if were in the sign up state add name
    if (authFormType == AuthFormType.signUp) {
      textFields.add(TextFormField(
        validator: NameValidator.validate,
        style: TextStyle(fontSize: 17.0),
        decoration: buildSignUpInputDecoration("Nombre"),
        onSaved: (value) => _name = value,
      ));
    }
    textFields.add(SizedBox(height: 40.0));
    //add email & password
    textFields.add(TextFormField(
      validator: EmailValidator.validate,
      style: TextStyle(fontSize: 17.0),
      decoration: buildSignUpInputDecoration("Email"),
      onSaved: (value) => _email = value,
    ));

    textFields.add(SizedBox(height: 40.0));
    textFields.add(TextFormField(
      validator: PasswordValidator.validate,
      obscureText: true,
      style: TextStyle(fontSize: 17.0),
      decoration: buildSignUpInputDecoration(
        "Contraseña",
      ),
      onSaved: (value) => _password = value,
    ));
    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.0)),
      contentPadding: EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Crear Nueva Cuenta";
      _newFormState = "signUp";
      _submitButtonText = "Iniciar Sesión";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Volver a Iniciar Sesión";
      _newFormState = "signIn";
      _submitButtonText = "Enviar";
    } else {
      _switchButtonText = "Si tienes una cuenta, puedes Iniciar Sesión";
      _newFormState = "signIn";
      _submitButtonText = "Registrar Usuario";
    }
    return [
      SizedBox(height: 30.0),
      Container(
          width: MediaQuery.of(context).size.height * 0.5,
          child: RaisedButton(
              onPressed: submit,
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              textColor: primaryColor,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(_submitButtonText),
              ))),
      SizedBox(height: 30.0),
      showForgotPassword(_showForgotPassword),
      FlatButton(
          onPressed: () {
            switchFormState(_newFormState);
          },
          child: Text(_switchButtonText)),
      FlatButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/home');
          },
          child: Text("Volver a Inicio")),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Olvidó su Contraseña",
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }

  icon() {}
}
