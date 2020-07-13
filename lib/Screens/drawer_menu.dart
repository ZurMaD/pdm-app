import 'dart:convert';

import 'package:medicpucp/GlobalVariables/globals.dart';
import 'package:medicpucp/Screens/SubScreens/1.dart';
import 'package:medicpucp/Screens/SubScreens/about.dart';
import 'package:medicpucp/Screens/SubScreens/settings.dart';
import 'package:medicpucp/Screens/SubScreens/alerts.dart';
import 'package:medicpucp/Utilities/my_theme_keys.dart';
import 'package:medicpucp/Utilities/shared_preference_handler.dart';
import 'package:medicpucp/Utilities/theme_handler.dart';
import 'package:medicpucp/constants.dart';

import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class UserDataFromJSON extends StatelessWidget {
  // {
  //   "id": 2,
  //   "first_name": "Pablo",
  //   "last_name": "Dz V",
  //   "email": "pablo.dzv@gmail.com"
  // }
  final Map<String, dynamic> data;
  UserDataFromJSON(this.data);
  Widget build(BuildContext context) {
    int id = data['id'];
    String firstName = data['first_name'];
    String lastName = data['last_name'];
    String email = data['email'];
    String name = utf8.decode(firstName.runes.toList()) +
        ' ' +
        utf8.decode(lastName.runes.toList());

    return new Text(
      ' Usuario: ${name.toString()}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class UserKitDataFromJSON extends StatelessWidget {
  // {
  //     "kit_id": "AA0001",
  //     "user_id": 2,
  //     "estado_comunicacion": {
  //         "estado": "conectado y enviando data"
  //     },
  //     "estado_baterias": {
  //         "medikit": "80%",
  //         "mediband": "40%"
  //     },
  //     "tiempo_muestreo": {
  //         "t_pres_card": 150,
  //         "t_frec_resp": 20,
  //         "t_temp_corp": 1
  //     }
  // }
  final Map<String, dynamic> data;
  UserKitDataFromJSON(this.data);
  Widget build(BuildContext context) {
    String kitId = data['kit_id'];
    int userId = data['user_id'];

    String estadoComunicacionEstado = data['estado_comunicacion']['estado'];

    double estadoBateriaMedikit = data['estado_baterias']['medikit'];
    double estadoBateriaMediband = data['estado_baterias']['mediband'];

    double tiempoMuestreoTPresCard = data['tiempo_muestreo']['t_pres_card'];
    double tiempoMuestreoTFrecResp = data['tiempo_muestreo']['t_frec_resp'];
    double tiempoMuestreoTTempCorp = data['tiempo_muestreo']['t_temp_corp'];

    return new Text(
      ' Código Kit: ${kitId.toString()}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    super.initState();
    selectedMenuItemId = menu.items[0].id;
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

  final storage = LocalStorage('myStorageKey');

  Future<http.Response> apiGetUserData() async {
    String url = endpointGetDataUser;
    var tokenJson = storage.getItem('token');
    debugPrint(tokenJson);
    var body = tokenJson;

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print("${response.body}");
    return response;
  }

  Future<http.Response> apiGetKitData() async {
    String url =endpointGetUserKitData;
    var tokenJson = storage.getItem('token');
    debugPrint(tokenJson);
    var body = tokenJson;

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print("${response.body}");
    return response;
  }

  Widget headerView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
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
            " Aplicativo que brinda reporte del \n kit asociado al dispositivo.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          new FutureBuilder(
            future: apiGetUserData(),
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> response) {
              debugPrint(response.data.body);
              if (!response.hasData) {
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              } else if (response.data.statusCode != 200) {
                return new Text('No pudimos conectarnos al servidor');
              } else {
                Map<String, dynamic> json1 = json.decode(response.data.body);
                if (json1['id'] != 0) {
                  return new UserDataFromJSON(json1);
                } else {
                  return new Text('Error getting column, JSON is  $json1.');
                }
              }
            },
          ),
          new FutureBuilder(
            future: apiGetKitData(),
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> response) {
              debugPrint(response.data.body);
              if (!response.hasData) {
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              } else if (response.data.statusCode != 200) {
                return new Text('No pudimos conectarnos al servidor');
              } else {
                Map<String, dynamic> json4 = json.decode(response.data.body);
                if (json4['kit_id'] != '') {
                  storage.setItem('kit_id', json4['kit_id']);
                  return new UserKitDataFromJSON(json4);
                } else {
                  return new Text('Error getting column, JSON is  $json4.');
                }
              }
            },
          ),
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
          ),
        ],
      ),
    );
  }

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

  // void initMeasurementUnit() {
  // //   selectedChoice = SharedPreference.getStringValue(SharedPreference.selectedMUnit)??"";
  //   print(
  //     "chip ${SharedPreference.getStringValue(SharedPreference.selectedMUnit)}",
  //   );
  // }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
