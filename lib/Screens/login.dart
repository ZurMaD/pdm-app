import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localstorage/localstorage.dart';

import 'package:medicpucp/Screens/loader_drawer_menu.dart';
import 'package:medicpucp/Utilities/example_page.dart';

import 'package:http/http.dart' as http;

class FancyBackgroundApp extends StatelessWidget {

  final myControllerUser = TextEditingController();
  final myControllerPassword = TextEditingController();

  final LocalStorage storage = new LocalStorage('myStorageKey');
  

  void redireccionar(context, http.Response response) async {

    String token = response.body;

    storage.setItem('token', token);


    Navigator.push(context, MaterialPageRoute(builder: (context) => LoaderDrawerMenu()));
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

            debugPrint(myControllerUser.text);
            debugPrint(str);
            debugPrint(myControllerPassword.text);
            debugPrint(str2);

            final usernameText = myControllerUser.text;
            final passwordText = myControllerPassword.text;

            // var client = await oauth2.resourceOwnerPasswordGrant(
            //   authorizationEndpoint, username, password,
            //   identifier: identifier, secret: secret);
            String url = 'https://pdm3.herokuapp.com/auth/login/';
            Map map = {
              "username": "$usernameText",
              "password": "$passwordText"
            };
            debugPrint(map.toString());
            var response = await apiRequest(url, map);
            if (response.body.toString().contains("token")) {
              redireccionar(context, response);
            } else if (response.body.toString().contains("error")) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the user has entered by using the
                    // TextEditingController.
                    content: Text(
                      "Usuario o contraseña incorrectos.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.purpleAccent.shade700,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              );
            } else {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the user has entered by using the
                    // TextEditingController.
                    content: Text(
                      "Algo ha fallado en el servidor o la aplicación de manera interna. Contactar a soporte",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.purpleAccent.shade700,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the user has entered by using the
                  // TextEditingController.
                  content: Text(
                    "Usuario o contraseña incorrectos.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.purpleAccent.shade700,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                );
              },
            );
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

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.body}");
  return response;
}
