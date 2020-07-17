// import 'package:medicpucp/Screens/result_page.dart';
// import 'package:medicpucp/Utilities/app_util.dart';
// import 'package:medicpucp/animations/animate_button.dart';
// import 'package:medicpucp/animations/size_transition.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:localstorage/localstorage.dart';
import 'package:medicpucp/GlobalVariables/globals.dart';
import 'package:medicpucp/constants.dart';
import 'package:http/http.dart' as http;

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

  Future<http.Response> _response;
  final storage = LocalStorage('myStorageKey');

  Future<http.Response> apiGetNotificationsPerUser() async {
    String url = endpointGetNotificationsPerUser;
    var tokenJson = storage.getItem('token');
    debugPrint(tokenJson);
    var body = tokenJson;

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    // print("${response.body}");
    return response;
  }

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Row contents horizontally
                        crossAxisAlignment: CrossAxisAlignment
                            .center, //Center Row contents vertically
                        children: <Widget>[
                          new Text(
                            'Histórico de alertas emitidas',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          new IconButton(
                            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                            icon: FaIcon(FontAwesomeIcons.exclamation),
                            onPressed: () {
                              debugPrint("Pressed");
                            },
                          )
                        ],
                      ),
                      new FutureBuilder(
                        future: apiGetNotificationsPerUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> response) {
                          // debugPrint(response.data.body);
                          if (!response.hasData) {
                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          } else if (response.data.statusCode != 200) {
                            return new Text(
                                'No pudimos conectarnos al servidor');
                          } else {
                            Map<String, dynamic> jsonx =
                                json.decode(response.data.body);
                            if (jsonx['notifications'] != '') {
                              storage.setItem(
                                  'notifications', jsonx['notifications']);
                              return new NotificationDataPerUserFromJSON(jsonx);
                            } else {
                              return new Text(
                                  'Error getting column, JSON is  $jsonx.');
                            }
                          }
                        },
                      ),
                      new FutureBuilder(
                        future: apiGetNotificationsPerUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<http.Response> response) {
                          // debugPrint(response.data.body);
                          if (!response.hasData) {
                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          } else if (response.data.statusCode != 200) {
                            return new Text(
                                'No pudimos conectarnos al servidor');
                          } else {
                            Map<String, dynamic> jsonx =
                                json.decode(response.data.body);
                            if (jsonx['notifications'] != '') {
                              storage.setItem(
                                  'notifications', jsonx['notifications']);
                              return new NotificationDataPerUserFromJSON2(jsonx);
                            } else {
                              return new Text(
                                  'Error getting column, JSON is  $jsonx.');
                            }
                          }
                        },
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
  }
}

