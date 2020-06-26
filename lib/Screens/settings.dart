import 'package:bmi_calculator/GlobalVariables/globals.dart';
import 'package:bmi_calculator/Utilities/my_theme_keys.dart';
// import 'package:bmi_calculator/Utilities/shared_preference_handler.dart';
import 'package:bmi_calculator/Utilities/theme_handler.dart';
// import 'package:bmi_calculator/components/single_choice_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:bmi_calculator/Screens/result_page.dart';
import 'package:bmi_calculator/Utilities/app_util.dart';
import 'package:bmi_calculator/animations/animate_button.dart';
import 'package:bmi_calculator/animations/size_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../calculator_brain.dart';
import '../constants.dart';
import 'package:bmi_calculator/GlobalVariables/globals.dart';

import 'package:bmi_calculator/Screens/alerts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> reportList = [
    "Centimetre",
    "Feet-Inch",
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0.0,
        //   title: Text(
        //     'Settings',
        //     textScaleFactor: 1.2,
        //     textDirection: TextDirection.ltr,
        //     textAlign: TextAlign.start,
        //     style: TextStyle(
        //         color: Theme.of(context).accentColor,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20.0),
        //   ),
        //   centerTitle: false,
        //   backgroundColor: Theme.of(context).primaryColorDark,
        // ),
        body: settingUI());
  }

  AnimationController _controller;

  Widget settingUI() {
    return Container(
      color: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          // Card(
          //   margin: EdgeInsets.all(10.0),
          //   elevation: 2.0,
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          //   child: Container(
          //     padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 30.0),
          //     decoration: BoxDecoration(
          //         color: Theme.of(context).cardColor,
          //         borderRadius: BorderRadius.circular(12.0),
          //         image: DecorationImage(
          //             image: AssetImage("Assets/Images/daynight.png"),
          //             fit: BoxFit.scaleDown)),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         Text(
          //           themeLabel,
          //           style: TextStyle(
          //               color: Theme.of(context).accentColor,
          //               fontSize: 16.0,
          //               fontWeight: FontWeight.w800),
          //         ),
          //         Switch(
          //           value: isDarkTheme,
          //           onChanged: (value) {
          //             setState(() {
          //               // isDarkTheme = value;
          //               if (isDarkTheme) {
          //                 isDarkTheme = false;
          //                 themeLabel = "Light Mode";
          //                 _changeTheme(context, MyThemeKeys.LIGHT);
          //                 SharedPreference.setStringValue(
          //                     SharedPreference.selectedTheme,
          //                     MyThemeKeys.LIGHT.toString());
          //               } else {
          //                 isDarkTheme = true;
          //                 themeLabel = "Dark Mode";
          //                 _changeTheme(context, MyThemeKeys.DARKER);
          //                 SharedPreference.setStringValue(
          //                     SharedPreference.selectedTheme,
          //                     MyThemeKeys.DARKER.toString());
          //               }
          //             });
          //           },
          //           inactiveTrackColor: Colors.grey.shade300,
          //           inactiveThumbColor: Colors.grey,
          //           activeTrackColor: Color.fromRGBO(209, 196, 233, 1),
          //           activeColor: Colors.deepPurple,
          //           materialTapTargetSize: MaterialTapTargetSize.padded,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Card(
            margin: EdgeInsets.all(20.0),
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Cambiar tiempo de muestreo",
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Presión cardíaca            ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                          ),
                          // MultiSelectChip(reportList),
                          new PresionCardiacaTM(),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Frecuencia respiratoria",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                          ),
                          // MultiSelectChip(reportList),
                          new PresionCardiacaTM(),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Temperatura corporal  ",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                          ),
                          // MultiSelectChip(reportList),
                          new PresionCardiacaTM(),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          'Guardar',
                          style: TextStyle(
                              color: Color(0xFF013487),
                              fontSize: 16.0,
                              letterSpacing: 1),
                        ),
                        color: Color.fromRGBO(179, 157, 219, 0.4),
                        elevation: 0.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        minWidth: 150.0,
                        height: 45.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
  CustomTheme.instanceOf(buildContext).changeTheme(key);
}

class PresionCardiacaTM extends StatefulWidget {
  @override
  _PresionCardiacaTMState createState() => _PresionCardiacaTMState();
}

class _PresionCardiacaTMState extends State<PresionCardiacaTM> {
  void decrese1() async {
    if (loopActive) return;

    loopActive = true;

    while (buttonPressed) {
      setState(() {
        if (age > 1) {
          age--;
        } else {}
      });
      await Future.delayed(
        Duration(milliseconds: 100),
      );
      decrese1();
    }
    loopActive = false;
  }

  void increse1() async {
    if (loopActive) return;

    loopActive = true;

    while (buttonPressed) {
      setState(() {
        age++;
      });
      await Future.delayed(
        Duration(milliseconds: 100),
      );
      increse1();
    }
    loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox.fromSize(
          size: Size(200, 75),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Theme.of(context).buttonColor,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.minus,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            if (age > 1) {
                              age--;
                            }
                          },
                        );
                      },
                      color: Colors.deepPurple,
                    ),
                  ),
                  onLongPressStart: (details) {
                    buttonPressed = true;
                    decrese1();
                  },
                  onLongPressUp: () {
                    buttonPressed = false;
                  },
                ),
                Text(
                  age.toString(),
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                GestureDetector(
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: Theme.of(context).buttonColor,
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.plus,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          age++;
                        });
                      },
                      color: Colors.deepPurple,
                    ),
                  ),
                  onLongPressStart: (details) {
                    buttonPressed = true;
                    increse1();
                  },
                  onLongPressUp: () {
                    buttonPressed = false;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
