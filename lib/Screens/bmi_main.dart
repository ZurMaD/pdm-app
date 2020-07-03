import 'dart:ui';

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

// HTTP JSON GET

import 'package:http/http.dart' as http;
import 'dart:convert';

enum GenderEnum {
  Male,
  Female,
}

class BMIMain extends StatefulWidget {
  @override
  _BMIMainState createState() => _BMIMainState();
}

class _BMIMainState extends State<BMIMain> with SingleTickerProviderStateMixin {
  //
  var btnVisibility = 1.0;
  GenderEnum selectedGender;

  // Icon icon = Icon(FontAwesomeIcons.solidSun);

  AnimationController _controller;

  @override
  initState() {
    super.initState();
    // isDarkTheme = false;

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedChoice == "Centimetre")
      isCentSelected = false;
    else
      isCentSelected = true;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return AnnotatedRegion(
      child: Scaffold(
          // drawer: Drawer(),
          body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 74.0),
              child: Column(
                children: <Widget>[
                  // Male/Female selection

                  new Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[],
                    ),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Male(),
                      new Female(),
                      new TemperaturaCorporal(),
                    ],
                  ),
                  // new Height(),
                  // new Gender(),
                ],
              ),
            ),
          ],
        )),
      )),
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}

class Male extends StatefulWidget {
  @override
  _MaleState createState() => _MaleState();
}

class _MaleState extends State<Male> {
  Future<DataJson> futuredata;

  var tempcorp;

  @override
  initState() {
    super.initState();
    futuredata = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.width / 1.2, 200),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('Assets/Images/heart.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     blurRadius: 10,
              //     color: Colors.black,
              //     offset: Offset(1, 3),
              //   ),
              // ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Presión cardíaca',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor),
                ),
                FutureBuilder<DataJson>(
                  future: futuredata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.presCard.toInt().toString(),
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
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

class Female extends StatefulWidget {
  @override
  _FemaleState createState() => _FemaleState();
}

class _FemaleState extends State<Female> {
  Future<DataJson> futuredata;

  var tempcorp;

  @override
  initState() {
    super.initState();
    futuredata = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.width / 1.2, 200),
          // size: Size(160, 200),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('Assets/Images/frec.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // ClipRect(child:BackdropFilter(
                //   filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                //   child: Container(
                //     alignment: Alignment.center,
                //     color: Colors.grey.withOpacity(0.1),
                //     child: Text(
                //       '',
                //       style:
                //           TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),),
                Text(
                  'Frecuencia respiratoria',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor),
                ),
                FutureBuilder<DataJson>(
                  future: futuredata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data.frecResp.toInt().toString(),
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
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

class Height extends StatefulWidget {
  @override
  _HeightState createState() => _HeightState();
}

class _HeightState extends State<Height> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            lengthSwitch(),
            handleSizeUI(),
          ],
        )),
      ),
    );
  }

  Widget handleSizeUI() {
    if (!isCentSelected)
      return centimeterView();
    else
      return feetInchView();
  }