Card crearCardInfo(
    context, String titulo, String fecha, String valorConUnidad) {
  return new Card(
    elevation: 6.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: SizedBox.fromSize(
      size: Size(MediaQuery.of(context).size.width, 100),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    // color: Theme.of(context).accentColor,
                    color: Colors.red,
                  ),
                ),
                new SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          // age.toString(),
                          "Fecha y hora: $fecha",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        new Text(
                          // age.toString(),
                          "Valor registrado: $valorConUnidad",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class NotificationDataPerUserFromJSON extends StatelessWidget {
  final Map<String, dynamic> data;
  NotificationDataPerUserFromJSON(this.data);

  Widget build(BuildContext context) {
    try {
    var jsonDatax = JSONNotificationsLoader.fromJson(data);
    var fecha = jsonDatax.toJson()['notifications'][0]['pk'].toString();
    var data2 = jsonDatax
        .toJson()['notifications'][0]['fields']['json_notification']
        .toString();
    var dataFields = data2;
    var valorIndex = dataFields.indexOf('value');
    var valorRequerido =
        dataFields.substring(valorIndex + 8, valorIndex + 8 + 5);
    var tipoAlertaIndex = dataFields.indexOf('message');
    var tipoAlerta =
        dataFields.substring(tipoAlertaIndex + 11, tipoAlertaIndex + 11 + 30);
    var finalTipoAlerta = tipoAlerta.indexOf("'");
    var titu = tipoAlerta.substring(0, finalTipoAlerta);

    debugPrint(valorRequerido.toString());
    debugPrint(titu.toString());

    return crearCardInfo(context, '$titu', '$fecha', '$valorRequerido');
    } catch (e) {
      print(e);
    }
  }
}

class NotificationDataPerUserFromJSON2 extends StatelessWidget {
  final Map<String, dynamic> data;
  NotificationDataPerUserFromJSON2(this.data);

  Widget build(BuildContext context) {
      var jsonDatax = JSONNotificationsLoader.fromJson(data);
      var fecha = jsonDatax.toJson()['notifications'][3]['pk'].toString();
      var data2 = jsonDatax
          .toJson()['notifications'][3]['fields']['json_notification']
          .toString();
      var dataFields = data2;
      var valorIndex = dataFields.indexOf('value');
      var valorRequerido =
          dataFields.substring(valorIndex + 8, valorIndex + 8 + 5);
      var tipoAlertaIndex = dataFields.indexOf('message');
      var tipoAlerta =
          dataFields.substring(tipoAlertaIndex + 11, tipoAlertaIndex + 11 + 30);
      var finalTipoAlerta = tipoAlerta.indexOf("'");
      var titu = tipoAlerta.substring(0, finalTipoAlerta);

      debugPrint(valorRequerido.toString());
      debugPrint(titu.toString());

      return crearCardInfo(context, '$titu', '$fecha', '$valorRequerido');
  }
}

class JSONNotificationsLoader {
  List<Notifications> notifications;

  JSONNotificationsLoader({this.notifications});

  JSONNotificationsLoader.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String model;
  String pk;
  Fields fields;

  Notifications({this.model, this.pk, this.fields});

  Notifications.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields =
        json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fields != null) {
      data['fields'] = this.fields.toJson();
    }
    return data;
  }
}

class Fields {
  String jsonNotification;
  String kit;

  Fields({this.jsonNotification, this.kit});

  Fields.fromJson(Map<String, dynamic> json) {
    jsonNotification = json['json_notification'];
    kit = json['kit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['json_notification'] = this.jsonNotification;
    data['kit'] = this.kit;
    return data;
  }
}

class GrafanaNotificationLoader {
  int dashboardId;
  List<EvalMatches> evalMatches;
  String message;
  int orgId;
  int panelId;
  int ruleId;
  String ruleName;
  String ruleUrl;
  String state;
  Tags tags;
  String title;

  GrafanaNotificationLoader(
      {this.dashboardId,
      this.evalMatches,
      this.message,
      this.orgId,
      this.panelId,
      this.ruleId,
      this.ruleName,
      this.ruleUrl,
      this.state,
      this.tags,
      this.title});

  GrafanaNotificationLoader.fromJson(Map<String, dynamic> json) {
    dashboardId = json['dashboardId'];
    if (json['evalMatches'] != null) {
      evalMatches = new List<EvalMatches>();
      json['evalMatches'].forEach((v) {
        evalMatches.add(new EvalMatches.fromJson(v));
      });
    }
    message = json['message'];
    orgId = json['orgId'];
    panelId = json['panelId'];
    ruleId = json['ruleId'];
    ruleName = json['ruleName'];
    ruleUrl = json['ruleUrl'];
    state = json['state'];
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dashboardId'] = this.dashboardId;
    if (this.evalMatches != null) {
      data['evalMatches'] = this.evalMatches.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['orgId'] = this.orgId;
    data['panelId'] = this.panelId;
    data['ruleId'] = this.ruleId;
    data['ruleName'] = this.ruleName;
    data['ruleUrl'] = this.ruleUrl;
    data['state'] = this.state;
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    data['title'] = this.title;
    return data;
  }
}

class EvalMatches {
  double value;
  String metric;
  Null tags;

  EvalMatches({this.value, this.metric, this.tags});

  EvalMatches.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    metric = json['metric'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['metric'] = this.metric;
    data['tags'] = this.tags;
    return data;
  }
}

class Tags {
  String empty = '';

  Tags({this.empty});

  Tags.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
