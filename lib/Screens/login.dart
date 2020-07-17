import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localstorage/localstorage.dart';

import 'package:medicpucp/Screens/loader_drawer_menu.dart';
import 'package:medicpucp/Utilities/example_page.dart';

import 'package:http/http.dart' as http;
import 'package:medicpucp/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FancyBackgroundApp extends StatelessWidget {
  final myControllerUser = TextEditingController();
  final myControllerPassword = TextEditingController();
  final myControllerRegister = TextEditingController();

  final LocalStorage storage = new LocalStorage('myStorageKey');

  void redireccionar(context, http.Response response) async {
    String token = response.body;

    storage.setItem('token', token);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoaderDrawerMenu()));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final userField = TextField(
      key: Key('userField'),
      controller: myControllerUser,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Usuario",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final passwordField = TextField(
      key: Key('passwordField'),
      controller: myControllerPassword,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Contraseña",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final registerLink = MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {        
        _launchUrlRegister();
      },
      child: Text(
        "Registrarme",
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).iconTheme.color,
          fontSize: 16.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).iconTheme.color,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (myControllerUser.text.length.toInt() > 4 &&
              myControllerPassword.text.length.toInt() > 4) {
            // EN CASO PASA EL PRIMER FILTRO
            String str;
            String str2;
            str = myControllerUser.text.length.toString();
            str2 = myControllerPassword.text.length.toString();

            // debugPrint(myControllerUser.text);
            // debugPrint(str);
            // debugPrint(myControllerPassword.text);
            // debugPrint(str2);

            final usernameText = myControllerUser.text;
            final passwordText = myControllerPassword.text;

            // var client = await oauth2.resourceOwnerPasswordGrant(
            //   authorizationEndpoint, username, password,
            //   identifier: identifier, secret: secret);
            String url = endpointLogIn;
            Map map = {
              "username": "$usernameText",
              "password": "$passwordText"
            };
            debugPrint(map.toString());
            cuadroFlotante('Iniciando sesión.....',context);
            var response = await apiRequest(url, map);
            
            if (response.body.toString().contains("token")) {
              redireccionar(context, response);
            } else if (response.body.toString().contains("error")) {
              return cuadroFlotante(
                  'Error obteniendo token, error interno del servidor',
                  context);
            } else {
              return cuadroFlotante(
                  'Algo ha fallado en el servidor o la aplicación de manera interna. Contactar a soporte',
                  context);
            }
          } else {
            return cuadroFlotante("Usuario o contraseña incorrectos.", context);
          }
        },
        child: Text(
          "Iniciar Sesión",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // color: Colors.black87,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/Images/blood-pressure.jpg"),
                  colorFilter: ColorFilter.mode(
                    Colors.white70,
                    BlendMode.dstOut,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 2,
              // width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 155.0,
                        child: Image.asset(
                          "Assets/Images/mp_launcher.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 45.0),
                      userField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,
                      SizedBox(
                        height: 15.0,
                      ),
                      registerLink,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class FancyBackgroundDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: "Fancy Background",
      pathToFile: "fancy_background.dart",
      delayStartup: false,
      builder: (context) => (FancyBackgroundApp()),
    );
  }
}

Future<http.Response> apiRequest(String url, Map jsonMap) async {
  var body = json.encode(jsonMap);

  var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

  // print("${response.body}");
  return response;
}

_launchUrlRegister() async {
  const url = endpointRegister;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se pudo abrir $url';
  }
}

Text cuadroFlotanteTexto(String text, context) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Theme.of(context).iconTheme.color,
      fontSize: 20.0,
      // fontWeight: FontWeight.w800,
    ),
  );
}

AlertDialog cuadroFlotante(String text, context) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return new AlertDialog(
        title: Text(
          'MedicPUCP',
          style: TextStyle(
            color: Theme.of(context).iconTheme.color,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        // Retrieve the text the user has entered by using the
        // TextEditingController.
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              cuadroFlotanteTexto(text, context),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Acepto',
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      );
    },
  );
}
