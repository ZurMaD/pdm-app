import 'package:medicpucp/GlobalVariables/globals.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';

import 'package:medicpucp/constants.dart';

class AboutUS extends StatelessWidget {
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
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   centerTitle: false,
      //   title: Text(
      //     'About App',
      //     textScaleFactor: 1.2,
      //     textDirection: TextDirection.ltr,
      //     textAlign: TextAlign.start,
      //     style: TextStyle(
      //         color: Theme.of(context).accentColor,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 20.0),
      //   ),
      //   backgroundColor: Theme.of(context).primaryColorDark,
      // ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: bannerImg(context),
      ),
    );
  }

  Widget bannerImg(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            // height: 190.0,
            child: Image(
              image: AssetImage("Assets/Images/banner.jpg"),
              // height: 200.0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20.0, 210.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("Assets/Images/mp_launcher.png"),
                      height: 30.0,
                      width: 30.0,
                    ),
                    Text(
                      " MedicPUCP.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      " KitApp".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.grey.shade600),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  indent: 5.0,
                  endIndent: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 0.0),
                  child: Text(
                    prefix0.aboutBMI,
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.deepPurple,
                    child: Text("Leer más..."),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      LaunchReview.launch(
                          androidAppId: "com.pablogod.medicpucp",
                          iOSAppId: "id1488893444");
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Si tienes comentarios, sugerencias mandanos un mail a ",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w500),
                      ),
                      SelectableText(
                        "pablo.dzv@gmail.com",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
                  child: Text(
                    "V" + platformVersion,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                Text(
                  "Es la última versión de la aplicación",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 11.0,
                      color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
