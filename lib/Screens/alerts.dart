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

class _BMIMainState extends State<BMIMain2>
    with SingleTickerProviderStateMixin {
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
          body: SafeArea(
        child: Container(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 74.0),
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: SizedBox.fromSize(
                  size: Size(MediaQuery.of(context).size.width, 150),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Notificación # 4 - Presión arterial alta',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            // color: Theme.of(context).accentColor,
                            color:Colors.red,
                          ),
                        ),
                        Text(
                          // age.toString(),                          
                          "Fecha y hora: 2020-06-22 00:00:00\n Usuario: Pablo Díaz \n Reportado a Central: Sí ",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
