import 'package:appedejemplo/src/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color.fromRGBO(255, 255, 255, 1.0);
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        color: primaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height * 0.10),
                  Text(
                    'Horus Lift',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _height * 0.10),
                  AutoSizeText(
                    'Realiza análisis e informes de los estados de tus máquinas',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: _height * 0.09),
                  RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "¿Deseas crear una Cuenta?",
                          description:
                              "Através de una cuenta podrás acceder a ella por medio de cualquier dispositivo ",
                          primaryButtonText: "Crear nuevo Usuario",
                          primaryButtonRoute: "/signUp",
                          secondaryButtonText: "Quizá más Tarde",
                          secondaryButtonRoute: "algo",
                        ),
                      );
                    },
                    color: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, right: 25.0, left: 25.0),
                      child: Text(
                        'Empecemos',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: _height * 0.05),
                  FlatButton(
                    height: _height * 0.09,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signIn');
                    },
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 60.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
