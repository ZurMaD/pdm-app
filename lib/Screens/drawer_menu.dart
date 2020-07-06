import 'package:medicpucp/GlobalVariables/globals.dart';
import 'package:medicpucp/Screens/about.dart';
// import 'package:medicpucp/Screens/bmi_main.dart';
import 'package:medicpucp/Screens/settings.dart';
// import 'package:medicpucp/Utilities/app_util.dart';
import 'package:medicpucp/Utilities/my_theme_keys.dart';
import 'package:medicpucp/Utilities/shared_preference_handler.dart';
import 'package:medicpucp/Utilities/theme_handler.dart';
// import 'package:medicpucp/animations/size_transition.dart';
import 'package:medicpucp/constants.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:medicpucp/Screens/alerts.dart';
import 'package:medicpucp/Screens/SubScreens/1.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    selectedMenuItemId = menu.items[0].id;
    super.initState();
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  void getTheme() async {
    var key = await SharedPreference.getStringValue(
      SharedPreference.selectedTheme,
    );
    switch (key) {
      case "MyThemeKeys.LIGHT":
        isDarkTheme = false;
        themeIcon = Icon(
          FontAwesomeIcons.solidMoon,
          color: Colors.black38,
        );
        break;
      case "MyThemeKeys.DARKER":
        isDarkTheme = true;
        themeIcon = Icon(
          FontAwesomeIcons.solidSun,
        );
        break;
      default:
        isDarkTheme = false;
        themeIcon = Icon(
          FontAwesomeIcons.solidMoon,
          color: Colors.black38,
        );
        break;
    }
  }

  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'home',
        title: 'Inicio',
      ),
      new MenuItem(
        id: 'home2',
        title: 'Alertas',
      ),
      new MenuItem(
        id: 'setting',
        title: 'Configuraciones',
      ),
      new MenuItem(
        id: 'aboutapp',
        title: 'Soporte Técnico',
      ),
      // new MenuItem(id: 'share', title: 'Share App'),
      // new MenuItem(id: 'rateus', title: 'Rate App'),
      // new MenuItem(id: 'feedback', title: 'Send Feedback')
    ],
  );

  var selectedMenuItemId = 'home';
  // var _widget = Text("1");

  Widget headerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Image(
            image: AssetImage("Assets/Images/mp_launcher.png"),
            filterQuality: FilterQuality.high,
            width: 100.0,
            height: 100.0,
          ),
          Text(
            "MedicPUCP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            " Aplicativo que brinda reporte del kit asociado al dispositivo.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget footerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Desarrolado con ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
                size: 10,
              ),
              Text(
                "  por",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Text(""),
          GestureDetector(
            child: Row(
              children: <Widget>[
                // CircleAvatar(
                //   radius: 20.0,
                //   backgroundImage: AssetImage("Assets/Images/icon.png"),
                // ),
                Text(
                  "  PDM\n  Grupo3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "  &",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "  N\n  C",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // onTap: () {
            //   _launchURL();
            // },
          ),
        ],
      ),
    );
  }

  // _launchURL() async {
  //   const url = 'https://nividata.com';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
      percentage: 0, // porcentaje de maximizar ventana
      cornerRadius: 0, // 20 default
      showAppBar: true,
      appBar: AppBarProps(
        automaticallyImplyLeading: true,
        primary: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          'MedicPUCP',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            height: MediaQuery.of(context).size.height,
            child: IconButton(
              icon: themeIcon != null
                  ? themeIcon
                  : new Icon(
                      FontAwesomeIcons.solidMoon,
                      color: Colors.transparent,
                    ),
              onPressed: () {
                setState(
                  () {
                    if (isDarkTheme) {
                      isDarkTheme = false;
                      themeLabel = "Light Mode";
                      themeIcon = Icon(FontAwesomeIcons.solidMoon,
                          color: Colors.black38);
                      _changeTheme(context, MyThemeKeys.LIGHT);
                      SharedPreference.setStringValue(
                        SharedPreference.selectedTheme,
                        MyThemeKeys.LIGHT.toString(),
                      );
                    } else {
                      isDarkTheme = true;
                      themeLabel = "Dark Mode";
                      themeIcon = Icon(FontAwesomeIcons.solidSun);
                      _changeTheme(context, MyThemeKeys.DARKER);
                      SharedPreference.setStringValue(
                        SharedPreference.selectedTheme,
                        MyThemeKeys.DARKER.toString(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),

      menuView: new MenuView(
        menu: menu,
        headerView: headerView(context),
        footerView: footerView(context),
        animation: true,
        padding: EdgeInsets.fromLTRB(40.0, 16.0, 0.0, 10.0),
        color: Colors.black87,
        background: DecorationImage(
          image: AssetImage("Assets/Images/blood-pressure.jpg"),
          colorFilter: ColorFilter.mode(
            Colors.white54,
            BlendMode.dstOut,
          ),
          fit: BoxFit.cover,
        ),
        selectorColor: Color.fromRGBO(67, 193, 152, 1),
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
          color: Colors.white70,
        ),
        selectedItemId: selectedMenuItemId,
        onMenuItemSelected: (itemId) {
          setState(
            () {
              selectedMenuItemId = itemId;
            },
          );
        },
      ),

      contentView: new Screen(
        contentBuilder: (BuildContext context) {
          var example;
          switch (selectedMenuItemId) {
            case "home":
              // example = new BMIMain();
              example = new FirstPage();
              break;
            case "home2":
              example = new BMIMain2();
              break;
            case "setting":
              example = new Settings();
              break;
            case "aboutapp":
              example = new AboutUS();
              break;
            default:
              example = new Screen();
              break;
          }

          return example;
        },
        color: Colors.white,
      ),
    );
  }

  void initMeasurementUnit() {
    // selectedChoice = SharedPreference.getStringValue(SharedPreference.selectedMUnit)??"";
    print(
      "chip ${SharedPreference.getStringValue(SharedPreference.selectedMUnit)}",
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
