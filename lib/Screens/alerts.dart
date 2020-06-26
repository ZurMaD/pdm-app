// import 'package:bmi_calculator/Screens/result_page.dart';
// import 'package:bmi_calculator/Utilities/app_util.dart';
import 'package:bmi_calculator/animations/animate_button.dart';
// import 'package:bmi_calculator/animations/size_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../calculator_brain.dart';
// import '../constants.dart';
import 'package:bmi_calculator/GlobalVariables/globals.dart';


enum GenderEnum {
  Male,
  Female,
}

class BMIMain2 extends StatefulWidget {
  @override
  _BMIMainState createState() => _BMIMainState();
}

class _BMIMainState extends State<BMIMain2> with SingleTickerProviderStateMixin {
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
                  Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),Text(
                    "xD",
                  ),
                  // Male/Female selection
                  // new Container(
                  //     child: new Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[new Male(), new Female()],
                  // )),
                  // new Height(),
                  // new Gender(),
                ],
              ),
            ),
            AnimatedLoader(
              animation: _controller,
              // alignment: FractionalOffset.center,
              child: Container(
                // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                // alignment: Alignment.bottomCenter,
                // child: MaterialButton(
                //   child: Text(
                //     'Calculate'.toUpperCase(),
                //     style: TextStyle(
                //         color: Color(0xFF013487),
                //         fontSize: 16.0,
                //         letterSpacing: 1),
                //   ),
                //   color: Color.fromRGBO(179, 157, 219, 0.4),
                //   elevation: 0.0,
                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                //   minWidth: 215.0,
                //   height: 62.0,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: new BorderRadius.circular(30.0)),
                //   onPressed: () {},
                // ),
              ),
            ),
            Container(
              // alignment: Alignment.bottomCenter,
              // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              // padding: EdgeInsets.all(11.0),
              // child: MaterialButton(
              //   child: Text(
              //     'Calculate'.toUpperCase(),
              //     style: TextStyle(
              //         color: Colors.white, fontSize: 16.0, letterSpacing: 1),
              //   ),
              //   color: Colors.deepPurple,
              //   elevation: 2.0,
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   minWidth: 200.0,
              //   height: 50.0,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: new BorderRadius.circular(30.0)),
              //   onPressed: () {
              //     CalculatorBrain calc;
              //     if (!isCentSelected)
              //       calc = CalculatorBrain(height: heightCal, weight: weight);
              //     else {
              //       calc = CalculatorBrain(
              //           height: AppUtil.feetInchToCM(feetValue, inchValue),
              //           weight: weight);
              //     }
              //     Navigator.push(
              //         context,
              //         SizeRoute(
              //             page: ResultPage(
              //           bmiResult: calc.calculateBMI(),
              //           resultText: calc.getResult(),
              //           resultTextStyle: calc.resultTextStyle(calc.getResult()),
              //           interpretation: calc.getInterpretation(),
              //         )));
              //   },
              // ),
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
