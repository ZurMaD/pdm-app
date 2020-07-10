// import 'dart:js';
// import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:medicpucp/Utilities/example_page.dart';
import 'package:supercharged/supercharged.dart';
import 'package:medicpucp/Screens/splash.dart';
import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'package:oauth2/oauth2.dart' as oauth2;

// class TokenAPI extends StatelessWidget {
//   final Map<String, dynamic> data;
//   TokenAPI(this.data);
//   Widget build(BuildContext context) {
//     double tokenAPI = data['token'];
//     return new Text(
//       '${tokenAPI.toString()} mmHg',
//       style: TextStyle(
//         fontSize: 10.0,
//         fontWeight: FontWeight.w900,
//         color: Theme.of(context).accentColor,
//       ),
//     );
//   }
// }

Future<http.Response> apiRequest(String url, Map jsonMap) async {
  var body = json.encode(jsonMap);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  print("${response.body}");
  return response;
}

class FancyBackgroundApp extends StatelessWidget {
  final myControllerUser = TextEditingController();
  final myControllerPassword = TextEditingController();
  // Future<http.Response> _response;

  // final authorizationEndpoint = Uri.parse("https://pdm3.herokuapp.com/auth/login/");

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
  }

  void redireccionar(context, http.Response response) async {
    navigateToSubPage(context);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    final userlField = TextField(
      key: Key('userlField'),
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

            // _response = (await http.post(
            //     'https://pdm3.herokuapp.com/auth/login/?username=' +
            //         myControllerUser.text +
            //         '&password=' +
            //         myControllerPassword.text)) as Future<http.Response>;

            // new FutureBuilder(
            //   future: _response,
            //   builder: (BuildContext context,
            //       AsyncSnapshot<http.Response> response) {
            // debugPrint(_response.data.body);
            // if (!_response.hasData) {
            //   // By default, show a loading spinner.
            //   CircularProgressIndicator();
            // }
            // // return new Text('Cargando...');
            // else if (_response.data.statusCode != 200) {
            //   new Text('No pudimos conectarnos al servidor');
            // } else {
            //   Map<String, dynamic> jsontoken = json.decode(_response.data.body);
            //   debugPrint(jsontoken.toString());
            //   if (jsontoken['token'] != '') {
            //     // return new TokenAPI(jsontoken);
            //     // var token= TokenAPI(jsontoken);
            //     // debugPrint(token.toString());
            //     navigateToSubPage(context);
            //   } else {
            //     Text('Error getting column, JSON is  $jsontoken.');
            //   }
            // }
            //   },
            // );
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
            // Positioned.fill(child: AnimatedBackground()),
            // onBottom(
            //   AnimatedWave(
            //     height: 180,
            //     speed: 1.0,
            //   ),
            // ),
            // onBottom(
            //   AnimatedWave(
            //     height: 120,
            //     speed: 0.9,
            //     offset: pi,
            //   ),
            // ),
            // onBottom(
            //   AnimatedWave(
            //     height: 220,
            //     speed: 1.2,
            //     offset: pi / 2,
            //   ),
            // ),
            // Positioned.fill(
            //   child: CenteredText(),
            // ),
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
                      userlField,
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

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimation<double>(
            duration: (5000 / speed).round().milliseconds,
            tween: 0.0.tweenTo(2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum _BgProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_BgProps>()
      ..add(
          _BgProps.color1, Color(0xffD38312).tweenTo(Colors.lightBlue.shade900))
      ..add(_BgProps.color2, Color(0xffA83279).tweenTo(Colors.blue.shade600));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 3.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                value.get(_BgProps.color1),
                value.get(_BgProps.color2)
              ])),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(),
    );
  }
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