//* Length unit switch (Centimetre or Ft)
  Widget lengthSwitch() {
    return Container(
      margin: EdgeInsets.fromLTRB(200.0, 10.0, 0.0, 0.0),
      height: 30.0,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 231, 246, 1),
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'cm',
            style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade700),
          ),
          Switch(
            value: isCentSelected,
            onChanged: (value) {
              setState(() {
                if (value)
                  selectedChoice = "Feet-Inch";
                else
                  selectedChoice = "Centimetre";
                isCentSelected = value;
              });
            },
            inactiveTrackColor: Color.fromRGBO(209, 196, 233, 1),
            inactiveThumbColor: Colors.deepPurple,
            activeTrackColor: Color.fromRGBO(209, 196, 233, 1),
            activeColor: Colors.deepPurple,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          Text(
            'ft',
            style: TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

//* CentimeterView
  Widget centimeterView() {
    return AnimatedOpacity(
      opacity: !isCentSelected ? 1.0 : 0.0,
      child: Container(
        height: 140.0,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            Text(
              'Height',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).accentColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  heightCal.toString(),
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  'cm',
                  style: kLabelTextStyle,
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.grey.shade300,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: Colors.deepPurple,
                overlayColor: Color(0x29EB1555),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
              ),
              child: Slider(
                value: heightCal.toDouble(),
                min: minHeight,
                max: maxHeight,
                onChanged: (double newValue) {
                  setState(() {
                    heightCal = newValue.round();
                  });
                },
              ),
            )
          ],
        ),
      ),
      curve: Curves.easeOutQuart,
      duration: Duration(milliseconds: 4000),
    );
  }

  Widget feetInchView() {
    return AnimatedOpacity(
      opacity: isCentSelected ? 1.0 : 0.0,
      child: Container(
        height: 140.0,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            Text(
              'Height\n',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).accentColor),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 90.0,
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: DropdownButton<int>(
                    isDense: true,
                    value: feetValue,
                    hint: Text('ft'),
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.grey,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    // isExpanded: true,
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (int newValue) {
                      setState(() {
                        feetValue = newValue;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          value.toString(),
                          style: TextStyle(fontSize: 40.0),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 90.0,
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: DropdownButton<String>(
                    isDense: true,
                    value: inchValue,
                    hint: Text('in'),
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.grey,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor),
                    underline: Container(
                      color: Colors.transparent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        inchValue = newValue;
                      });
                    },
                    items: <String>[
                      '0"',
                      '1"',
                      '2"',
                      '3"',
                      '4"',
                      '5"',
                      '6"',
                      '7"',
                      '8"',
                      '9"',
                      '10"',
                      '11"',
                      '12"'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 40.0),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      curve: Curves.easeOutQuart,
      duration: Duration(milliseconds: 4000),
    );
  }
}

class Gender extends StatefulWidget {
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6.0, 5.0, 6.0, 0.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          width: MediaQuery.of(context).size.height,
          height: Screen(MediaQuery.of(context).size).hp(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Género',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).accentColor),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Soy',
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor),
                    ),
                    Text(
                      'Mujer',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      inactiveTrackColor: Colors.grey.shade300,
                      inactiveThumbColor: Colors.deepPurple,
                      activeTrackColor: Colors.grey.shade300,
                      activeColor: Colors.deepPurple,
                    ),
                    Text(
                      'Hombre',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor),
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}

class TemperaturaCorporal extends StatefulWidget {
  @override
  _TemperaturaCorporalState createState() => _TemperaturaCorporalState();
}

class _TemperaturaCorporalState extends State<TemperaturaCorporal> {
  // JSON API
  Future<DataJson> futuredata;

  var tempcorp;

  @override
  initState() {
    super.initState();
    futuredata = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox.fromSize(
          size: Size(MediaQuery.of(context).size.width / 1.2, 200),
          // size: Size(160, 200),
          child: Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('Assets/Images/term.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Temperatura corporal',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                FutureBuilder<DataJson>(
                  future: futuredata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        (snapshot.data.tempCorp.toInt()).toString(),
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).accentColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
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

//  API JSON
class DataJson {
  String time;
  String kitId;
  double presCard;
  double frecResp;
  double tempCorp;
  double caidas;

  DataJson(
      {this.time,
      this.kitId,
      this.presCard,
      this.frecResp,
      this.tempCorp,
      this.caidas});

  DataJson.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    kitId = json['kit_id'];
    presCard = json['pres_card'];
    frecResp = json['frec_resp'];
    tempCorp = json['temp_corp'];
    caidas = json['caidas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['kit_id'] = this.kitId;
    data['pres_card'] = this.presCard;
    data['frec_resp'] = this.frecResp;
    data['temp_corp'] = this.tempCorp;
    data['caidas'] = this.caidas;
    return data;
  }
}

Future<DataJson> getData() async {
  final response = await http
      .get('https://pdm3.herokuapp.com/api/last_medic_hypertable/?format=json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DataJson.fromJson(json.decode(response.body)[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load DataJson');
  }
}
